@extends('admin.layouts.master')

@section('master')
<section class="">
    <div class="container">
        <div class="row justify-content-md-between justify-content-center align-items-center">
            <div class="col-xl-5 col-lg-6 col-md-7">

                <div class="account-form">
                    <div class="account-form__content mb-4">
                        <h3 class="account-form__title mb-2">{{ __(@$registerContent->data_info->form_heading) }}</h3>
                    </div>
                    <form action="{{ route('user.registerCustom') }}" method="POST" class="verify-gcaptcha">
                        @csrf
                        <div class="row g-3">
                            <div class="col-sm-6">
                                <label class="form--label required">@lang('First Name')</label>
                                <input type="text" class="form--control" name="firstname" value="{{ old('firstname') }}" required>
                            </div>
                            <div class="col-sm-6">
                                <label class="form--label required">@lang('Last Name')</label>
                                <input type="text" class="form--control" name="lastname" value="{{ old('lastname') }}" required>
                            </div>
                            <div class="col-sm-6">
                                <label class="form--label required">@lang('Username')</label>
                                <input type="text" class="form--control checkUser" name="username" value="{{ old('username') }}" required>
                                <small class="text-danger usernameExist"></small>
                            </div>
                            <div class="col-sm-6">
                                <label class="form--label required">@lang('Email Address')</label>
                                <input type="email" class="form--control checkUser" name="email" value="{{ old('email') }}" required>
                                <small class="text-danger emailExist"></small>
                            </div>
                            <div class="col-sm-6">
                                <label class="form--label required">@lang('Country')</label>
                                <select name="country" class="form--control form-select" required>
                                    @foreach ($countries as $key => $country)
                                        <option data-mobile_code="{{ $country->dial_code }}" value="{{ $country->country }}" data-code="{{ $key }}">
                                            {{ __(@$country->country) }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col-sm-6">
                                <label class="form--label required">Telefono</label>
                                <div class="input--group">
                                    <span class="input-group-text input-group-text-light mobile-code">+39</span>
                                    <input type="hidden" name="mobile_code" value="39">
                                    <input type="hidden" name="country_code" value="IT">
                                    <input type="number" class="form--control checkUser" name="mobile" value="" required="" data-dashlane-rid="73348785af7da958" data-dashlane-classification="phone" data-kwimpalastatus="alive" data-kwimpalaid="1743849886919-4">
                                </div>
                                <small class="text-danger mobileExist"></small>
                            </div>
                            <div class="col-sm-6">
                                <label class="form--label required">@lang('Password')</label>
                                <div class="position-relative">
                                    <input type="password" class="form-control form--control @if ($setting->strong_pass) secure-password @endif" name="password" id="your-password" required>
                                    <span class="password-show-hide ti ti-eye toggle-password" id="#your-password"></span>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <label class="form--label required">@lang('Confirm Password')</label>
                                <div class="position-relative">
                                    <input type="password" class="form-control form--control" name="password_confirmation" id="confirm-password" required>
                                    <span class="password-show-hide ti ti-eye toggle-password" id="#confirm-password"></span>
                                </div>
                            </div>

                            @if ($setting->agree_policy)
                                <div class="col-sm-12 d-none">
                                    <div class="form--check">
                                        <input type="checkbox" checked class="form-check-input" name="agree" id="agree" @checked(old('agree')) required>
                                        <label for="agree" class="form-check-label">@lang('I agree with') @foreach ($policyPages as $policy) <a href="{{ route('policy.pages', [slug($policy->data_info->title), $policy->id]) }}" target="_blank">{{ __($policy->data_info->title) }}</a>@if (!$loop->last), @endif @endforeach</label>
                                    </div>
                                </div>
                            @endif

                            <x-captcha />

                            <div class="col-sm-12">
                                <button type="submit" class="btn btn--base w-100" id="recaptcha">
                                    Registra Utente
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
@endsection