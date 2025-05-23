<?php

namespace App\Http\Controllers\User\Auth;

use App\Constants\ManageStatus;
use App\Http\Controllers\Controller;
use App\Models\AdminNotification;
use App\Models\User;
use Illuminate\Auth\Events\Registered;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rules\Password;
use Illuminate\Foundation\Auth\RegistersUsers;
use Illuminate\Support\Facades\Hash;

class RegisterControllerCustom extends Controller
{
    use RegistersUsers;

    function registerForm() {
$pageTitle       = 'Registro';        $info            = json_decode(json_encode(getIpInfo()), true);
        $mobileCode      = @implode(',', $info['code']);
        $countries       = json_decode(file_get_contents(resource_path('views/partials/country.json')));
        $registerContent = getSiteData('register.content', true);
        $policyPages     = getSiteData('policy_pages.element', false, null, true);

        return view($this->activeTheme . 'user.auth.register', compact('pageTitle', 'mobileCode', 'countries', 'registerContent', 'policyPages'));
    }

    protected function validator(array $data) {
        $setting = bs();
        $passwordValidation = Password::min(6);

        if ($setting->strong_pass) {
            $passwordValidation = $passwordValidation->mixedCase()->numbers()->symbols()->uncompromised();
        }

        $agree = 'nullable';

        if ($setting->agree_policy) {
            $agree = 'required';
        }

        $countryData  = (array)json_decode(file_get_contents(resource_path('views/partials/country.json')));
        $countryCodes = implode(',', array_keys($countryData));
        $mobileCodes  = implode(',',array_column($countryData, 'dial_code'));
        $countries    = implode(',',array_column($countryData, 'country'));
        $validate     = Validator::make($data, [
            'firstname'    => 'required|string|max:40',
            'lastname'     => 'required|string|max:40',
            'email'        => 'required|string|email|max:40|unique:users',
            'mobile'       => 'required|max:40|regex:/^([0-9]*)$/',
            'password'     => ['required', 'confirmed', $passwordValidation],
            'username'     => 'required|unique:users|min:6|max:40',
            'mobile_code'  => 'required|in:'.$mobileCodes,
            'country_code' => 'required|in:'.$countryCodes,
            'country'      => 'required|in:'.$countries,
            'agree'        => $agree
        ]);

        return $validate;
    }

    function registerCustom() {
        $this->validator(request()->all())->validate();

        request()->session()->regenerateToken();

        if(!verifyCaptcha()) {
            $toast[] = ['error', 'Invalid captcha provided'];
            return back()->withToasts($toast);
        }

        if(preg_match("/[^a-z0-9_]/", trim(request('username')))) {
            $toast[] = ['info', 'Usernames are limited to lowercase letters, numbers, and underscores'];
            $toast[] = ['error', 'Username must exclude special characters, spaces, and capital letters'];
            return back()->withToasts($toast)->withInput(request()->all());
        }

        $exist = User::where('mobile', request('mobile_code') . request('mobile'))->first();

        if ($exist) {
            $toast[] = ['error', 'That mobile number is already on our records'];
            return back()->withToasts($toast)->withInput();
        }

        event(new Registered($user = $this->create(request()->all())));

        $this->guard()->login($user);

        return $this->registered(request(), $user) ? : redirect($this->redirectPath());
    }

    protected function create(array $data)
    {
        $setting = bs();
        $referBy = session()->get('reference');

        if ($referBy) {
            $referUser = User::where('username', $referBy)->first();
        } else {
            $referUser = null;
        }
  
        // User Create
        $user               = new User();
        $user->firstname    = $data['firstname'];
        $user->lastname     = $data['lastname'];
        $user->email        = strtolower($data['email']);
        $user->password     = Hash::make($data['password']);
        $user->username     = $data['username'];
        $user->ref_by       = $referUser ? $referUser->id : 0;
        $user->country_code = $data['country_code'];
        $user->country_name = isset($data['country']) ? $data['country'] : null;
        $user->mobile       = $data['mobile_code'].$data['mobile'];
        $user->kc           = 1;
        $user->ec           = 1;
        $user->sc           = $setting->sc ? ManageStatus::NO : ManageStatus::YES;
        $user->ts           = ManageStatus::NO;
        $user->tc           = ManageStatus::YES;

        $user->save();


        $adminNotification            = new AdminNotification();
        $adminNotification->user_id   = $user->id;
        $adminNotification->title     = 'New member registered';
        $adminNotification->click_url = urlPath('admin.user.index');
        $adminNotification->save();

        return $user;
    }

    function checkUser(){
        $exist['data'] = false;
        $exist['type'] = null;

        if (request('email')) {
            $exist['data'] = User::where('email', request('email'))->exists();
            $exist['type'] = 'email';
        }
        if (request('mobile')) {
            $exist['data'] = User::where('mobile', request('mobile'))->exists();
            $exist['type'] = 'mobile';
        }
        if (request('username')) {
            $exist['data'] = User::where('username', request('username'))->exists();
            $exist['type'] = 'username';
        }
        return response($exist);
    }

    function registered()
    {
        return redirect()->route('admin.user.index')->with([
            'success' => 'Registration successful. Please check your email for verification.',
        ]);
    }
}