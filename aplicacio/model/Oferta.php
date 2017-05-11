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
class Oferta extends Model {

    protected $table = 'Ofertes';
    protected $primaryKey = "idOferta";
    public $timestamps = false;

    public function estudis() {
        return $this->belongsToMany('Borsa\Estudis', 'Ofertes_has_Estudis', 'Ofertes_idOferta', 'Estudis_codi')->withPivot(['any', 'nota']);
    }

    public function idiomes() {
        return $this->belongsToMany('Borsa\Idioma', 'Ofertes_has_Idiomes', 'Ofertes_idOferta', 'Idiomes_idIdioma')->withPivot('NivellsIdioma_idNivellIdioma');
    }

    public function estatsLaborals() {
        return $this->belongsToMany("Borsa\EstatLaboral", 'Ofertes_has_EstatLaboral', 'Ofertes_idOferta', 'EstatLaboral_idEstatLaboral');
    }

    public function contactes(){
        return $this->belongsToMany("Borsa\Contacte", 'Ofertes_has_Contactes', 'Ofertes_idOferta', 'Contactes_idContacte');
    }
    
    public function empresa(){
        return $this->belongsTo('Borsa\Empresa','Empreses_idEmpresa', 'idEmpresa');
    }
    
    public function alumnes(){
        return $this->belongsToMany("Borsa\Alumne", 'Ofertes_enviada_Alumnes', 'Ofertes_idOferta', 'Alumnes_idAlumne');        
    }
}
