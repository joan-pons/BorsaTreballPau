<?php

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use Borsa\Professor as Professor;
use Borsa\Estudis as Estudis;
use Borsa\Empresa as Empresa;
use Borsa\DaoEmpresa as DaoEmpresa;
use Borsa\Usuari as Usuari;
use Borsa\DaoProfessor as DaoProfessor;
use Borsa\Dao as Dao;

require 'vendor/autoload.php';
session_start();

$config['displayErrorDetails'] = true;
$config['addContentLengthHeader'] = false;

$config['db']['driver'] = "mysql";
$config['db']['host'] = "localhost";
$config['db']['username'] = "usuariWeb";
$config['db']['password'] = "seCret_16";
$config['db']['database'] = "borsa";
$config['db']['charset'] = "utf8";
$config['db']['collation'] = "utf8_unicode_ci";
$config['db']['prefix'] = "";


//Crear aplicació utilitzant la configuració demanada
$app = new \Slim\App(["settings" => $config]);


//Contenidor de dependències
$container = $app->getContainer();

//$container['logger'] = function($c) {
////$c és el contenidor, de manera que podem utilitzar altres dependències
////Inicialitzam el contenidor. La funció només s'executa una vegada.
////L'objecte creat i tornat és el que s'assigna al contenidor.
//    $logger = new \Monolog\Logger('my_logger');
//    $file_handler = new \Monolog\Handler\StreamHandler("../logs/app.log");
//    $logger->pushHandler($file_handler);
//    return $logger;
//};
//


$container['db'] = function ($c) {
    $db = $c['settings']['db'];
    $pdo = new PDO("mysql:host=" . $db['host'] . ";dbname=" . $db['dbname'], $db['user'], $db['pass']);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    return $pdo;
};

$container['dbEloquent'] = function ($container) {
    $db = $container['settings']['db'];
    $capsule = new \Illuminate\Database\Capsule\Manager;
    $capsule->addConnection($db, 'default');

    $capsule->setAsGlobal();
    $capsule->bootEloquent();

    return $capsule;
};

$container['view'] = function ($container) {
    $view = new \Slim\Views\Twig('plantilles'/* , ['cache' => 'path/to/cache'] */);

    // Instantiate and add Slim specific extension
    $basePath = rtrim(str_ireplace('index.php', '', $container['request']->getUri()->getBasePath()), '/');
    $view->addExtension(new Slim\Views\TwigExtension($container['router'], $basePath));

    return $view;
};


// Index
$app->get('/', function ($request, $response, $args) {
    return $this->view->render($response, 'index.html.twig');
});

$app->get('/sortir', function ($request, $response, $args) {
    session_unset();
    session_destroy();
    return $response->withRedirect("/");
});

$app->get('/login', function ($request, $response, $args) {
    return Dao::entrada($request, $response, $args, $this);
//    $this->dbEloquent;
//    $data = $request->getQueryParams();
//    $usuari = Usuari::where('nomUsuari', $data['nomUsuari'])->first();
//    if ($usuari == null || $usuari->contrasenya != $data['password']) {
//        $missatge = array("missatge" => "L'usuari i/o la contrasenya estan equivocats.");
//        return $response->withJson($missatge, 401);
//    } else {
//        session_unset();
//        session_destroy();
//
//        session_start();
//        $_SESSION["idUsuari"] = $usuari->idusuari;
//        $rols = [];
//        foreach ($usuari->rols as $rol) {
//            $rols[] = $rol->idrol;
//        }
//        $_SESSION["rols"] = $rols;
//        return $response->withJSON( array("missatge" => "Usuari validat correctament."));
//    }
//   
//    $_SESSION["idUsuari"] = 4;
//    return $response->withJSON($_SESSION);
});
//////////////////////////////////////////////////////////////
/////////////////////                  ///////////////////////
//|||||||||||||||||||      EMPRESA     |||||||||||||||||||||||
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
// Entrada Empresa
$app->get('/empresaLogin', function ($request, $response, $args) {
    return $this->view->render($response, 'empresa/indexEmpresa.html.twig', ['tipus' => 20]);
});

//Alta empresa
$app->get('/altaEmpresa', function ($request, $response, $args) {
    return $this->view->render($response, 'empresa/altaEmpresa.html.twig');
});

$app->post('/altaEmpresa', function ($request, $response) {
    return DaoEmpresa::altaEmpresa($request, $response, $this);
});

// Entrada Empresa
$app->get('/empresa/dashBoard', function ($request, $response, $args) {
    $this->dbEloquent;
    $empresa = Empresa::find($_SESSION['idUsuari']);
    return $this->view->render($response, 'empresa/dashBoard.html.twig', ['empresa' => $empresa]); //,'contactes'=>$contactes]);
});

$app->get('/empresa/modificarDades', function ($request, $response, $args) {
    $this->dbEloquent;
    $empresa = Empresa::find($_SESSION['idUsuari']);
    return $this->view->render($response, 'empresa/empresaDades.html.twig', ['objEmpresa' => $empresa]);
});

