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
use Borsa\DaoAlumne as DaoAlumne;
use Borsa\Idioma as Idioma;
use Borsa\NivellIdioma as NivellIdioma;
use Borsa\Alumne as Alumne;

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
});

//  //////////////////////////////////////////////////////////
// //////////////////                       /////////////////
//||||||||||||||||||       Empresa         |||||||||||||||||
// \\\\\\\\\\\\\\\\\\                       \\\\\\\\\\\\\\\\\
//  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
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

$app->group('/empresa', function() {
    $this->get('/dashBoard', function ($request, $response, $args) {
        $this->dbEloquent;
        $usuari = Usuari::find($_SESSION["idUsuari"]);
        if ($usuari != null) {
            $empresa = $usuari->getEntitat();
            return $this->view->render($response, 'empresa/dashBoard.html.twig', ['empresa' => $empresa]); //,'contactes'=>$contactes]);
        } else {
            return $response->withJSON('Errada: ' . $_SESSION);
        }
    });

    $this->get('/modificarDades', function ($request, $response, $args) {
        $this->dbEloquent;
        $usuari = Usuari::find($_SESSION["idUsuari"]);
        if ($usuari != null) {
            $empresa = $usuari->getEntitat();
            return $this->view->render($response, 'empresa/empresaDades.html.twig', ['objEmpresa' => $empresa]);
        } else {
            return $response->withJSON('Errada: ' . $_SESSION);
        }
    });

    $this->put('/modificarDades/{idEmpresa}', function ($request, $response, $args) {
        return DaoEmpresa::modificarEmpresa($request, $response, $args, $this);
    });

    $this->get('/afegirContacte', function ($request, $response, $args) {
        $this->dbEloquent;
        $usuari = Usuari::find($_SESSION["idUsuari"]);
        if ($usuari != null) {
            $empresa = $usuari->getEntitat();
            return $this->view->render($response, 'empresa/afegirContacte.html.twig', ['objEmpresa' => $empresa]);
        } else {
            return $response->withJSON('Errada: ' . $_SESSION);
        }
    });

    $this->post('/afegirContacte', function ($request, $response, $args) {
        return DaoEmpresa::altaContacte($request, $response, $this);
    });

    $this->put('/modificarContacte/{idContacte}', function ($request, $response, $args) {
        return DaoEmpresa::modificarContacte($request, $response, $args, $this);
    });

    $this->delete('/esborrarContacte/{idContacte}', function ($request, $response, $args) {
        return DaoEmpresa::esborrarContacte($request, $response, $args, $this);
    });

    $this->get('/contactes', function ($request, $response, $args) {
        $this->dbEloquent;
        $usuari = Usuari::find($_SESSION["idUsuari"]);
        if ($usuari != null) {
            $empresa = $usuari->getEntitat();
            return $this->view->render($response, 'empresa/contactes.html.twig', ['empresa' => $empresa]);
        } else {
            return $response->withJSON('Errada: ' . $_SESSION);
        }
    });

    $this->get('/contactesProves', function ($request, $response, $args) {
        $this->dbEloquent;
        $usuari = Usuari::find($_SESSION["idUsuari"]);
        if ($usuari != null) {
            $empresa = $usuari->getEntitat();
            return $response->withJson($empresa->contactes);
        } else {
            return $response->withJSON('Errada: ' . $_SESSION);
        }
    });

    $this->get('/canviarContrasenya', function ($request, $response, $args) {
        $this->dbEloquent;
        $usuari = Usuari::find($_SESSION["idUsuari"]);
        if ($usuari != null) {
            $empresa = $usuari->getEntitat();
            return $this->view->render($response, 'empresa/contrasenya.html.twig', ['empresa' => $empresa, "tipusUsuari" => 20, "usuari" => $usuari]);
        } else {
            return $response->withJSON('Errada: ' . $_SESSION);
        }
    });

    $this->put('/canviarContrasenya/{idusuari}', function ($request, $response, $args) {
        return DaoEmpresa::canviarContrasenya($request, $response, $args, $this);
    });

    $this->get('/{id}', function(Request $request, Response $response, $args) {
        $this->dbEloquent;
        return $response->withJSON(Empresa::find($args['id']));
    });
})->add(function ($request, $response, $next) {
    if (in_array(20, $_SESSION['rols']) || in_array(40, $_SESSION['rols'])) {
        return $response = $next($request, $response);
    } else {
        return $this->view->render($response, '/auxiliars/noAutoritzat.html.twig')->withStatus(403);
    }
});

