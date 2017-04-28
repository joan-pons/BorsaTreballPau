<?php

namespace Borsa;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use Borsa\Empresa as Empresa;

/**
 * Description of DaoEmpresa
 *
 * @author joan
 */
class DaoEmpresa extends Dao {

    public function altaEmpresa(Request $request, Response $response, \Slim\Container $container) {
        //TO-DO: Filtrar descripció
        try {
            $container->dbEloquent;
            $data = $request->getParsedBody();
            $empresa = new Empresa;
            $empresa->nom = filter_var($data['nom'], FILTER_SANITIZE_STRING);
            $empresa->descripcio = $data['descripcio'];
            $empresa->adreca = filter_var($data['adreca'], FILTER_SANITIZE_STRING);
            $empresa->codiPostal = filter_var($data['codiPostal'], FILTER_SANITIZE_STRING);
            $empresa->localitat = filter_var($data['localitat'], FILTER_SANITIZE_STRING);
            $empresa->provincia = filter_var($data['provincia'], FILTER_SANITIZE_STRING);
            $empresa->telefon = filter_var($data['telefon'], FILTER_SANITIZE_STRING);
            $empresa->email = filter_var($data['email'], FILTER_SANITIZE_EMAIL);
            $empresa->activa = filter_var($data['actiu'], FILTER_SANITIZE_STRING) == 'true';
            $empresa->validada = false;
            $empresa->url = filter_var($data['url'], FILTER_SANITIZE_URL);
            //$empresa->DataAlta= \Carbon::now();
            $empresa->save();
            return $response->withJSON($empresa);
        } catch (\Illuminate\Database\QueryException $ex) {
            switch ($ex->getCode()) {
                case 23000:
                    $missatge = array("missatge" => "Dades duplicades. Segurament degut a que el correu electrònic ja està registrat per una altra empresa.");
                    break;
                case 'HY000':
                    $missatge = array("missatge" => "Algunes de les dades obligatòries han arribat sense valor.");
                    break;
                default:
                    $missatge = array("missatge" => "L'empresa no s'ha pogut donar d'alta correctament.");
                    break;
            }
            return $response->withJson($missatge, 422);
        }
    }

    public function modificarEmpresa(Request $request, Response $response, $args, \Slim\Container $container) {
        //TO-DO: Filtrar descripció
        try {
            $container->dbEloquent;
            $data = $request->getParsedBody();
            $empresa = Empresa::find($args['idEmpresa']);
            if ($empresa != null) {
                $empresa->nom = filter_var($data['nom'], FILTER_SANITIZE_STRING);
                $empresa->descripcio = $data['descripcio'];
                $empresa->adreca = filter_var($data['adreca'], FILTER_SANITIZE_STRING);
                $empresa->codiPostal = filter_var($data['codiPostal'], FILTER_SANITIZE_STRING);
                $empresa->localitat = filter_var($data['localitat'], FILTER_SANITIZE_STRING);
                $empresa->Provincia = filter_var($data['provincia'], FILTER_SANITIZE_STRING);
                $empresa->telefon = filter_var($data['telefon'], FILTER_SANITIZE_STRING);
                $empresa->email = filter_var($data['email'], FILTER_SANITIZE_EMAIL);
                $empresa->activa = filter_var($data['actiu'], FILTER_SANITIZE_STRING) == 'true';
                $empresa->validada = false;
                $empresa->url = filter_var($data['url'], FILTER_SANITIZE_URL);
                //$empresa->DataAlta= \Carbon::now();
                $empresa->save();
                return $response->withJSON($empresa);
            } else {
                $missatge = array("missatge" => "No s'ha trobat l'empresa que es vol modificar.");
                return $response->withJson($missatge, 422);
            }
        } catch (\Illuminate\Database\QueryException $ex) {
            switch ($ex->getCode()) {
                case 23000:
                    $missatge = array("missatge" => "Dades duplicades. Segurament degut a que el correu electrònic ja està registrat per una altra empresa.");
                    break;
                case 'HY000':
                    $missatge = array("missatge" => "Algunes de les dades obligatòries han arribat sense valor.");
                    break;
                default:
                    $missatge = array("missatge" => "Les dades de l'empresa no s'han pogut modificar correctament.");
                    break;
            }
            return $response->withJson($missatge, 422);
        }
    }