$app->put('/empresa/modificarDades/{idEmpresa}', function ($request, $response, $args) {
    return DaoEmpresa::modificarEmpresa($request, $response, $args, $this);
});

$app->get('/empresa/afegirContacte', function ($request, $response, $args) {
    $this->dbEloquent;
    $empresa = Empresa::find($_SESSION['idUsuari']);
    return $this->view->render($response, 'empresa/afegirContacte.html.twig', ['objEmpresa' => $empresa]);
});
$app->post('/empresa/afegirContacte', function ($request, $response, $args) {
    return DaoEmpresa::altaContacte($request, $response, $this);
});
$app->put('/empresa/modificarContacte/{idContacte}', function ($request, $response, $args) {
    return DaoEmpresa::modificarContacte($request, $response, $args, $this);
});
$app->delete('/empresa/esborrarContacte/{idContacte}', function ($request, $response, $args) {
    return DaoEmpresa::esborrarContacte($request, $response, $args, $this);
});
$app->get('/empresa/contactes', function ($request, $response, $args) {
    $this->dbEloquent;
    $empresa = Empresa::find($_SESSION['idUsuari']);
    return $this->view->render($response, 'empresa/contactes.html.twig', ['empresa' => $empresa]);
});
$app->get('/empresa/contactesProves', function ($request, $response, $args) {
    $this->dbEloquent;
    $empresa = Empresa::find($_SESSION['idUsuari']);
    return $response->withJson($empresa->contactes);
});
$app->get('/empresa/canviarContrasenya', function ($request, $response, $args) {
    $this->dbEloquent;
    $usuari = Usuari::find($_SESSION['idUsuari']);
    $empresa = $usuari->getEntitat();
    return $this->view->render($response, 'empresa/contrasenya.html.twig', ['empresa' => $empresa, "tipusUsuari" => 20, "usuari" => $usuari]);
});
$app->put('/empresa/canviarContrasenya/{idusuari}', function ($request, $response, $args) {
    return DaoEmpresa::canviarContrasenya($request, $response, $args, $this);
});

$app->get('/empresa/{id}', function(Request $request, Response $response, $args) {
//return recuperaInteri($request, $response, $this->db);
    $this->dbEloquent;
    return $response->withJSON(Empresa::find($args['id']));
});
//Entrada Alumnes
$app->get('/alumne', function ($request, $response, $args) {
    return $this->view->render($response, 'alumne/indexAlumne.html', ['tipus' => 30]);
});


//////////////////////////////////////////////////////////////
/////////////////////                  ///////////////////////
/////////////////////   PROFESSORS     ///////////////////////
/////////////////////                  ///////////////////////
//////////////////////////////////////////////////////////////
//
//Entrada Professors
$app->get('/professorLogin', function ($request, $response, $args) {
    return $this->view->render($response, 'professor/indexProfessor.html.twig', ['tipus' => 10]);
});

//Alta Professor
$app->get('/altaProfessor', function ($request, $response, $args) {
    return $this->view->render($response, 'professor/altaProfessor.html.twig');
});

$app->post('/altaProfessor', function ($request, $response) {
    return DaoProfessor::altaProfessor($request, $response, $this);
});

$app->get('/professor/dashBoard', function ($request, $response, $args) {
    $this->dbEloquent;
    $usuari = Usuari::find($_SESSION["idUsuari"]);
    if ($usuari != null) {
        $prof = $usuari->getEntitat();
        $empreses = null;
        $companys = null;
        if ($usuari->teRol(40)) {
            $empreses = Empresa::where('Validada', 0)->orderBy('DataAlta', 'ASC')->orderBy('Nom', 'ASC')->get();
            $companys = Professor::where('Validat', 0)->orderBy('Email', 'ASC')->get();
        }
        return $this->view->render($response, 'professor/dashBoard.html.twig', ['professor' => $prof, 'usuari' => $usuari, 'empreses' => $empreses, 'companys' => $companys]);
    } else {
        return $response->withJSON('Errada: ' . $_SESSION);
    }
});


$app->get('/professor/modificarDades', function ($request, $response, $args) {
    $this->dbEloquent;
    $usuari = Usuari::find($_SESSION['idUsuari']);
    $prof = $usuari->getEntitat();
    return $this->view->render($response, 'professor/professorDades.html.twig', ['professor' => $prof]);
});

$app->put('/professor/modificarDades/{idProfessor}', function ($request, $response, $args) {
    return DaoProfessor::modificarProfessor($request, $response, $args, $this);
});

$app->get('/professor/canviarContrasenya', function ($request, $response, $args) {
    $this->dbEloquent;
    $usuari = Usuari::find($_SESSION['idUsuari']);
    $professor = $usuari->getEntitat();
    return $this->view->render($response, 'professor/contrasenya.html.twig', ['professor' => $professor, "tipusUsuari" => 10, "usuari" => $usuari]);
});
$app->put('/professor/canviarContrasenya/{idusuari}', function ($request, $response, $args) {
    return DaoProfessor::canviarContrasenya($request, $response, $args, $this);
});