//  //////////////////////////////////////////////////////////
// //////////////////                       /////////////////
//||||||||||||||||||       Alumne          |||||||||||||||||
// \\\\\\\\\\\\\\\\\\                       \\\\\\\\\\\\\\\\\
//  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//  
//Entrada Alumnes
$app->get('/alumneLogin', function ($request, $response, $args) {
    return $this->view->render($response, 'alumne/indexAlumne.html.twig', ['tipus' => 30]);
});

$app->group('/alumne', function() {
    $this->get('/dashBoard', function ($request, $response, $args) {
        $this->dbEloquent;
        $usuari = Usuari::find($_SESSION["idUsuari"]);
        if ($usuari != null) {
            $alumne = $usuari->getEntitat();
            $nivellsIdioma = NivellIdioma::orderBy('idNivellIdioma', 'ASC')->get();

            return $this->view->render($response, 'alumne/dashBoard.html.twig', ['alumne' => $alumne, 'usuari' => $usuari, 'nivellsIdioma'=>$nivellsIdioma]);
        } else {
            return $response->withJSON('Errada: ' . $_SESSION);
        }
    });

    $this->get('/modificarDades', function ($request, $response, $args) {
        $this->dbEloquent;
        $usuari = Usuari::find($_SESSION['idUsuari']);
        $alumne = $usuari->getEntitat();
        return $this->view->render($response, 'alumne/alumneDades.html.twig', ['alumne' => $alumne]);
    });

    $this->put('/modificarDades/{idAlumne}', function ($request, $response, $args) {
        return DaoAlumne::modificarDades($request, $response, $args, $this);
    });


    $this->get('/canviarContrasenya', function ($request, $response, $args) {
        $this->dbEloquent;
        $usuari = Usuari::find($_SESSION["idUsuari"]);
        if ($usuari != null) {
            $alumne = $usuari->getEntitat();
            return $this->view->render($response, 'alumne/contrasenya.html.twig', ['alumne' => $alumne, "tipusUsuari" => 30, "usuari" => $usuari]);
        } else {
            return $response->withJSON('Errada: ' . $_SESSION);
        }
    });

    $this->put('/canviarContrasenya/{idusuari}', function ($request, $response, $args) {
        return DaoAlumne::canviarContrasenya($request, $response, $args, $this);
    });

    $this->get('/estudis', function ($request, $response, $args) {
        $this->dbEloquent;
        $usuari = Usuari::find($_SESSION["idUsuari"]);
        if ($usuari != null) {
            $alumne = $usuari->getEntitat();
            $etiquetes = array("subtitol" => "pels que vols que les empreses et trobin", "labelLlista" => "que has acabat");
            $estudis = Estudis::orderBy('nom', 'ASC')->get();
            return $this->view->render($response, 'alumne/alumneEstudis.html.twig', ['alumne' => $alumne, "etiquetes" => $etiquetes, 'estudis' => $estudis]);
        } else {
            return $response->withJSON('Errada: ', 500);
        }
    });

    $this->post('/estudis', function($request, $response, $args) {
        return DaoAlumne::afegirEstudis($request, $response, $this);
    });

    $this->delete('/estudis/{idAlumne}/{codiEstudis}', function ($request, $response, $args) {
        return DaoAlumne::esborrarEstudis($request, $response, $args, $this);
    });

    $this->put('/estudis/{idAlumne}/{codiEstudis}', function ($request, $response, $args) {
        return DaoAlumne::modificarEstudis($request, $response, $args, $this);
    });

    $this->get('/estudis/{IdAlumne}', function ($request, $response, $args) {
        $this->dbEloquent;
        $usuari = Usuari::find($_SESSION["idUsuari"]);
        if ($usuari != null) {
            $alumne = $usuari->getEntitat();
            return $response->withJSON($alumne->estudis);
        } else {
            return $response->withJSON('Errada: ', 500);
        }
    });

    $this->get('/idiomes', function ($request, $response, $args) {
        $this->dbEloquent;
        $usuari = Usuari::find($_SESSION["idUsuari"]);
        if ($usuari != null) {
            $alumne = $usuari->getEntitat();
            $etiquetes = array("subtitol" => "pels que vols que les empreses et trobin", "labelLlista" => "que parles");
            $idiomes = Idioma::orderBy('idioma', 'ASC')->get();
            $nivellsIdioma = NivellIdioma::orderBy('idNivellIdioma', 'ASC')->get();
            return $this->view->render($response, 'alumne/idiomes.html.twig', ['actor' => $alumne, 'identificador'=>$alumne->idAlumne, 'etiquetes' => $etiquetes, 'idiomes' => $idiomes, 'nivellsIdioma' => $nivellsIdioma]);
        } else {
            return $response->withJSON('Errada: ', 500);
        }
    });

    $this->put('/idiomes/{idAlumne}', function ($request, $response, $args) {
        return DaoAlumne::modificarIdiomes($request, $response, $args, $this);
    });

    $this->get('/idiomes/{idAlumne}', function ($request, $response, $args) {
        $this->dbEloquent;
        $alumne = Alumne::find($args["idAlumne"]);
        if ($alumne != null) {

            return $response->withJSON($alumne->idiomes);
        } else {
            return $response->withJSON('Errada: ', 500);
        }
    });
})->add(function ($request, $response, $next) {
    if (in_array(30, $_SESSION['rols']) || in_array(40, $_SESSION['rols'])) {
        return $response = $next($request, $response);
    } else {
        return $this->view->render($response, '/auxiliars/noAutoritzat.html.twig')->withStatus(403);
    }
});

