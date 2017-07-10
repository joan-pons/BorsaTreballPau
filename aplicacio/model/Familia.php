<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Borsa;

use \Illuminate\Database\Eloquent\Model as Model;

/**
 * Description of Contacte
 *
 * @author joan
 */
class Familia extends Model {

    protected $table = 'familiesProfessionals';
    protected $primaryKey = "id";
    public $timestamps = false;
    public $incrementing = false; //Si no, tracta la clau primaria com a integer

    public function cicles() {
        return $this->hasMany('Borsa\Estudis', 'familia', 'id');
    }

}
