<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Borsa;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use Borsa\Usuari as Usuari;

/**
 * Description of Dao
 *
 * @author joan
 */
class Dao {

    public function entrada(Request $request, Response $response, $args, \Slim\Container $container) {
        $container->dbEloquent;
        $data = $request->getQueryParams();
        $usuari = Usuari::where('nomUsuari', $data['nomUsuari'])->first();
        if ($usuari == null || $usuari->contrasenya != $data['password']) {
            $missatge = array("missatge" => "L'usuari i/o la contrasenya estan equivocats.");
            return $response->withJson($missatge, 401);
        } else {
            session_unset();
            session_destroy();

            session_start();
            $_SESSION['idUsuari'] = $usuari->idusuari;
            $rols = [];
            foreach ($usuari->rols as $rol) {
                $rols[] = $rol->idrol;
            }
            $_SESSION['rols'] = $rols;
            return $response->withJSON(array("missatge" => "L'usuari s'ha validat correctament"));
        }
    }

    public function canviarContrasenya(Request $request, Response $response, $args, \Slim\Container $container) {
        try {
            $container->dbEloquent;
            $data = $request->getParsedBody();
            // $usuari = Usuari::where('nomUsuari', $args['nomUsuari'])->first();
            $usuari = Usuari::find($args['idusuari']);
            if ($usuari != null) {
                if ($usuari->contrasenya == $data['antic']) {
                    $usuari->contrasenya = $data['nou'];
                    $usuari->save();
                    return $response->withStatus(200);
                } else {
                    return $response->withJson(array("missatge" => "La contrasenya antiga no és correcta."), 422);
                }
            } else {
                return $response->withJson(array("missatge" => "No es troba cap usuari amb el nom d'usuari donat."), 422);
            }
        } catch (\Illuminate\Database\QueryException $ex) {
            switch ($ex->getCode()) {
                case 23000: {
                        $missatge = array("missatge" => "La contrasenya no pot ser nula");
                        break;
                    }
                default: {
                        $missatge = array("missatge" => "La contrasenya no s'ha pogut canviar correctament.");
                        break;
                    }
            }
            return $response->withJson($missatge, 422);
        }
    }

}