//  //////////////////////////////////////////////////////////
// //////////////////                       /////////////////
//||||||||||||||||||       Professor       |||||||||||||||||
// \\\\\\\\\\\\\\\\\\                       \\\\\\\\\\\\\\\\\
//  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
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

$app->group('/professor', function() {
    $this->get('/dashBoard', function ($request, $response, $args) {
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


    $this->get('/modificarDades', function ($request, $response, $args) {
        $this->dbEloquent;
        $usuari = Usuari::find($_SESSION["idUsuari"]);
        if ($usuari != null) {
            $prof = $usuari->getEntitat();
            return $this->view->render($response, 'professor/professorDades.html.twig', ['professor' => $prof]);
        } else {
            return $response->withJSON('Errada: ' . $_SESSION);
        }
    });

    $this->put('/modificarDades/{idProfessor}', function ($request, $response, $args) {
        return DaoProfessor::modificarProfessor($request, $response, $args, $this);
    });

    $this->get('/canviarContrasenya', function ($request, $response, $args) {
        $this->dbEloquent;
        $usuari = Usuari::find($_SESSION["idUsuari"]);
        if ($usuari != null) {
            $prof = $usuari->getEntitat();
            return $this->view->render($response, 'professor/contrasenya.html.twig', ['professor' => $professor, "tipusUsuari" => 10, "usuari" => $usuari]);
        } else {
            return $response->withJSON('Errada: ' . $_SESSION);
        }
    });

    $this->put('/canviarContrasenya/{idusuari}', function ($request, $response, $args) {
        return DaoProfessor::canviarContrasenya($request, $response, $args, $this);
    });

    $this->get('/estudis', function ($request, $response, $args) {
        $this->dbEloquent;
        $usuari = Usuari::find($_SESSION["idUsuari"]);
        if ($usuari != null) {
            $professor = $usuari->getEntitat();
            $etiquetes = array("subtitol" => "", "labelLlista" => "dels que és responsable");
            $estudis = Estudis::orderBy('Nom', 'ASC')->get();
            return $this->view->render($response, 'professor/professorEstudis.html.twig', ['professor' => $professor, "etiquetes" => $etiquetes, 'estudis' => $estudis]);
        } else {
            return $response->withJSON('Errada: ' . $_SESSION);
        }
    });

    $this->post('/estudis', function($request, $response, $args) {
        return DaoProfessor::afegirEstudis($request, $response, $this);
    });

    $this->delete('/estudis/{idProfessor}/{codiEstudis}', function ($request, $response, $args) {
        return DaoProfessor::esborrarEstudis($request, $response, $args, $this);
    });

    $this->get('/{id}', function(Request $request, Response $response, $args) {
        $this->dbEloquent;
        return $response->withJSON(Professor::find($args['id']));
    });

    $this->get('/estudisProfessor/{id}', function(Request $request, Response $response, $args) {
        $this->dbEloquent;
        $usuari = Usuari::find($_SESSION["idUsuari"]);
        if ($usuari != null) {
            $prof = $usuari->getEntitat();
            $estudis = $prof->estudis;
            return $response->withJSON(estudis);
        } else {
            return $response->withJSON('Errada: ' . $_SESSION);
        }
    });
})->add(function ($request, $response, $next) {
    if (in_array(10, $_SESSION['rols']) || in_array(40, $_SESSION['rols'])) {
        return $response = $next($request, $response);
    } else {
        return $this->view->render($response, '/auxiliars/noAutoritzat.html.twig')->withStatus(403);
    }
});
//  //////////////////////////////////////////////////////////
// //////////////////                       /////////////////
//||||||||||||||||||       Administrador   |||||||||||||||||
// \\\\\\\\\\\\\\\\\\                       \\\\\\\\\\\\\\\\\
//  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

$app->group('/administrador', function() {
    $this->get('/usuarisPendents', function ($request, $response, $args) {
        $this->dbEloquent;
        $usuari = Usuari::find($_SESSION["idUsuari"]);
        if ($usuari != null) {
            $prof = $usuari->getEntitat();
            $companys = null;
            if ($usuari->teRol(40)) {
                $companys = Professor::where('validat', 0)->orderBy('email', 'ASC')->get();
            }
            return $this->view->render($response, 'professor/usuarisPendents.html.twig', ['professor' => $prof, 'companys' => $companys]);
        } else {
            return $response->withJSON('Errada: ' . $_SESSION);
        }
    });

    $this->put('/usuaris/{idProfessor}', function ($request, $response, $args) {
        return DaoProfessor::activar($request, $response, $args, $this);
    });

    $this->get('/usuaris', function ($request, $response, $args) {
        $this->dbEloquent;
        $usuari = Usuari::find($_SESSION["idUsuari"]);
        if ($usuari != null) {
            $prof = $usuari->getEntitat();
            $companys = Professor::orderBy('email', 'ASC')->get();
            return $this->view->render($response, 'professor/usuaris.html.twig', ['professor' => $prof, 'companys' => $companys]);
        } else {
            return $response->withJSON('Errada: ' . $_SESSION);
        }
    });

    $this->get('/administrador', function ($request, $response, $args) {
        $this->dbEloquent;
        $usuari = Usuari::find($_SESSION["idUsuari"]);
        if ($usuari != null) {
            $prof = $usuari->getEntitat();
            $companys = Professor::orderBy('email', 'ASC')->get();
            return $this->view->render($response, 'professor/administrador.html.twig', ['professor' => $prof, 'companys' => $companys]);
        } else {
            return $response->withJSON('Errada: ' . $_SESSION);
        }
    });


    $this->get('/rols/{idProfessor}', function(Request $request, Response $response, $args) {
        return DaoProfessor::rols($request, $response, $args, $this);
    });

    $this->put('/rols/{idProfessor}', function(Request $request, Response $response, $args) {
        return DaoProfessor::afegirRol($request, $response, $args, $this);
    });

    $this->delete('/rols/{idProfessor}', function(Request $request, Response $response, $args) {
        return DaoProfessor::eliminarRol($request, $response, $args, $this);
    });

    $this->get('/empreses', function ($request, $response, $args) {
        $this->dbEloquent;
        $usuari = Usuari::find($_SESSION['idUsuari']);
        if ($usuari != null) {
            $prof = $usuari->getEntitat();
            $empreses = Empresa::orderBy('nom', 'ASC')->get();
            return $this->view->render($response, 'professor/empreses.html.twig', ['professor' => $prof, 'empreses' => $empreses]);
        } else {
            return $response->withJSON('Errada: ' . $_SESSION);
        }
    });

    $this->get('/empresesPendents', function ($request, $response, $args) {
        $this->dbEloquent;
        $usuari = Usuari::find($_SESSION['idUsuari']);
        if ($usuari != null) {
            $prof = $usuari->getEntitat();
            $empreses = null;
            $empreses = Empresa::where('validada', 0)->orderBy('dataAlta', 'ASC')->orderBy('nom', 'ASC')->get();
            return $this->view->render($response, 'professor/empresesPendents.html.twig', ['professor' => $prof, 'usuari' => $usuari, 'empreses' => $empreses]);
        } else {
            return $response->withJSON('Errada: ' . $_SESSION);
        }
    });

    $this->put('/empreses/{idEmpresa}', function ($request, $response, $args) {
        return DaoEmpresa::activar($request, $response, $args, $this);
    });
})->add(function ($request, $response, $next) {
    if (in_array(40, $_SESSION['rols'])) {
        return $response = $next($request, $response);
    } else {
        return $this->view->render($response, '/auxiliars/noAutoritzat.html.twig')->withStatus(403);
    }
});





$app->get('/estudis', function(Request $request, Response $response) {
    $this->dbEloquent;
    return $this->view->render($response, 'estudis.html.twig', ['estudis' => Estudis::All()]);
});



//Usuaris
$app->get('/usuari/{id}', function(Request $request, Response $response, $args) {
//return recuperaInteri($request, $response, $this->db);
    $this->dbEloquent;
    return $response->withJSON(Usuari::find($args['id'])->getEntitat());
});

//Final

$app->run();

