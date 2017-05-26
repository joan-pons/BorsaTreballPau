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
class Ajuda extends Model {

    protected $table = 'Ajuda';
    protected $primaryKey = "idAjuda";
    public $timestamps = false;

}
