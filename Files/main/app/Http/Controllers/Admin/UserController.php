<?php

namespace App\Http\Controllers\Admin;

use App\Models\User;
use App\Models\Deposit;
use App\Models\Category;
use App\Lib\FormProcessor;
use App\Models\Withdrawal;
use App\Models\Transaction;
use App\Models\WithdrawMethod;
use App\Constants\ManageStatus;
use App\Models\AdminNotification;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{
    function index() {
$pageTitle = 'Tutti gli utenti';        $users     = $this->userData();

        return view('admin.user.index', compact('pageTitle', 'users'));
    }

    function createCampain($id) {
        $user = User::findOrFail($id);
$pageTitle = 'Crea campagna per' . $user->firstname . " " . $user->lastname ;        $categories = Category::active()->get();
        return view('admin.campaign.create', compact('pageTitle', 'categories', 'user'));
    }


    function create(){
$pageTitle = 'Crea utente';        $info            = json_decode(json_encode(getIpInfo()), true);
        $mobileCode      = @implode(',', $info['code']);
        $countries       = json_decode(file_get_contents(resource_path('views/partials/country.json')));
        $registerContent = getSiteData('register.content', true);
        $policyPages     = getSiteData('policy_pages.element', false, null, true);
        return view('admin.user.create', compact('pageTitle', 'mobileCode', 'countries', 'registerContent', 'policyPages')) ;
    }

    function active() {
$pageTitle = 'Utenti attivi';        $users     = $this->userData('active');

        return view('admin.user.index', compact('pageTitle', 'users'));
    }

    function banned() {
$pageTitle = 'Utenti vietati';        $users     = $this->userData('banned');

        return view('admin.user.index', compact('pageTitle', 'users'));
    }

    function kycPending() {
$pageTitle = 'KYC in attesa degli utenti';        $users     = $this->userData('kycPending');

        return view('admin.user.index', compact('pageTitle', 'users'));
    }

    function kycUnConfirmed() {
$pageTitle = 'Utenti KYC non confermati';        $users     = $this->userData('kycUnconfirmed');

        return view('admin.user.index', compact('pageTitle', 'users'));
    }

    function emailUnConfirmed() {
$pageTitle = 'Email utenti non confermati';        $users     = $this->userData('emailUnconfirmed');

        return view('admin.user.index', compact('pageTitle', 'users'));
    }

    function mobileUnConfirmed() {
$pageTitle = 'Utenti mobili non confermati';        $users     = $this->userData('mobileUnconfirmed');

        return view('admin.user.index', compact('pageTitle', 'users'));
    }

    function details($id) {
        $user = User::withCount([
            'campaigns as pending_campaigns'  => fn ($query) => $query->pending(),
            'campaigns as approved_campaigns' => fn ($query) => $query->approve(),
            'campaigns as rejected_campaigns' => fn ($query) => $query->reject(),
        ])->findOrFail($id);

$pageTitle              = 'Dettagli -' . $user->username;        $campaigns              = $user->campaigns->pluck('id');
        $totalReceivedDonation  = Deposit::whereIn('campaign_id', $campaigns)->done()->sum('amount');
        $totalWithdrawal        = $user->withdrawals()->done()->sum('amount');
        $totalGivenDonation     = $user->deposits()->done()->sum('amount');
        $totalTransactions      = $user->transactions->count();
        $totalPendingCampaigns  = $user->pending_campaigns;
        $totalApprovedCampaigns = $user->approved_campaigns;
        $totalRejectedCampaigns = $user->rejected_campaigns;
        $countries              = json_decode(file_get_contents(resource_path('views/partials/country.json')));

        return view('admin.user.details', compact('pageTitle', 'user', 'totalReceivedDonation', 'totalWithdrawal', 'totalGivenDonation', 'totalTransactions', 'totalPendingCampaigns', 'totalApprovedCampaigns', 'totalRejectedCampaigns', 'countries'));
    }

    function update($id) {
        $user         = User::findOrFail($id);
        $countryData  = json_decode(file_get_contents(resource_path('views/partials/country.json')));
        $countryArray = (array)$countryData;
        $countries    = implode(',', array_keys($countryArray));
        $countryCode  = request('country');
        $country      = $countryData->$countryCode->country;
        $dialCode     = $countryData->$countryCode->dial_code;

        $this->validate(request(), [
            'firstname' => 'required|string|max:40',
            'lastname'  => 'required|string|max:40',
            'email'     => 'required|email|string|max:40|unique:users,email,' . $user->id,
            'mobile'    => 'required|string|max:40|unique:users,mobile,' . $user->id,
            'country'   => 'required|in:' . $countries,
        ]);

        $user->mobile       = $dialCode . request('mobile');
        $user->country_name = $country;
        $user->country_code = $countryCode;
        $user->firstname    = request('firstname');
        $user->lastname     = request('lastname');
        $user->email        = request('email');
        $user->ec           = request('ec') ? ManageStatus::VERIFIED : ManageStatus::UNVERIFIED;
        $user->sc           = request('sc') ? ManageStatus::VERIFIED : ManageStatus::UNVERIFIED;
        $user->ts           = request('ts') ? ManageStatus::ACTIVE   : ManageStatus::INACTIVE;
        $user->address      = [
            'city'    => request('city'),
            'state'   => request('state'),
            'zip'     => request('zip'),
            'country' => @$country,
        ];

        if (!request('kc')) {
            $user->kc = ManageStatus::UNVERIFIED;

            if ($user->kyc_data) {
                foreach ($user->kyc_data as $kycData) {
                    if ($kycData->type == 'file') fileManager()->removeFile(getFilePath('verify') . '/' . $kycData->value);
                }
            }

            $user->kyc_data = null;
        } else {
            $user->kc = ManageStatus::VERIFIED;
        }

        $user->save();

        $toast[] = ['success', 'User details updated successfully'];

        return back()->withToasts($toast);
    }

    function login($id) {
        Auth::loginUsingId($id);

        return to_route('user.home');
    }

    function balanceUpdate($id) {
        $this->validate(request(), [
            'amount' => 'required|numeric|gt:0',
            'act'    => 'required|in:add,sub',
            'remark' => 'required|string|max:255',
        ]);

        $user   = User::findOrFail($id);
        $amount = request('amount');
        $trx    = getTrx();

        $transaction = new Transaction();

        if (request('act') == 'add') {
            $user->balance        += $amount;
            $transaction->trx_type = '+';
            $transaction->remark   = 'balance_add';
            $notifyTemplate        = 'BAL_ADD';

            $toast[] = ['success', 'The amount of ' . bs('cur_sym') . $amount . ' has been added successfully'];
        } else {
            if ($amount > $user->balance) {
                $toast[] = ['error', $user->username . ' doesn\'t have sufficient balance'];

                return back()->withToasts($toast);
            }

            $user->balance        -= $amount;
            $transaction->trx_type = '-';
            $transaction->remark   = 'balance_subtract';
            $notifyTemplate        = 'BAL_SUB';

            $toast[] = ['success', 'The amount of ' . bs('cur_sym') . $amount . ' has been subtracted successfully'];
        }

        $user->save();

        $transaction->user_id      = $user->id;
        $transaction->amount       = $amount;
        $transaction->post_balance = $user->balance;
        $transaction->charge       = 0;
        $transaction->trx          =  $trx;
        $transaction->details      = request('remark');
        $transaction->save();

        notify($user, $notifyTemplate, [
            'trx'          => $trx,
            'amount'       => showAmount($amount),
            'remark'       => request('remark'),
            'post_balance' => showAmount($user->balance),
        ]);

        return back()->withToasts($toast);
    }

    function status($id) {
        $user = User::findOrFail($id);

        if ($user->status == ManageStatus::ACTIVE) {
            $this->validate(request(), [
                'ban_reason' => 'required|string|max:255',
            ]);

            $user->status     = ManageStatus::INACTIVE;
            $user->ban_reason = request('ban_reason');
            $toast[]          = ['success', 'User banned successfully'];
        } else {
            $user->status     = ManageStatus::ACTIVE;
            $user->ban_reason = null;
            $toast[]          = ['success', 'User unbanned successfully'];
        }

        $user->save();

        return back()->withToasts($toast);
    }

    function kycApprove($id) {
        $user     = User::findOrFail($id);
        $user->kc = ManageStatus::VERIFIED;
        $user->save();

        notify($user, 'KYC_APPROVE', []);

        $toast[] = ['success', 'KYC approval success'];

        return back()->withToasts($toast);
    }

    function kycCancel($id) {
        $user = User::findOrFail($id);

        foreach ($user->kyc_data as $kycData) {
            if ($kycData->type == 'file') fileManager()->removeFile(getFilePath('verify') . '/' . $kycData->value);
        }

        $user->kc       = ManageStatus::UNVERIFIED;
        $user->kyc_data = null;
        $user->save();

        notify($user, 'KYC_REJECT', []);

        $toast[] = ['success', 'KYC cancellation success'];

        return back()->withToasts($toast);
    }

    protected function userData($scope = null) {
        if ($scope) $users = User::$scope();
        else $users = User::query();

        return $users->searchable(['username', 'email'])->dateFilter()->latest()->paginate(getPaginate());
    }

    function withdraw($id) {
        $user = User::findOrFail($id);
        $pageTitle = 'Ritirare';        
        $methods   = WithdrawMethod::active()->get();
        return view('admin.user.withdraw', compact('pageTitle', 'methods', 'user'));
    }

    function storeWithdraw($id) {
        $this->validate(request(), [
            'method_id' => 'required|int|gt:0',
            'amount'    => 'required|numeric|gt:0'
        ]);

        $user   = User::findOrFail($id);
        $amount = request('amount');
        $method = WithdrawMethod::where('id', request('method_id'))->active()->firstOrFail();

        if ($amount < $method->min_amount) {
            $toast[] = ['error', 'The requested amount is below the minimum allowable amount'];
            return back()->withToasts($toast);
        }

        if ($amount > $method->max_amount) {
            $toast[] = ['error', 'The requested amount exceeds the maximum allowable amount'];
            return back()->withToasts($toast);
        }

        if ($amount > $user->balance) {
            $toast[] = ['error', 'You lack the necessary balance to process a withdrawal'];
            return back()->withToasts($toast);
        }

        $charge      = $method->fixed_charge + ($amount * $method->percent_charge / 100);
        $afterCharge = $amount - $charge;
        $finalAmount = $afterCharge * $method->rate;

        $withdraw               = new Withdrawal();
        $withdraw->method_id    = $method->id;
        $withdraw->user_id      = $user->id;
        $withdraw->amount       = $amount;
        $withdraw->currency     = $method->currency;
        $withdraw->rate         = $method->rate;
        $withdraw->charge       = $charge;
        $withdraw->final_amount = $finalAmount;
        $withdraw->after_charge = $afterCharge;
        $withdraw->trx          = getTrx();

        $formData       = $method->form->form_data;
        $formProcessor  = new FormProcessor();
        $validationRule = $formProcessor->valueValidation($formData);
        request()->validate($validationRule);
        $userData = $formProcessor->processFormData(request(), $formData);

        $withdraw->status = ManageStatus::PAYMENT_SUCCESS;
        $withdraw->withdraw_information = $userData;
        $withdraw->save();

        $user->balance -=  $withdraw->amount;
        $user->save();

        $transaction               = new Transaction();
        $transaction->user_id      = $withdraw->user_id;
        $transaction->amount       = $withdraw->amount;
        $transaction->post_balance = $user->balance;
        $transaction->charge       = $withdraw->charge;
        $transaction->trx_type     = '-';
        $transaction->details      = showAmount($withdraw->final_amount) . ' ' . $withdraw->currency . ' Withdraw Via ' . $withdraw->method->name;
        $transaction->trx          = $withdraw->trx;
        $transaction->remark       = 'withdraw';
        $transaction->save();

        notify($user, 'WITHDRAW_APPROVE', [
            'method_name'     => $withdraw->method->name,
            'method_currency' => $withdraw->currency,
            'method_amount'   => showAmount($withdraw->final_amount),
            'amount'          => showAmount($withdraw->amount),
            'charge'          => showAmount($withdraw->charge),
            'rate'            => showAmount($withdraw->rate),
            'trx'             => $withdraw->trx,
            'admin_details'   => null
        ]);

        $toast[] = ['success', 'Withdrawal approved successfully'];
        return redirect()->route('admin.user.details', $user->id)->withToasts($toast);
    }
}
