<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Borsa;

use \Illuminate\Database\Eloquent\Model as Model;

/**
 * Description of Rol
 *
 * @author joan
 */
class Rol extends Model {

    protected $table = 'Rols';
    protected $primaryKey = "idRol";
    public $timestamps = false;

}
