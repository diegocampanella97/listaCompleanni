@extends('admin.layouts.master')

@section('master')
    <div class="col-xl-8 col-lg-7">
        <div class="custom--card h-auto mb-4">
            <div class="card-body">
                <div class="campaign-details">
                    <div class="campaign-details__txt">
                        <h3 class="campaign-details__title">{{ __($campaign->name) }}</h3>
                        <div class="campaign-details__desc">
                            <h6>@lang('Description'):</h6>
                            <div class="description scroll">
                                @php echo $campaign->description @endphp
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="custom--card h-auto">
            <div class="card-header">
                <h3 class="title">Transazioni</h3>
            </div>
            <div class="card-body">
                @if(count($transactions))
                    <div class="col-12">
                        <table class="table table-borderless table--striped table--responsive--xl">
                            <thead>
                                <tr>
                                    <th>@lang('User')</th>
                                    <th>@lang('TRX')</th>
                                    <th>@lang('Transacted')</th>
                                    <th>@lang('Modalità di Pagamento')</th>
                                    <th>@lang('Amount')</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($transactions as $transaction)
                                <tr>
                                    <td>
                                        <div class="table-card-with-image">
                                            <div class="table-card-with-image__img">
                                                <img src="{{ getImage(getFilePath('userProfile') . '/' . @$transaction->user->image, getFileSize('userProfile'), true) }}"
                                                    alt="Image">
                                            </div>
                                            <div class="table-card-with-image__content">
                                                <p class="fw-semibold">{{ $transaction->full_name}}</p>
                                                <p class="fw-semibold">
                                                    {{ $transaction->email }}
                                                </p>
                                            </div>
                                        </div>
                                    </td>
                                    <td><span class="fw-bold">{{ $transaction->trx }}</span></td>
                                    <td>
                                        <div>
                                            <p>{{ showDateTime($transaction->created_at) }}</p>
                                            <p>{{ diffForHumans($transaction->created_at) }}</p>
                                        </div>
                                    </td>
                                    <td>
                                        {{ $transaction->gateway->name }}
                                    </td>
                                    <td>
                                        <span class="text--success">
                                            {{showAmount($transaction->amount)}} {{ __($setting->site_cur)}}
                                        </span>
                                    </td>
                                </tr>
                                @empty
                                @include('admin.partials.noData')
                                @endforelse
                            </tbody>
                        </table>
                    
                    </div>
                @else
                    @include('admin.partials.noData')
                @endif
            </div>
        </div>
    </div>
    <div class="col-xl-4 col-lg-5">
        <div class="custom--card h-auto mb-4">
            <div class="card-header">
                <h3 class="title">@lang('Basic Information')</h3>
            </div>
            <div class="card-body">
                <div class="d-flex justify-content-center my-5">
                    <div id="qrcode">
                        <div class="d-flex justify-content-center mb-2">
                            <button id="printQrCode" class="btn btn--sm btn--base mt-3">@lang('Stampa Bigliettino QR'.$campaign->name)</button>
                        </div>
                    </div>
                </div>
                <table class="table table-flush">
                    <tbody>
                        <tr>
                            <td class="fw-semibold">@lang('Category'):</td>
                            <td>{{ __($campaign->category->name) }}</td>
                        </tr>
                        <tr>
                            <td class="fw-semibold">@lang('Author'):</td>
                            <td>
                                <a href="{{ route('admin.user.details', $campaign->user->id) }}">
                                    <small>@</small>{{ $campaign->user->username }}
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <td class="fw-semibold">@lang('Start Date'):</td>
                            <td>{{ showDateTime($campaign->start_date) }}</td>
                        </tr>
                        <tr>
                            <td class="fw-semibold">@lang('End Date'):</td>
                            <td>
                                <span class="text--warning">{{ showDateTime($campaign->end_date) }}</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="fw-semibold">@lang('Approval Status'):</td>
                            <td>
                                @php echo $campaign->approvalStatusBadge @endphp
                            </td>
                        </tr>
                        <tr>
                            <td class="fw-semibold">@lang('Campaign Status'):</td>
                            <td>
                                @php echo $campaign->campaignStatusBadge @endphp
                            </td>
                        </tr>
                        <tr>
                            <td class="fw-semibold">@lang('Featured Status'):</td>
                            <td>
                                @php echo $campaign->featuredStatusBadge @endphp
                            </td>
                        </tr>
                        <tr>
                            <td class="fw-semibold">@lang('Goal Amount'):</td>
                            <td>{{ $setting->cur_sym . showAmount($campaign->goal_amount) }}</td>
                        </tr>
                        <tr>
                            <td class="fw-semibold">@lang('Raised Amount'):</td>
                            <td>
                                <span class="text--success">{{ $setting->cur_sym . showAmount($campaign->raised_amount) }}</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="fw-semibold">@lang('Total Donor'):</td>
                            
                            <td>{{ $totalDonor }}</td>
                        </tr>
                        <tr>
                            @php $percentage = donationPercentage($campaign->goal_amount, $campaign->raised_amount) @endphp

                            <td class="fw-semibold">@lang('Donation Progress'):</td>
                            <td>
                                <div class="progress custom--progress" role="progressbar" aria-label="Basic example" aria-valuenow="{{ $percentage }}" aria-valuemin="0" aria-valuemax="100">
                                    <div class="progress-bar" style="width: {{ $percentage }}%"></div>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="custom--card h-auto mb-4">
            <div class="card-header">
                <h3 class="title">@lang('Relevant Images')</h3>
            </div>
            <div class="card-body">
                <div id="charityImageSlide" class="custom--carousel carousel slide">
                    <div class="carousel-inner">
                        @foreach($campaign->gallery as $image)
                            <div @class(['carousel-item', 'active' => $loop->first])>
                                <img src="{{ getImage(getFilePath('campaign') . '/' . $image, getFileSize('campaign')) }}" class="d-block w-100" alt="Image">
                            </div>
                        @endforeach
                    </div>
                    <button type="button" class="carousel-control-prev" data-bs-target="#charityImageSlide" data-bs-slide="prev">
                        <i class="ti ti-chevron-left"></i>
                    </button>
                    <button type="button" class="carousel-control-next" data-bs-target="#charityImageSlide" data-bs-slide="next">
                        <i class="ti ti-chevron-right"></i>
                    </button>
                </div>
            </div>
        </div>

        @if($campaign->document)
            <div class="custom--card h-auto">
                <div class="card-header">
                    <h3 class="title">@lang('Relevant Document')</h3>
                </div>
                <div class="card-body">
                    <object class="campaign-details-doc" data="{{ asset(getFilePath('document') . '/' . $campaign->document) }}" type="application/pdf"></object>
                </div>
            </div>
        @endif
    </div>

    <x-decisionModal />
