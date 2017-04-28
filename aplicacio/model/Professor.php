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
class Professor extends Model {

    protected $table = 'Professors';
    protected $primaryKey = "idProfessor";
    public $timestamps = false;

    public function estudis() {
        return $this->belongsToMany('Borsa\Estudis', 'Estudis_has_Responsables', 'professors_idProfessor', 'Estudis_codi');
    }

    public function getUsuari() {
        $nomUsuari = $this->attributes['email'];
        $entitat = Usuari::where('nomUsuari', $nomUsuari)->first();
        return $entitat;
    }

}
