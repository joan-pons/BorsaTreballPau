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
class Empresa extends Model {

    protected $table = 'Empreses';
    protected $primaryKey = "idEmpresa";
    public $timestamps = false;

    public function contactes() {
        return $this->hasMany('Borsa\Contacte', 'Empreses_idEmpresa', 'idEmpresa');
    }

    public function ofertes() {
        return $this->hasMany('Borsa\Oferta', 'Empreses_idEmpresa', 'idEmpresa')->orderBy('dataPublicacio','ASC')->orderby('dataFinal','ASC');
    }

}