@endsection

@push('breadcrumb')
    <a href="{{ $backRoute }}" class="btn btn--sm btn--base">
        <i class="ti ti-circle-arrow-left"></i> @lang('Back')
    </a>

    @if(!$campaign->isExpired())
        <div class="custom--dropdown">
            <button type="button" class="btn btn--sm btn--icon btn--base" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="ti ti-dots-vertical"></i>
            </button>

            @if($campaign->status == ManageStatus::CAMPAIGN_PENDING)
                <ul class="dropdown-menu">
                    <li>
                        <button type="button" class="dropdown-item text--success decisionBtn" data-question="@lang('Do you want to approve this campaign?')" data-action="{{ route('admin.campaigns.status.update', [$campaign->id, 'approve']) }}">
                            <span class="dropdown-icon"><i class="ti ti-circle-check"></i></span> @lang('Approve')
                        </button>
                    </li>
                    <li>
                        <button type="button" class="dropdown-item text--danger decisionBtn" data-question="@lang('Do you want to reject this campaign?')" data-action="{{ route('admin.campaigns.status.update', [$campaign->id, 'reject']) }}">
                            <span class="dropdown-icon"><i class="ti ti-circle-x"></i></span> @lang('Reject')
                        </button>
                    </li>
                </ul>
            @endif

            @if($campaign->status == ManageStatus::CAMPAIGN_APPROVED)
                <ul class="dropdown-menu">
                    @if($campaign->featured)
                        <li>
                            <button type="button" class="dropdown-item text--warning decisionBtn" data-question="@lang('Do you want to unfeatured this campaign?')" data-action="{{ route('admin.campaigns.featured.update', $campaign->id) }}">
                                <span class="dropdown-icon"><i class="ti ti-ban"></i></span> @lang('Unfeatured')
                            </button>
                        </li>
                    @else
                        <li>
                            <button type="button" class="dropdown-item text--success decisionBtn" data-question="@lang('Do you want to featured this campaign?')" data-action="{{ route('admin.campaigns.featured.update', $campaign->id) }}">
                                <span class="dropdown-icon"><i class="ti ti-circle-check"></i></span> @lang('Featured')
                            </button>
                        </li>
                    @endif
                </ul>
            @endif
        </div>
    @endif