    public function altaContacte(Request $request, Response $response, \Slim\Container $container) {
        try {
            $container->dbEloquent;
            $data = $request->getParsedBody();
            $contacte = new Contacte;
            $contacte->nom = filter_var($data['nom'], FILTER_SANITIZE_STRING);
            $contacte->llinatges = filter_var($data['llinatges'], FILTER_SANITIZE_STRING);
            $contacte->telefon = filter_var($data['telefon'], FILTER_SANITIZE_STRING);
            $contacte->email = filter_var($data['email'], FILTER_SANITIZE_EMAIL);
            $contacte->carrec = filter_var($data['carrec'], FILTER_SANITIZE_STRING);
            $contacte->Empreses_idEmpresa = filter_var($data['idEmpresa'], FILTER_SANITIZE_NUMBER_INT);
            $contacte->save();
            return $response->withJSON($contacte);
        } catch (\Illuminate\Database\QueryException $ex) {
            switch ($ex->getCode()) {
                case 23000:
                    $missatge = array("missatge" => "Dades duplicades. Segurament degut a que el correu electrònic ja està registrat per un altre contacte.");
                    break;
                case 'HY000':
                    $missatge = array("missatge" => "Algunes de les dades obligatòries han arribat sense valor.");
                    break;
                default:
                    $missatge = array("missatge" => "El contacte no s'ha pogut afegir correctament a la llista de contactes de l'empresa.");
                    break;
            }
            return $response->withJson($missatge, 422);
        }
    }

    public function modificarContacte(Request $request, Response $response, $args, \Slim\Container $container) {
        try {
            $container->dbEloquent;
            $data = $request->getParsedBody();
            $contacte = Contacte::find($args['idContacte']);
            if ($contacte != null) {
                $contacte->nom = filter_var($data['nom'], FILTER_SANITIZE_STRING);
                $contacte->llinatges = filter_var($data['llinatges'], FILTER_SANITIZE_STRING);
                $contacte->telefon = filter_var($data['telefon'], FILTER_SANITIZE_STRING);
                $contacte->carrec = filter_var($data['carrec'], FILTER_SANITIZE_STRING);
                $contacte->email = filter_var($data['email'], FILTER_SANITIZE_EMAIL);
                $contacte->Empreses_idEmpresa = filter_var($data['idEmpresa'], FILTER_SANITIZE_NUMBER_INT);
                $contacte->save();
                return $response->withJSON($contacte);
            } else {
                $missatge = array("missatge" => "No s'ha trobat el contacte que es vol modificar.");
                return $response->withJson($missatge, 422);
            }
        } catch (\Illuminate\Database\QueryException $ex) {
            switch ($ex->getCode()) {
                case 23000:
                    $missatge = array("missatge" => "Dades duplicades. Segurament degut a que el correu electrònic ja està registrat per un altre contacte.");
                    break;
                case 'HY000':
                    $missatge = array("missatge" => "Algunes de les dades obligatòries han arribat sense valor.");
                    break;
                default:
                    $missatge = array("missatge" => "Les dades del contacte no s'han pogut modificar correctament.");
                    break;
            }
            return $response->withJson($missatge, 422);
        }
    }

    public function esborrarContacte(Request $request, Response $response, $args, \Slim\Container $container) {
        try {
            $container->dbEloquent;

            $contacte = Contacte::find($args['idContacte']);
            if ($contacte != null) {
                $contacte->delete();
                return $response->withJSON($contacte);
            } else {
                return $response->withJson("No es troba cap contacte amb l'identificador demanat.", 422);
            }
        } catch (\Illuminate\Database\QueryException $ex) {
            switch ($ex->getCode()) {
                case 23000:
                    $missatge = array("missatge" => "Dades duplicades. Segurament degut a que el correu electrònic ja està registrat per un altre contacte.");
                    break;
                case 'HY000':
                    $missatge = array("missatge" => "Algunes de les dades obligatòries han arribat sense valor.");
                    break;
                default:
                    $missatge = array("missatge" => "El contacte no s'ha pogut eliminar, possiblement per tenir ofertes associades.");
                    break;
            }
            return $response->withJson($missatge, 422);
        }
    }

    public function activar(Request $request, Response $response, $args, \Slim\Container $container) {
        try {
            $container->dbEloquent;
            $empresa = Empresa::find($args['idEmpresa']);
            if ($empresa != null) {
                $data = $request->getParsedBody();
                $empresa->activa = filter_var($data['activa'], FILTER_SANITIZE_STRING) == 'true';
                $empresa->validada = filter_var($data['validada'], FILTER_SANITIZE_STRING) == 'true';
                $empresa->save();
                return $response->withJSON($empresa);
            } else {
                return $response->withJson("No es troba cap empresa amb l'identificador demanat.", 422);
            }
        } catch (\Illuminate\Database\QueryException $ex) {
            switch ($ex->getCode()) {
                case 23000:
                    $missatge = array("missatge" => "Dades duplicades. Segurament degut a que el correu electrònic ja està registrat per un altre contacte.");
                    break;
                case 'HY000':
                    $missatge = array("missatge" => "Algunes de les dades obligatòries han arribat sense valor.");
                    break;
                default:
                    $missatge = array("missatge" => "L'empresa no s'ha pogut modificar.");
                    break;
            }
            return $response->withJson($missatge, 422);
        }
    }

}
