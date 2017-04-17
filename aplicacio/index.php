<?php

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use Borsa\Professor as Professor;
use Borsa\Estudis as Estudis;
use Borsa\Empresa as Empresa;
use Borsa\DaoEmpresa as DaoEmpresa;

require 'vendor/autoload.php';

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

// Entrada Empresa
$app->get('/empresaLogin', function ($request, $response, $args) {
    return $this->view->render($response, 'empresa/indexEmpresa.html.twig', ['tipus' => 20]);
});

//Alta empresa
$app->get('/altaEmpresa', function ($request, $response, $args) {
//   $objEmpresa=new Empresa(1,'Bestard','<h1>Bestard</h1><p>Idòa això</p>','Carrer nou 9','07330','Lloseta','Balears','987456321','info@bestard.com',true,false,'12/03/2017','www.bestar.com');
    return $this->view->render($response, 'empresa/altaEmpresa.html.twig');
});

$app->post('/altaEmpresa', function ($request, $response) {
    return DaoEmpresa::altaEmpresa($request, $response, $this);
});

// Entrada Empresa
$app->get('/empresa/dashBoard', function ($request, $response, $args) {
    $this->dbEloquent;
    $empresa = Empresa::find(2);
    //$contactes=DaoEmpresa::contactesEmpresa($empresa->idEmpresa);
    return $this->view->render($response, 'empresa/dashBoard.html.twig', ['empresa' => $empresa]);//,'contactes'=>$contactes]);
});
$app->get('/empresa/modificarDades', function ($request, $response, $args) {
    $this->dbEloquent;
    $empresa = Empresa::find(2);
    return $this->view->render($response, 'empresa/empresaDades.html.twig', ['objEmpresa' => $empresa]);
});
$app->put('/empresa/modificarDades', function ($request, $response, $args) {
    return DaoEmpresa::modificarEmpresa($request, $response, $this);
});

$app->get('/empresa/afegirContacte', function ($request, $response, $args) {
    $this->dbEloquent;
    $empresa = Empresa::find(2);    
    return $this->view->render($response, 'empresa/afegirContacte.html.twig', ['objEmpresa' => $empresa]);
});
$app->post('/empresa/afegirContacte', function ($request, $response, $args) {
    return DaoEmpresa::altaContacte($request, $response, $this);
});
$app->put('/empresa/modificarContacte', function ($request, $response) {
    return DaoEmpresa::modificarContacte($request, $response, $this);
});
$app->delete('/empresa/esborrarContacte/{idContacte}', function ($request, $response, $args) {
    return DaoEmpresa::esborrarContacte($request, $response, $args, $this);
});
$app->get('/empresa/contactes', function ($request, $response, $args) {
    $this->dbEloquent;
    $empresa = Empresa::find(2);
    return $this->view->render($response, 'empresa/contactes.html.twig', ['empresa' => $empresa]);
});
$app->get('/empresa/contactesProves', function ($request, $response, $args) {
    $this->dbEloquent;
    $empresa = Empresa::find(2);
    return $response->withJson($empresa->contactes);
});

//Entrada Alumnes
$app->get('/alumne', function ($request, $response, $args) {
    return $this->view->render($response, 'alumne/indexAlumne.html', ['tipus' => 30]);
});

//Entrada Professors
$app->get('/professor', function ($request, $response, $args) {
    return $this->view->render($response, 'professor/indexProfessor.html', ['tipus' => 10]);
});



$app->get('/professor/{id}', function(Request $request, Response $response, $args) {
//return recuperaInteri($request, $response, $this->db);
    $this->dbEloquent;
    return $response->withJSON(Professor::find($args['id']));
});
$app->get('/estudis', function(Request $request, Response $response) {
//return recuperaInteri($request, $response, $this->db);
    $this->dbEloquent;
    //  return $response->withJson(Estudis::All());
    return $this->view->render($response, 'estudis.html.twig', [
                'estudis' => Estudis::All()
    ]);
});

$app->get('/estudisProfessor/{id}', function(Request $request, Response $response, $args) {
//return recuperaInteri($request, $response, $this->db);
    $this->dbEloquent;
    $prof = Professor::find($args['id']);
    $estudis = $prof->estudis;
    return $response->withJSON($estudis);
});
//Final

$app->run();