@endpush

@push('page-script-lib')
    <script src="{{ asset('assets/admin/js/page/pdfobject.js') }}"></script>
    <script src="https://cdn.jsdelivr.net/npm/qrcodejs/qrcode.min.js"></script>
@endpush

@push('page-script')
    <script>
        (function ($) {
            "use strict"
            let pdfFIle = $('.campaign-details-doc').attr('data')
            PDFObject.embed(pdfFIle, '.campaign-details-doc');

            new QRCode(document.getElementById("qrcode"), {
                text: "{{ route('campaign.show', $campaign->slug) }}",
                width: 300,
                height: 300,
                colorDark: "#000000",
                colorLight: "#ffffff",
                correctLevel: QRCode.CorrectLevel.H
            });

            document.getElementById('printQrCode').addEventListener('click', function () {
                const qrCodeElement = document.getElementById('qrcode');
                const printCount = prompt("@lang('Quanti biglietti da visita vuoi stampare?')", 1);

                if (printCount && !isNaN(printCount) && printCount > 0) {
                    const printWindow = window.open('', '_blank');
                    printWindow.document.write('<html><head><title>@lang("Print QR Code")</title>');
                    printWindow.document.write('<style>');
                    printWindow.document.write('body { font-family: Arial, sans-serif; margin: 20px; text-align: center; }');
                    printWindow.document.write('h4 { margin-bottom: 10px; font-size: 14px; }');
                    printWindow.document.write('.qr-container { display: inline-block; width: 85mm; height: 55mm; padding: 10px; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; margin: 10px; }');
                    printWindow.document.write('.qr-container img { width: 100px; margin-bottom: 10px; }');
                    printWindow.document.write('#printQrCode { display: none;}');
                    printWindow.document.write('</style></head><body>');

                    for (let i = 0; i < printCount; i++) {
                        printWindow.document.write('<div class="qr-container">');
                        printWindow.document.write('<img src="https://demoapplication.it/assets/universal/images/logoFavicon/logo_dark.png" alt="Logo">');
                        printWindow.document.write('<h4>{{ __($campaign->name) }}</h4>');
                        printWindow.document.write('<div style="display: flex; justify-content: center;">' + qrCodeElement.innerHTML + '</div>');
                        printWindow.document.write('</div>');
                    }

                    printWindow.document.write('</body></html>');
                    printWindow.document.close();
                    printWindow.print();
                } else {
                    alert("@lang('Inserire un numero valido di biglietti da visita da stampare.')");
                }
            });

        })(jQuery)
    </script>
@endpush
