<?php

namespace App\Models;

use App\Traits\UniversalStatus;
use Illuminate\Database\Eloquent\Model;

class Gateway extends Model
{
    use UniversalStatus;

    protected $hidden = [
        'gateway_parameters', 'extra'
    ];

    protected $casts = [
        'code'                 => 'string',
        'extra'                => 'object',
        'input_form'           => 'object',
        'supported_currencies' => 'object'
    ];

    public function currencies()
    {
        return $this->hasMany(GatewayCurrency::class, 'method_code', 'code');
    }

    public function form()
    {
        return $this->belongsTo(Form::class);
    }

    public function singleCurrency()
    {
        return $this->hasOne(GatewayCurrency::class, 'method_code', 'code')->orderBy('id', 'desc');
    }

    public function scopeAutomated($query)
    {
        return $query->where('code', '<', 1000);
    }

    public function scopeManual($query)
    {
        return $query->where('code', '>=', 1000);
    }
}
