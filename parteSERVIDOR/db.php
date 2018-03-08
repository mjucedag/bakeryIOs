<?php
$method = $_SERVER['REQUEST_METHOD'];
$q =  $_GET['q'];
$params = file_get_contents('php://input');
$headers = apache_request_headers();

$json = json_decode(file_get_contents('php://input'), true);

require('classes/AutoLoad.php');
require('classes/ApiREST.php');

require('classes/DataBase.php');
require('classes/POSO/Family.php');
require('classes/POSO/Member.php');
use \Firebase\JWT\JWT;
require('classes/vendor/autoload.php');


$KEY = 'bakery';

if(!isset($headers['authorization']))
    ApiREST::error(402);
    
$auth = explode( ' ', $headers['authorization']);

if(count($auth) != 2)
    ApiREST::error(402);



if($auth[0] == 'Basic'){
    $login = base64_decode($auth[1]);
    $loginSplit = explode(':', $login);
    if(count($loginSplit) !== 2)
        ApiREST::error();
    
    $db = new BakeryDatabase();
    $members = $db->getData('member');
    
    $loginExists = array_filter($members, function ($m) use ($loginSplit){
        return $m['login'] == $loginSplit[0] && $m['password'] == md5($loginSplit[1]) ;
    });
    $loginExists = array_values($loginExists);
    if(!$loginExists)
        ApiREST::error('402');
    
}else if($auth[0] == 'Bearer'){
    
    try{
        $decodedToken = JWT::decode($auth[1], APIRest::$KEY, array('HS256'));
    }catch(Exception $e){
        ApiREST::error('501');
    }
    
    $dateTime = new DateTime();
    if($dateTime->getTimestamp() > $decodedToken->time)
        ApiREST::error('502');
}else
    ApiREST::error();
    


$api = new APIRest($method, $params, $q, $loginSplit[0]);
if($loginExists){$api->addResponse('m',$loginExists[0]['id']);}
$api->request();

$api->send();
