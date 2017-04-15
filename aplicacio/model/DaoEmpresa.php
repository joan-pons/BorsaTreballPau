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
class DaoEmpresa {

    public function altaEmpresa(Request $request, Response $response, \Slim\Container $container) {
        //TO-DO: Filtrar descripció
        $container->dbEloquent;
        $data = $request->getParsedBody();
        $empresa = new Empresa;
        $empresa->Nom = filter_var($data['Nom'], FILTER_SANITIZE_STRING);
        $empresa->Descripcio = $data['descripcio'];
        $empresa->Adreca = filter_var($data['Adreca'], FILTER_SANITIZE_STRING);
        $empresa->CodiPostal = filter_var($data['CodiPostal'], FILTER_SANITIZE_STRING);
        $empresa->Localitat = filter_var($data['Localitat'], FILTER_SANITIZE_STRING);
        $empresa->Provincia = filter_var($data['Provincia'], FILTER_SANITIZE_STRING);
        $empresa->Telefon = filter_var($data['Telefon'], FILTER_SANITIZE_STRING);
        $empresa->email = filter_var($data['email'], FILTER_SANITIZE_EMAIL);
        $empresa->Activa = filter_var($data['Actiu'], FILTER_SANITIZE_STRING) == 'true';
        $empresa->Validada = false;
        $empresa->url = filter_var($data['url'], FILTER_SANITIZE_URL);
        //$empresa->DataAlta= \Carbon::now();
        $empresa->save();
        return $response->withJSON($empresa);
    }

    public function modificarEmpresa(Request $request, Response $response, \Slim\Container $container) {
        //TO-DO: Filtrar descripció
        $container->dbEloquent;
        $data = $request->getParsedBody();
        $empresa = Empresa::find($data['idEmpresa']);
        $empresa->Nom = filter_var($data['Nom'], FILTER_SANITIZE_STRING);
        $empresa->Descripcio = $data['descripcio'];
        $empresa->Adreca = filter_var($data['Adreca'], FILTER_SANITIZE_STRING);
        $empresa->CodiPostal = filter_var($data['CodiPostal'], FILTER_SANITIZE_STRING);
        $empresa->Localitat = filter_var($data['Localitat'], FILTER_SANITIZE_STRING);
        $empresa->Provincia = filter_var($data['Provincia'], FILTER_SANITIZE_STRING);
        $empresa->Telefon = filter_var($data['Telefon'], FILTER_SANITIZE_STRING);
        $empresa->email = filter_var($data['email'], FILTER_SANITIZE_EMAIL);
        $empresa->Activa = filter_var($data['Actiu'], FILTER_SANITIZE_STRING) == 'true';
        $empresa->Validada = false;
        $empresa->url = filter_var($data['url'], FILTER_SANITIZE_URL);
        //$empresa->DataAlta= \Carbon::now();
        $empresa->save();
        return $response->withJSON($empresa);
    }

    public function altaContacte(Request $request, Response $response, \Slim\Container $container) {

        $container->dbEloquent;
        $data = $request->getParsedBody();
        $contacte = new Contacte;
        $contacte->Nom = filter_var($data['Nom'], FILTER_SANITIZE_STRING);
        $contacte->Llinatges = filter_var($data['Llinatges'], FILTER_SANITIZE_STRING);
        $contacte->Telefon = filter_var($data['Telefon'], FILTER_SANITIZE_STRING);
        $contacte->email = filter_var($data['email'], FILTER_SANITIZE_EMAIL);
        $contacte->idEmpresa = filter_var($data['idEmpresa'], FILTER_SANITIZE_NUMBER_INT);
        $contacte->save();
        return $response->withJSON($contacte);
    }

    public function contactesEmpresa($idEmpresa){
        $contactes = Contacte::all()->where('idEmpresa',$idEmpresa);
        return $contactes;
    }
}
