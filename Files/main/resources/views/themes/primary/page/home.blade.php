@extends($activeTheme . 'layouts.frontend')

@section('frontend')
    @php
        $commonSliderImage = asset($activeThemeTrue . 'images/slider-img-shape-2.png');
        $commonShapeImage  = asset($activeThemeTrue . 'images/mask-shape-1.png');
    @endphp

    <section class="banner-section">
        <div class="banner-slider">
            @foreach ($bannerElements as $banner)
                <div class="banner-slider__slide bg-img" data-background-image="{{ getImage('assets/images/site/banner/' . @$banner->data_info->background_image, '1920x1080') }}">
                    <div class="container">
                        <div class="row align-items-center justify-content-center">
                            <div class="col-lg-6 col-md-7">
                                <div class="banner-content">
                                    <h4 class="banner-content__subtitle">{{ __(@$banner->data_info->title) }}</h4>
                                    <h1 class="banner-content__title">{{ __(@$banner->data_info->heading) }}</h1>
                                    <p class="banner-content__desc">{{ __(@$banner->data_info->short_description) }}</p>
                                    <div class="banner-content__button d-flex gap-3 flex-wrap">
                                        <a href="{{ @$banner->data_info->first_button_url }}" class="btn btn--base" target="_blank">
                                            {{ __(@$banner->data_info->first_button_text) }}
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-5 col-sm-10">
                                <div class="banner-img">
                                    <img class="bg-img" data-background-image="{{ $commonSliderImage }}" data-mask-image="{{ $commonSliderImage }}" src="{{ getImage('assets/images/site/banner/' . @$banner->data_info->background_image, '1920x1080') }}" alt="image">
                                    <span class="banner-img__mask" data-mask-image="{{ $commonSliderImage }}"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            @endforeach
        </div>
    </section>

    @include($activeTheme . 'sections.about')

    @include($activeTheme . 'sections.partner')
@endsection

@push('page-style-lib')
    <link rel="stylesheet" href="{{ asset($activeThemeTrue . 'css/odometer.css') }}">
@endpush

@push('page-script-lib')
    <script src="{{ asset($activeThemeTrue . 'js/odometer.min.js') }}"></script>
@endpush

@push('page-script')
    <script>
        'use strict';

        (function ($) {
            $('.subscribeBtn').on('click',function () {
                let email = $('[name=subscriber_email]').val();
                let csrf  = '{{csrf_token()}}';
                let url   = "{{ route('subscriber.store') }}";
                let data  = {email:email, _token:csrf};

                $.post(url, data,function(response) {
                    if(response.success){
                        showToasts('success', response.success);
                        $('[name=subscriber_email]').val('');
                    }else{
                        showToasts('error', response.error);
                    }
                });
            });
        })(jQuery);
    </script>
@endpush
