@extends($activeTheme . 'layouts.frontend')

@section('frontend')
    @include($activeTheme . 'sections.about')

    @include($activeTheme . 'sections.partner')
@endsection

@push('page-style-lib')
    <link rel="stylesheet" href="{{ asset($activeThemeTrue . 'css/odometer.css') }}">
@endpush

@push('page-script-lib')
    <script src="{{ asset($activeThemeTrue . 'js/odometer.min.js') }}"></script>
@endpush
