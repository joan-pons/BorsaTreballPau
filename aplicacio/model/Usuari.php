<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Borsa;

use \Illuminate\Database\Eloquent\Model as Model;
use Borsa\Professor as Professor;

/**
 * Description of Usuari
 *
 * @author joan
 */
class Usuari extends Model {

    protected $table = 'Usuaris';
    protected $primaryKey = "idUsuari";
    public $timestamps = false;

    public function rols() {
        return $this->belongsToMany("Borsa\Rol", 'Usuaris_has_Rols', 'Usuaris_idUsuari', 'Rols_idRol');
    }

    public function getNomUsuariAttribute($value) {
        return $value;
    }

    public function getEntitat() {
        $tipus = $this->attributes['tipusUsuari'];
        $nomUsuari = $this->attributes['nomUsuari'];
        switch ($tipus) {
            case 10: {
                    $entitat = Professor::where('email', $nomUsuari)->first();
                    break;
                }
            case 20: {
                    $entitat = Empresa::where('email', $nomUsuari)->first();
                    break;
                }
            case 30: {
                    $entitat = Alumne::where('email', $nomUsuari)->first();
                    break;
                }
            default: {
                    $entitat = null;
                    break;
                }
        }
        //return array('tipus'=>$tipus, 'nomUsuari'=>$nomUsuari);
        return $entitat;
    }

    public function teRol($rolCercat) {
        
        foreach ($this->rols as $rol) {
            if ($rol->idRol == $rolCercat) {
                return true;
            }
        }
        return false;
    }

}
