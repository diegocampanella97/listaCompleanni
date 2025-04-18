@extends($activeTheme . 'layouts.frontend')

@section('frontend')
    <div class="contact py-120">
        <div class="container">
            <div class="row justify-content-center" data-aos="fade-up" data-aos-duration="1500">
                <div class="col-lg-6">
                    <div class="section-heading text-center">
                        <h2 class="section-heading__title mx-auto">{{ __(@$contactContent->data_info->section_heading) }}</h2>
                        <p class="section-heading__desc">{{ __(@$contactContent->data_info->description) }}</p>
                    </div>
                </div>
            </div>
            <div class="row gy-5 justify-content-lg-around justify-content-center">
                <div class="col-12">
                    <div class="row g-4">
                        @foreach ($contactElements as $contact)
                            <div class="col-lg-4 col-sm-6">
                                <div class="custom--card contact__info__card" data-aos="fade-up" data-aos-duration="1500">
                                    <div class="card-body">
                                        <h3 class="contact__info__title card-subtitle mb-2">@php echo $contact->data_info->icon @endphp {{ __(@$contact->data_info->heading) }}:</h3>
                                        <p>{{ __(@$contact->data_info->data) }}</p>
                                    </div>
                                </div>
                            </div>
                        @endforeach
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="card custom--card" data-aos="fade-up" data-aos-duration="1500">
                        <div class="card-header">
                            <h3 class="title">Siamo qui per te, scrivici!</h3>
                        </div>
                        <div class="card-body">
                            <form action="" method="POST" class="row g-3">
                                @csrf
                                <div class="col-sm-6">
                                    <label class="form--label required">@lang('Your Full Name')</label>
                                    <input type="text" name="name" class="form--control" value="{{ old('name', @$user->fullname) }}" @readonly(@$user) required>
                                </div>
                                <div class="col-sm-6">
                                    <label class="form--label required">@lang('Your Email')</label>
                                    <input type="email" name="email" class="form--control" value="{{ old('email', @$user->email) }}" @readonly(@$user) required>
                                </div>
                                <div class="col-sm-6">
                                    <label class="form--label">@lang('Numero di Telefono')</label>
                                    <input type="tel" name="phone" class="form--control" value="{{ old('phone', @$user->phone) }}">
                                </div>
                                <div class="col-sm-6">
                                    <label class="form--label required">@lang('Subject')</label>
                                    <input type="text" name="subject" class="form--control" value="{{ old('subject') }}" required>
                                </div>
                                <div class="col-12">
                                    <label class="form--label required">@lang('Message')</label>
                                    <textarea name="message" class="form--control" rows="10" required>{{ old('message') }}</textarea>
                                </div>
                                <div class="col-12">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="gdpr_consent" id="gdpr_consent" required>
                                        <label class="form-check-label" for="gdpr_consent">
                                            Acconsento al trattamento dei miei dati personali secondo la <a href="/policy/privacy-policy/11" target="_blank">normativa GDPR</a>
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <button type="submit" class="btn btn--base">{{ __(@$contactContent->data_info->form_button_name) }}</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="contact__map-card custom--card" data-aos="fade-up" data-aos-duration="1500">
                        <div class="card-body">
                            <div class="contact__map">
                                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d6029.840134326967!2d17.014690676644516!3d40.917498471363324!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x1347b92f41a1c885%3A0x1a5e6b61173cdd30!2sVierre%20Viaggi!5e0!3m2!1sit!2sit!4v1744977913085!5m2!1sit!2sit" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
