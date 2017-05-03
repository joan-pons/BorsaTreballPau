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
class NivellIdioma extends Model {

    protected $table = 'NivellsIdioma';
    protected $primaryKey = "idNivellIdioma";
    public $timestamps = false;


}
