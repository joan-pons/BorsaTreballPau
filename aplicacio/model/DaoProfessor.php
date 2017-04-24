<?php

namespace Borsa;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use Borsa\Professor as Professor;

/**
 * Description of DaoProfessor
 *
 * @author joan
 */
class DaoProfessor extends Dao {

    public function altaProfessor(Request $request, Response $response, \Slim\Container $container) {

        try {
            $container->dbEloquent;
            $data = $request->getParsedBody();
            $professor = new Professor;
            $professor->Nom = filter_var($data['Nom'], FILTER_SANITIZE_STRING);
            $professor->Llinatges = filter_var($data['Llinatges'], FILTER_SANITIZE_STRING);
            $professor->Telefon = filter_var($data['Telefon'], FILTER_SANITIZE_STRING);
            $professor->email = filter_var($data['email'], FILTER_SANITIZE_EMAIL);
            $professor->save();
            return $response->withJSON($professor);
        } catch (\Illuminate\Database\QueryException $ex) {
            switch ($ex->getCode()) {
                case 23000:
                    $missatge = array("missatge" => "Dades duplicades. Segurament degut a que el correu electrònic ja està registrat.");
                    break;
                case 'HY000':
                    $missatge = array("missatge" => "Algunes de les dades obligatòries han arribat sense valor.");
                    break;
                default:
                    $missatge = array("missatge" => "Les dades del professor no s'han pogut modificar correctament.");
                    break;
            }
            return $response->withJson($missatge, 422);
        }
    }

    public function modificarProfessor(Request $request, Response $response, \Slim\Container $container) {
        try {
            $container->dbEloquent;
            $data = $request->getParsedBody();
            $professor = Professor::find($data['idProfessor']);
            $professor->Nom = filter_var($data['Nom'], FILTER_SANITIZE_STRING);
            $professor->Llinatges = filter_var($data['Llinatges'], FILTER_SANITIZE_STRING);
            $professor->Telefon = filter_var($data['Telefon'], FILTER_SANITIZE_STRING);
            $professor->email = filter_var($data['email'], FILTER_SANITIZE_EMAIL);
            $professor->save();
            return $response->withJSON($professor);
        } catch (\Illuminate\Database\QueryException $ex) {
            switch ($ex->getCode()) {
                case 23000:
                    $missatge = array("missatge" => "Dades duplicades. Segurament degut a que el correu electrònic ja està registrat.");
                    break;
                case 'HY000':
                    $missatge = array("missatge" => "Algunes de les dades obligatòries han arribat sense valor.");
                    break;
                default:
                    $missatge = array("missatge" => "Les dades del professor no s'han pogut modificar correctament.");
                    break;
            }
            return $response->withJson($missatge, 422);
        }
    }

    public function afegirEstudis(Request $request, Response $response, \Slim\Container $container) {
        try {
            $container->dbEloquent;
            $data = $request->getParsedBody();
            $professor = Professor::find($data['idProfessor']);
            $CodiEstudis = filter_var($data['codiEstudis'], FILTER_SANITIZE_STRING);
            $professor->estudis()->sync([$CodiEstudis],false);
            
            return $response->withJSON($professor);
        } catch (\Illuminate\Database\QueryException $ex) {
            switch ($ex->getCode()) {
                case 23000:
                    $missatge = array("missatge" => "Dades duplicades. Segurament degut a que ja és responsable dels estudis que vol afegir.");
                    break;
                case 'HY000':
                    $missatge = array("missatge" => "Algunes de les dades obligatòries han arribat sense valor.");
                    break;
                default:
                    $missatge = array("missatge" => "Els estudis no s'han pogut afegir correctament a la seva llista.");
                    break;
            }
            return $response->withJson($missatge, 422);
        }
    }

    public function esborrarEstudis(Request $request, Response $response, $args, \Slim\Container $container) {
        try {
            $container->dbEloquent;

            $professor = Professor::find($args['idProfessor']);
            $estudis=$args['codiEstudis'];
            if ($professor != null) {
                $professor->estudis()->detach($estudis);
                return $response->withJSON($professor);
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
}
