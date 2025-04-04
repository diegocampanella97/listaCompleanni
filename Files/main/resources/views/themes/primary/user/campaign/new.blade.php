@extends($activeTheme . 'layouts.frontend')

@section('frontend')
    <div class="create-campaign py-60">
        <div class="container">
            <div class="row g-4 justify-content-center">
                <div class="col-lg-9">
                    <div class="custom--card">
                        <div class="card-body">
                            <form action="{{ route('user.campaign.store') }}" method="POST" class="row g-4" enctype="multipart/form-data">
                                @csrf
                                <div class="col-12">
                                    <label class="form--label required">@lang('Name')</label>
                                    <div class="input--group">
                                        <span class="input-group-text"><i class="ti ti-keyframe-align-center"></i></span>
                                        <input type="text" class="form--control" name="name" value="{{ old('name') }}" required>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <label class="form--label required">@lang('Category')</label>
                                    <div class="input--group">
                                        <span class="input-group-text"><i class="ti ti-menu-2"></i></span>
                                        <select class="form--control form-select" name="category_id" required>
                                            <option value="" selected>@lang('Select Category')</option>

                                            @foreach ($categories as $category)
                                                <option value="{{ $category->id }}" @selected(old('category_id') == $category->id)>
                                                    {{ __(@$category->name) }}
                                                </option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <label class="form--label required">@lang('Goal Amount')</label>
                                    <div class="input--group">
                                        <span class="input-group-text">{{ @$setting->cur_sym }}</span>
                                        <input type="number" step="any" min="0" class="form--control" name="goal_amount" value="{{ old('goal_amount') }}" required>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <label class="form--label required">@lang('Preferred Amounts')</label>
                                    <div class="d-flex gap-2">
                                        <div class="input--group w-100">
                                            <span class="input-group-text">{{ @$setting->cur_sym }}</span>
                                            <input type="number" step="any" min="0" class="form--control" name="preferred_amounts[]" value="20" required>
                                        </div>
                                        <a role="button" class="btn btn--base px-3 d-flex align-items-center" id="addMoreAmounts">
                                            <i class="ti ti-square-rounded-plus"></i>
                                        </a>
                                    </div>
                                    <div class="add-more-amounts">
                                        <div class="extra-amount d-flex gap-2 pt-2">
                                            <div class="input--group w-100">
                                                <span class="input-group-text">€</span>
                                                <input type="number" value="50" step="any" min="0" class="form--control" name="preferred_amounts[]" required="" data-dashlane-rid="1be17ce0aea4e232" data-dashlane-classification="other">
                                            </div>
                                            <a role="button" class="btn btn--danger px-3 d-flex align-items-center close-extra-amount" data-dashlane-label="true" data-dashlane-rid="19266b263c2b78cd" data-dashlane-classification="other">
                                                <i class="ti ti-square-rounded-minus"></i>
                                            </a>
                                        </div>

                                        <div class="extra-amount d-flex gap-2 pt-2">
                                            <div class="input--group w-100">
                                                <span class="input-group-text">€</span>
                                                <input type="number" value="100" step="any" min="0" class="form--control" name="preferred_amounts[]" required="" data-dashlane-rid="1be17ce0aea4e232" data-dashlane-classification="other">
                                            </div>
                                            <a role="button" class="btn btn--danger px-3 d-flex align-items-center close-extra-amount" data-dashlane-label="true" data-dashlane-rid="19266b263c2b78cd" data-dashlane-classification="other">
                                                <i class="ti ti-square-rounded-minus"></i>
                                            </a>
                                        </div>
                                    </div>
                                    
                                </div>
                                <div class="col-sm-6">
                                    <label class="form--label required">@lang('Start Date')</label>
                                    <div class="input--group">
                                        <span class="input-group-text"><i class="ti ti-calendar"></i></span>
                                        <input type="text" class="form--control date-picker" name="start_date" value="{{ old('start_date') }}" data-language="en" required autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <label class="form--label required">@lang('End Date')</label>
                                    <div class="input--group">
                                        <span class="input-group-text"><i class="ti ti-calendar"></i></span>
                                        <input type="text" class="form--control date-picker" name="end_date" value="{{ old('end_date') }}" data-language="en" required autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-12">
                                    <label class="form--label">@lang('Document')</label>
                                    <div class="d-flex mb-1">
                                        <input type="file" class="form--control" name="document" accept=".pdf">
                                    </div>
                                    <span><em><small>@lang('Supported file'): <span class="text--base fw-bold">.@lang('pdf')</span>.</small></em></span>
                                </div>
                                <div class="col-12">
                                    <label class="form--label required">@lang('Description')</label>
                                    <textarea class="form--control ck-editor" name="description" rows="10">
                                        @php echo old('description') @endphp
                                    </textarea>
                                </div>
                                <div class="col-12">
                                    <button type="submit" class="btn btn--base w-100">@lang('Create Campaign')</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

@include($activeTheme . 'user.campaign.commonStyleScript')

@push('page-style-lib')
    <link rel="stylesheet" href="{{ asset($activeThemeTrue . 'css/dropzone.min.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/universal/css/datepicker.css') }}">
@endpush

@push('page-script-lib')
    <script src="{{ asset($activeThemeTrue . 'js/dropzone.min.js') }}"></script>
    <script src="{{ asset($activeThemeTrue . 'js/ckeditor.js') }}"></script>
    <script src="{{ asset('assets/universal/js/datepicker.js') }}"></script>
    <script src="{{ asset('assets/universal/js/datepicker.en.js') }}"></script>
@endpush

@push('page-script')
    <script type="text/javascript">
        (function($) {
            "use strict"

            // Add More Preferred Amounts On Campaign Create Start
            $('#addMoreAmounts').on('click', function () {
                $('.add-more-amounts').append(`
                    <div class="extra-amount d-flex gap-2 pt-2">
                        <div class="input--group w-100">
                            <span class="input-group-text">{{ $setting->cur_sym }}</span>
                            <input type="number" step="any" min="0" class="form--control" name="preferred_amounts[]" required>
                        </div>
                        <a role="button" class="btn btn--danger px-3 d-flex align-items-center close-extra-amount">
                            <i class="ti ti-square-rounded-minus"></i>
                        </a>
                    </div>
                `)
            })

            $(document).on('click', '.close-extra-amount', function () {
                $(this).closest('.extra-amount').remove()
            })
            // Add More Preferred Amounts On Campaign Create End

            $('.date-picker').datepicker({
                dateFormat: 'dd-mm-yyyy',
                minDate: new Date(),
            })

            $('.date-picker').on('input keyup keydown keypress', function() {
                return false
            })
        })(jQuery)
    </script>
@endpush
