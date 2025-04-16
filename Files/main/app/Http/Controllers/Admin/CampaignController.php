<?php

namespace App\Http\Controllers\Admin;

use App\Models\Comment;
use App\Models\Campaign;
use App\Models\Category;
use App\Constants\ManageStatus;
use App\Http\Controllers\Controller;
use App\Models\Deposit;

class CampaignController extends Controller
{
    function index() {
$pageTitle = 'Tutte le campagne';        $campaigns = $this->campaignData();

        return view('admin.campaign.index', compact('pageTitle', 'campaigns'));
    }

    function pending() {
$pageTitle = 'Campagne in sospeso';        $campaigns = $this->campaignData('pending');

        return view('admin.campaign.index', compact('pageTitle', 'campaigns'));
    }

    function approved() {
$pageTitle = 'Campagne approvate';        $campaigns = $this->campaignData('approve');

        return view('admin.campaign.index', compact('pageTitle', 'campaigns'));
    }

    function rejected() {
$pageTitle = 'Campagne rifiutate';        $campaigns = $this->campaignData('reject');

        return view('admin.campaign.index', compact('pageTitle', 'campaigns'));
    }

    function running() {
$pageTitle = 'Campagne di gestione';        $campaigns = $this->campaignData('running');

        return view('admin.campaign.index', compact('pageTitle', 'campaigns'));
    }

    function expired() {
$pageTitle = 'Campagne scadute';        $campaigns = $this->campaignData('expired');

        return view('admin.campaign.index', compact('pageTitle', 'campaigns'));
    }

    function upcoming() {
$pageTitle = 'Campagne imminenti';        $campaigns = $this->campaignData('upcoming');

        return view('admin.campaign.index', compact('pageTitle', 'campaigns'));
    }

    protected function campaignData($scope = null) {
        if ($scope) $campaigns = Campaign::$scope();
        else $campaigns = Campaign::query();

        return $campaigns->with(['user', 'category'])->searchable(['name', 'category:name', 'user:username'])->latest()->paginate(getPaginate());
    }

    function details($id) {
$pageTitle  = 'Dettagli della campagna';        $backRoute  = route('admin.campaigns.index');
        $campaign   = Campaign::findOrFail($id);

        
        $totalDonor = $campaign->deposits()->done()->count();
        //$transactions = $campaign->deposits()->done()->get()->dd();
        $transactions = $campaign->deposits()->done()->get();
        $comments   = $campaign->comments()->with('user')->paginate(getPaginate());

        return view('admin.campaign.details', compact('pageTitle', 'backRoute', 'campaign', 'comments', 'totalDonor','transactions'));
    }

    function updateStatus($id, $type) {
        $campaign         = Campaign::findOrFail($id);
        $campaign->status = ($type == 'approve') ? ManageStatus::CAMPAIGN_APPROVED : ManageStatus::CAMPAIGN_REJECTED;
        $campaign->save();

        $template = ($type == 'approve') ? 'CAMPAIGN_APPROVE' : 'CAMPAIGN_REJECT';

        notify($campaign->user, $template, [
            'campaign_name' => $campaign->name,
        ]);

        $toastMsg = ($type == 'approve') ? 'Campaign approval success' : 'Campaign rejection success';

        $toast[] = ['success', $toastMsg];

        return back()->withToasts($toast);
    }

    function updateFeatured($id) {
        return Campaign::changeStatus($id, 'featured');
    }
}