$app->get('/professor/estudis', function ($request, $response, $args) {
    $this->dbEloquent;
    $usuari = Usuari::find($_SESSION['idUsuari']);
    $professor = $usuari->getEntitat();
    $etiquetes = array("subtitol" => "", "labelLlista" => "dels que és responsable");
    $estudis = Estudis::orderBy('Nom', 'ASC')->get();
    return $this->view->render($response, 'professor/professorEstudis.html.twig', ['professor' => $professor, "etiquetes" => $etiquetes, 'estudis' => $estudis]);
});

$app->post('/professor/estudis', function($request, $response, $args) {
    return DaoProfessor::afegirEstudis($request, $response, $this);
});

$app->delete('/professor/estudis/{idProfessor}/{codiEstudis}', function ($request, $response, $args) {
    return DaoProfessor::esborrarEstudis($request, $response, $args, $this);
});


$app->get('/professor/usuarisPendents', function ($request, $response, $args) {
    $this->dbEloquent;
    $usuari = Usuari::find($_SESSION['idUsuari']);
    $prof = $usuari->getEntitat();
    $companys = null;
    if ($usuari->teRol(40)) {
        $companys = Professor::where('Validat', 0)->orderBy('Email', 'ASC')->get();
    }
    return $this->view->render($response, 'professor/usuarisPendents.html.twig', ['professor' => $prof, 'companys' => $companys]);
});

$app->put('/professor/usuaris/{idProfessor}', function ($request, $response, $args) {
    return DaoProfessor::activar($request, $response, $args, $this);
});

$app->get('/professor/usuaris', function ($request, $response, $args) {
    $this->dbEloquent;
    $usuari = Usuari::find($_SESSION['idUsuari']);
    $prof = $usuari->getEntitat();
    $companys = Professor::orderBy('Email', 'ASC')->get();
    return $this->view->render($response, 'professor/usuaris.html.twig', ['professor' => $prof, 'companys' => $companys]);
});

$app->get('/professor/administrador', function ($request, $response, $args) {
    $this->dbEloquent;
    $usuari = Usuari::find($_SESSION['idUsuari']);
    $prof = $usuari->getEntitat();
    $companys = Professor::orderBy('Email', 'ASC')->get();
    return $this->view->render($response, 'professor/administrador.html.twig', ['professor' => $prof, 'companys' => $companys]);
});


$app->get('/professor/rols/{idProfessor}', function(Request $request, Response $response, $args) {
    return DaoProfessor::rols($request, $response, $args, $this);
});

$app->put('/professor/rols/{idProfessor}', function(Request $request, Response $response, $args) {
    return DaoProfessor::afegirRol($request, $response, $args, $this);
});

$app->delete('/professor/rols/{idProfessor}', function(Request $request, Response $response, $args) {
    return DaoProfessor::eliminarRol($request, $response, $args, $this);
});

$app->get('/professor/empreses', function ($request, $response, $args) {
    $this->dbEloquent;
    $usuari = Usuari::find($_SESSION['idUsuari']);
    $prof = $usuari->getEntitat();
    $empreses = Empresa::orderBy('Nom', 'ASC')->get();
    return $this->view->render($response, 'professor/empreses.html.twig', ['professor' => $prof, 'empreses' => $empreses]);
});

$app->get('/professor/empresesPendents', function ($request, $response, $args) {
    $this->dbEloquent;
    $usuari = Usuari::find($_SESSION['idUsuari']);
    $prof = $usuari->getEntitat();
    $empreses = null;
    $empreses = Empresa::where('Validada', 0)->orderBy('DataAlta', 'ASC')->orderBy('Nom', 'ASC')->get();
    return $this->view->render($response, 'professor/empresesPendents.html.twig', ['professor' => $prof, 'usuari' => $usuari, 'empreses' => $empreses]);
});

$app->put('/professor/empreses/{idEmpresa}', function ($request, $response, $args) {
    return DaoEmpresa::activar($request, $response, $args, $this);
});

$app->get('/professor/{id}', function(Request $request, Response $response, $args) {
    $this->dbEloquent;
    return $response->withJSON(Professor::find($args['id']));
});



$app->get('/estudis', function(Request $request, Response $response) {
    $this->dbEloquent;
    //  return $response->withJson(Estudis::All());
    return $this->view->render($response, 'estudis.html.twig', [
                'estudis' => Estudis::All()
    ]);
});

$app->get('/estudisProfessor/{id}', function(Request $request, Response $response, $args) {
    $this->dbEloquent;
    $usuari = Usuari::find($_SESSION['idUsuari']);
    $prof = $usuari->getEntitat();
    $estudis = $prof->estudis;
//    $empreses = Empresa::where('Validada', false)->get();
    return $response->withJSON(estudis);
});


//Usuaris
$app->get('/usuari/{id}', function(Request $request, Response $response, $args) {
//return recuperaInteri($request, $response, $this->db);
    $this->dbEloquent;
    return $response->withJSON(Usuari::find($args['id'])->getEntitat());
});

//Final

$app->run();

