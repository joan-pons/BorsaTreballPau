<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Borsa;

use \Illuminate\Database\Eloquent\Model as Model;
use Borsa\Alumne as Alumne;

/**
 * Description of Professor
 *
 * @author joan
 */
class EstatLaboral extends Model {

    protected $table = 'EstatLaboral';
    protected $primaryKey = "idEstatLaboral";
    public $timestamps = false;

    public function alumnes(){
        return $this->hasMany("Borsa\Alumne", 'idAlumne');
    }
}
