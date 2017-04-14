<?php

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use Borsa\Professor as Professor;
use Borsa\Estudis as Estudis;

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
//
//$container['db'] = function ($c) {
//    $db = $c['settings']['db'];
//    $pdo = new PDO("mysql:host=" . $db['host'] . ";dbname=" . $db['dbname'], $db['user'], $db['pass']);
//    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
//    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
//    return $pdo;
//};


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
    return $this->view->render($response, 'index.html');
});

// Entrada Empresa
$app->get('/empresa', function ($request, $response, $args) {
    return $this->view->render($response, 'empresa/indexEmpresa.html', ['tipus' => 20]);
});

//Entrada Alumnes
$app->get('/alumne', function ($request, $response, $args) {
    return $this->view->render($response, 'alumne/indexAlumne.html', ['tipus' => 30]);
});

//Entrada Professors
$app->get('/professor', function ($request, $response, $args) {
    return $this->view->render($response, 'professor/indexProfessor.html', ['tipus' => 10]);
});

//Alta empresa
$app->get('/altaEmpresa', function ($request, $response, $args) {
//   $objEmpresa=new Empresa(1,'Bestard','<h1>Bestard</h1><p>Idòa això</p>','Carrer nou 9','07330','Lloseta','Balears','987456321','info@bestard.com',true,false,'12/03/2017','www.bestar.com');
    return $this->view->render($response, 'empresa/altaEmpresa.html');
});
$app->post('/altaEmpresa', function ($request, $response) {
    $data = $request->getParsedBody();
   
    $empresa = new Empresa(filter_var($data['idEmpresa'], FILTER_SANITIZE_STRING)
            , filter_var($data['Nom'], FILTER_SANITIZE_STRING)
            , $data['descripcio']
            , filter_var($data['Adreca'], FILTER_SANITIZE_STRING)
            , filter_var($data['CodiPostal'], FILTER_SANITIZE_STRING)
            , filter_var($data['Localitat'], FILTER_SANITIZE_STRING)
            , filter_var($data['Provincia'], FILTER_SANITIZE_STRING)
            , filter_var($data['Telefon'], FILTER_SANITIZE_STRING)
            , filter_var($data['email'], FILTER_SANITIZE_EMAIL)
            , filter_var($data['Actiu'], FILTER_SANITIZE_STRING)
            , false
            , filter_var($data['Nom'], FILTER_SANITIZE_STRING)
            , filter_var($data['url'], FILTER_SANITIZE_URL)
    );

    //$response->getBody()->write("Ok");
    $response=$response->withJson($empresa->expose());
    return $response;
});


$app->get('/professor/{id}', function(Request $request, Response $response, $args) {
//return recuperaInteri($request, $response, $this->db);
    $this->dbEloquent;
    return $response->withJSON(Professor::find($args['id']));
});
$app->get('/estudis', function(Request $request, Response $response) {
//return recuperaInteri($request, $response, $this->db);
    $this->dbEloquent;
    return $response->withJson(Estudis::All());
//    return $this->view->render($response, 'estudis.html.twig', [
//                 'estudis' => Estudis::All()
//    ]);
});

$app->get('/estudisProfessor/{id}', function(Request $request, Response $response, $args) {
//return recuperaInteri($request, $response, $this->db);
    $this->dbEloquent;
    $prof=Professor::find($args['id']);
    $estudis=$prof->estudis;
    return $response->withJSON($estudis);
});
//Final

$app->run();

