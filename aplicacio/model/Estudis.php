<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Borsa;

use \Illuminate\Database\Eloquent\Model as Model;

/**
 * Description of Estudis
 *
 * @author joan
 */
class Estudis extends Model {

    protected $table = 'Estudis';
    protected $primaryKey = "codi";
    public $timestamps = false;
    public $incrementing = false; //Si no, tracta la clau primaria com a integer

    public function professors() {
        return $this->belongsToMany('Borsa\Professor', 'Estudis_has_Responsables', 'Estudis_codi', 'professors_idProfessor');
    }

    public function ofertes() {
        return $this->belongsToMany('Borsa\Oferta', 'Ofertes_has_Estudis', 'Estudis_codi', 'Ofertes_idOferta')->withPivot(['any', 'nota']);
    }

    public function familia(){
        return $this->belongsTo('Borsa\Familia', 'id');
    }
}
