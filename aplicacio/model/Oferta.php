<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Borsa;

use \Illuminate\Database\Eloquent\Model as Model;

/**
 * Description of Professor
 *
 * @author joan
 */
class Oferta extends Model {

    protected $table = 'Ofertes';
    protected $primaryKey = "idOferta";
    public $timestamps = false;

    public function estudis() {
        return $this->belongsToMany('Borsa\Estudis', 'Ofertes_has_Estudis', 'Ofertes_idOferta', 'Estudis_codi')->withPivot(['any','nota']);
    }

     public function idiomes() {
        return $this->belongsToMany('Borsa\Idioma', 'Ofertes_has_Idiomes', 'Ofertes_idOferta', 'Idiomes_idIdioma')->withPivot('NivellsIdioma_idNivellIdioma');
    }
}
