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
            $professor->nom = filter_var($data['nom'], FILTER_SANITIZE_STRING);
            $professor->llinatges = filter_var($data['llinatges'], FILTER_SANITIZE_STRING);
            $professor->telefon = filter_var($data['telefon'], FILTER_SANITIZE_STRING);
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

    public function modificarProfessor(Request $request, Response $response, $args, \Slim\Container $container) {
        try {
            $container->dbEloquent;
            $data = $request->getParsedBody();
            $professor = Professor::find($args['idProfessor']);
            if ($professor != null) {
                $professor->nom = filter_var($data['nom'], FILTER_SANITIZE_STRING);
                $professor->llinatges = filter_var($data['llinatges'], FILTER_SANITIZE_STRING);
                $professor->telefon = filter_var($data['telefon'], FILTER_SANITIZE_STRING);
                $professor->email = filter_var($data['email'], FILTER_SANITIZE_EMAIL);
                $professor->save();
                return $response->withJSON($professor);
            } else {
                $missatge = array("missatge" => "No s'ha trobat el professor que es vol modificar.");
                return $response->withJson($missatge, 422);
            }
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
            if ($professor != null) {
                $codiEstudis = filter_var($data['codiEstudis'], FILTER_SANITIZE_STRING);
                $professor->estudis()->sync([$codiEstudis], false);

                return $response->withJSON($professor);
            } else {
                $missatge = array("missatge" => "No s'ha trobat el professor que es vol modificar.");
                return $response->withJson($missatge, 422);
            }
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
            $estudis = $args['codiEstudis'];
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

    public function activar(Request $request, Response $response, $args, \Slim\Container $container) {
        try {
            $container->dbEloquent;

            $professor = Professor::find($args['idProfessor']);
            if ($professor != null) {
                $data = $request->getParsedBody();
                $professor->actiu = filter_var($data['actiu'], FILTER_SANITIZE_STRING) == 'true';
                $professor->validat = filter_var($data['validat'], FILTER_SANITIZE_STRING) == 'true';
                $professor->save();
                return $response->withJSON($professor);
            } else {
                return $response->withJson("No es troba cap professor amb l'identificador demanat.", 422);
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
                    $missatge = array("missatge" => "El professor no s'ha pogut modificar.");
                    break;
            }
            return $response->withJson($missatge, 422);
        }
    }

    public function rols(Request $request, Response $response, $args, \Slim\Container $container) {
        try {
            $container->dbEloquent;

            $professor = Professor::find($args['idProfessor']);
            if ($professor != null) {
                $usuari = $professor->getUsuari();
                return $response->withJSON($usuari->rols);
            } else {
                return $response->withJson("No es troba cap professor amb l'identificador demanat.", 422);
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
                    $missatge = array("missatge" => "El professor no s'ha pogut modificar.");
                    break;
            }
            return $response->withJson($missatge, 422);
        }
    }

    public function afegirRol(Request $request, Response $response, $args, \Slim\Container $container) {
        try {
            $container->dbEloquent;
            $professor = Professor::find($args['idProfessor']);
            if ($professor != null) {
                $usuari = $professor->getUsuari();
                $data = $request->getParsedBody();
                $idrol = filter_var($data['idRol'], FILTER_SANITIZE_NUMBER_INT);
                $usuari->rols()->sync([$idrol], false);

                return $response->withJSON($professor);
            } else {
                $missatge = array("missatge" => "No s'ha trobat el professor que es vol modificar.");
                return $response->withJson($missatge, 422);
            }
        } catch (\Illuminate\Database\QueryException $ex) {
            switch ($ex->getCode()) {
                case 23000:
                    $missatge = array("missatge" => "Dades duplicades. Segurament degut a que ja és administrador");
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

    public function eliminarRol(Request $request, Response $response, $args, \Slim\Container $container) {
        try {
            $container->dbEloquent;
            $professor = Professor::find($args['idProfessor']);
            
            if ($professor != null) {
                $usuari = $professor->getUsuari();
                $data = $request->getParsedBody();
                $idRol = filter_var($data['idRol'], FILTER_SANITIZE_NUMBER_INT);
                $usuari->rols()->detach([$idRol]);

                return $response->withJSON($professor);
            } else {
                $missatge = array("missatge" => "No s'ha trobat el professor que es vol modificar.");
                return $response->withJson($missatge, 422);
            }
        } catch (\Illuminate\Database\QueryException $ex) {
            switch ($ex->getCode()) {
                case 23000:
                    $missatge = array("missatge" => "Dades duplicades. Segurament degut a que ja és administrador");
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

}
