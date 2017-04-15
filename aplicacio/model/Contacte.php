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
class Contacte extends Model {

    protected $table = 'Contactes';
    protected $primaryKey = "idContacte";
    public $timestamps = false;

    public function empresa() {
        return $this->belongsTo("Borsa\Empresa", 'idEmpresa');
    }

}
