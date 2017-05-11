<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Borsa;

use \Illuminate\Database\Eloquent\Model as Model;
use \Borsa\EstatLaboral as EstatLaboral;

/**
 * Description of Professor
 *
 * @author joan
 */
class Alumne extends Model {

    protected $table = 'Alumnes';
    protected $primaryKey = "idAlumne";
    public $timestamps = false;

    public function getUsuari() {
        $nomUsuari = $this->attributes['email'];
        $entitat = Usuari::where('nomUsuari', $nomUsuari)->first();
        return $entitat;
    }

    public function estatsLaborals() {
        return $this->belongsToMany("Borsa\EstatLaboral", 'Alumne_has_EstatLaboral', 'Alumnes_idAlumne', 'EstatLaboral_idEstatLaboral');
    }

    public function estudis() {
        return $this->belongsToMany('Borsa\Estudis', 'Alumne_has_Estudis', 'Alumnes_idAlumne', 'Estudis_codi')->withPivot(['any', 'nota']);
    }

    public function idiomes() {
        return $this->belongsToMany('Borsa\Idioma', 'Alumne_has_Idiomes', 'Alumne_idAlumne', 'Idiomes_idIdiomes')->withPivot('NivellsIdioma_idNivellIdioma');
    }

    public function ofertes() {
        return $this->belongsToMany('Borsa\Oferta', 'Ofertes_enviada_Alumnes', 'Alumnes_idAlumne', 'Ofertes_idOferta')->orderby('dataFinal','DES');
    }

    public function ofertesActives() {
        return $this->belongsToMany('Borsa\Oferta', 'Ofertes_enviada_Alumnes', 'Alumnes_idAlumne', 'Ofertes_idOferta')->where('dataFinal','>=',date('Y-m-d'))->orderby('dataFinal','ASC')->get();
    }
    
}
