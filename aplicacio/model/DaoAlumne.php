<?php

namespace Borsa;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use Borsa\Alumne as Alumne;

/**
 * Description of DaoProfessor
 *
 * @author joan
 */
class DaoAlumne extends Dao {

    public function modificarDades(Request $request, Response $response, $args, \Slim\Container $container) {
        try {
            $container->dbEloquent;
            $data = $request->getParsedBody();
            $alumne = Alumne::find($args['idAlumne']);
            if ($alumne != null) {
                $alumne->nom = filter_var($data['nom'], FILTER_SANITIZE_STRING, FILTER_FLAG_NO_ENCODE_QUOTES);
                $alumne->llinatges = filter_var($data['llinatges'], FILTER_SANITIZE_STRING, FILTER_FLAG_NO_ENCODE_QUOTES);
                $alumne->descripcio = $data['descripcio'];
                $alumne->adreca = filter_var($data['adreca'], FILTER_SANITIZE_STRING, FILTER_FLAG_NO_ENCODE_QUOTES);
                $alumne->codiPostal = filter_var($data['codiPostal'], FILTER_SANITIZE_STRING, FILTER_FLAG_NO_ENCODE_QUOTES);
                $alumne->localitat = filter_var($data['localitat'], FILTER_SANITIZE_STRING, FILTER_FLAG_NO_ENCODE_QUOTES);
                $alumne->provincia = filter_var($data['provincia'], FILTER_SANITIZE_STRING, FILTER_FLAG_NO_ENCODE_QUOTES);
                $alumne->telefon = filter_var($data['telefon'], FILTER_SANITIZE_STRING, FILTER_FLAG_NO_ENCODE_QUOTES);
                $alumne->email = filter_var($data['email'], FILTER_SANITIZE_EMAIL);
                $alumne->actiu = filter_var($data['actiu'], FILTER_SANITIZE_STRING) == 'true';
                $alumne->url = filter_var($data['url'], FILTER_SANITIZE_URL);
                $alumne->save();
                return $response->withJSON($alumne);
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
                    $missatge = array("missatge" => "Les dades de l'alumne no s'han pogut modificar correctament.");
                    break;
            }
            return $response->withJson($missatge, 422);
        }
    }

    public function afegirEstudis(Request $request, Response $response, \Slim\Container $container) {
        try {
            $container->dbEloquent;
            $data = $request->getParsedBody();
            $alumne = Alumne::find($data['idAlumne']);
            if ($alumne != null) {
                $codiEstudis = filter_var($data['codiEstudis'], FILTER_SANITIZE_STRING);
              //  $alumne->estudis()->sync(array($codiEstudis => array('any' => $data['any'], 'nota' => $data['nota'])), false);
                $alumne->estudis()->attach($codiEstudis, array('any' => $data['any'], 'nota' => $data['nota']));
                return $response->withJSON($alumne);
            } else {
                $missatge = array("missatge" => "No s'ha trobat l'alumne que es vol modificar.");
                return $response->withJson($missatge, 422);
            }
        } catch (\Illuminate\Database\QueryException $ex) {
            switch ($ex->getCode()) {
                case 23000:
                    $missatge = array("missatge" => "Dades duplicades. Segurament degut a que ja tens registrats els estudis que vols afegir.");
                    break;
                case 'HY000':
                    $missatge = array("missatge" => "Algunes de les dades obligatòries han arribat sense valor.");
                    break;
                default:
                    $missatge = array("missatge" => "Els estudis no s'han pogut afegir correctament a la teva llista.");
                    break;
            }
            return $response->withJson($missatge, 422);
        }
    }

    public function esborrarEstudis(Request $request, Response $response, $args, \Slim\Container $container) {
        try {
            $container->dbEloquent;

            $alumne = Alumne::find($args['idAlumne']);
            $estudis = $args['codiEstudis'];
            if ($alumne != null) {
                $alumne->estudis()->detach($estudis);
                return $response->withJSON($alumne);
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
                    $missatge = array("missatge" => "No s'ha pogut dur a terme l'eliminació.");
                    break;
            }
            return $response->withJson($missatge, 422);
        }
    }


    public function modificarEstudis(Request $request, Response $response, $args, \Slim\Container $container) {
        try {
            $container->dbEloquent;
            $data = $request->getParsedBody();
            $alumne = Alumne::find($args['idAlumne']);
            if ($alumne != null) {
                $codiEstudis = filter_var($args['codiEstudis'], FILTER_SANITIZE_STRING);
                $alumne->estudis()->sync(array($codiEstudis => array('any' => $data['any'], 'nota' => $data['nota'])), false);
                return $response->withJSON($alumne);
            } else {
                $missatge = array("missatge" => "No s'ha trobat l'alumne que es vol modificar.");
                return $response->withJson($missatge, 422);
            }
        } catch (\Illuminate\Database\QueryException $ex) {
            switch ($ex->getCode()) {
                case 23000:
                    $missatge = array("missatge" => "Dades duplicades. Segurament degut a que ja tens registrats els estudis que vols afegir.");
                    break;
                case 'HY000':
                    $missatge = array("missatge" => "Algunes de les dades obligatòries han arribat sense valor.");
                    break;
                default:
                    $missatge = array("missatge" => "Els estudis no s'han pogut afegir correctament a la teva llista.");
                    break;
            }
            return $response->withJson($missatge, 422);
        }
    }

public function modificarIdiomes(Request $request, Response $response, $args, \Slim\Container $container) {
        try {
            $container->dbEloquent;
            $data = $request->getParsedBody();
            $alumne = Alumne::find($args['idAlumne']);
            if ($alumne != null) {
//                $codiEstudis = filter_var($args['codiEstudis'], FILTER_SANITIZE_STRING);
//                $alumne->estudis()->sync(array($codiEstudis => array('any' => $data['any'], 'nota' => $data['nota'])), false);
                $rebudes=$data['nivells'];
                $dades=array();
                foreach($rebudes as $nivell){
                   
                    $dades[$nivell['idIdioma']]=array('NIvellsIdioma_idNIvellsIdioma'=>$nivell['NIvellsIdioma_idNIvellsIdioma']);
                   
                }
                $alumne->idiomes()->sync($dades);
                return $response->withJSON($dades);
            } else {
                $missatge = array("missatge" => "No s'ha trobat l'alumne que es vol modificar.");
                return $response->withJson($missatge, 422);
            }
        } catch (\Illuminate\Database\QueryException $ex) {
            switch ($ex->getCode()) {
                case 23000:
                    $missatge = array("missatge" => "Dades duplicades. Segurament degut a que ja tens registrats els estudis que vols afegir.");
                    break;
                case 'HY000':
                    $missatge = array("missatge" => "Algunes de les dades obligatòries han arribat sense valor.");
                    break;
                default:
                    $missatge = array("missatge" => "Els estudis no s'han pogut afegir correctament a la teva llista.");
                    break;
            }
            return $response->withJson($missatge, 422);
        }
    }

}
