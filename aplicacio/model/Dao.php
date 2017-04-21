<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Borsa;

/**
 * Description of Dao
 *
 * @author joan
 */
class Dao {
    public function canviarContrasenya(Request $request, Response $response, \Slim\Container $container) {
        $container->dbEloquent;
        $data = $request->getParsedBody();
        $contacte = Contacte::find($data['idContacte']);
        $contacte->Nom = filter_var($data['Nom'], FILTER_SANITIZE_STRING);
        $contacte->Llinatges = filter_var($data['Llinatges'], FILTER_SANITIZE_STRING);
        $contacte->Telefon = filter_var($data['Telefon'], FILTER_SANITIZE_STRING);
        $contacte->Carrec = filter_var($data['Carrec'], FILTER_SANITIZE_STRING);
        $contacte->email = filter_var($data['email'], FILTER_SANITIZE_EMAIL);
        $contacte->idEmpresa = filter_var($data['idEmpresa'], FILTER_SANITIZE_NUMBER_INT);
        $contacte->save();
        return $response->withJSON($contacte);
    }
    
    
}
