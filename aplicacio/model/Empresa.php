<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Borsa;

use \Illuminate\Database\Eloquent\Model as Model;
use Borsa\Contacte as Contacte;
use Borsa\DaoEmpresa as DaoEmpresa;

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
        return $this->hasMany('Borsa\Contacte', 'idContacte', 'idEmpresa');
        //return Contacte::all()->where('idEmpresa', $this->$primaryKey)->all();
        //return $this->hasMany('Borsa\Contacte', 'idEmpresa', 'idContacte');
        //return DaoEmpresa::contactesEmpresa($this->$idEmpresa);
    }

}
