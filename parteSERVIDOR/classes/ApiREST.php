<?php
use \Firebase\JWT\JWT;
require('classes/vendor/autoload.php');
class ApiREST{

    private $method;
    private $param;
    private $get;
    private $dateTime;
    private $db;
    
    public $response;
    public static $KEY = 'bakery';
    
    function __construct($m, $p, $g, $u){
        $this->method = $m;
        $this->param = $p;
        $this->get = $g;
        $this->response = array();
        $this->dateTime = new DateTime();
        $this->genToken($u);
        $this->db = new BakeryDatabase();
        
    }
    
    function request(){
        switch($this->method){
            case 'GET':
                    if($this->get == 'login') return;
                    if($this->get == 'ticketcategory'){
                        $tickets = $this->db->getTicketsByCategory($_GET['id']);
                        $tickets = $this->utf8_converter($tickets);
                        $this->addResponse('r', $tickets);
                        return;
                    }
                    $resp = $this->db->getData($this->get, count($_GET) >1 ? $_GET : -1);
                    $resp = $this->utf8_converter($resp);
                    $this->addResponse('r', $resp);
                break;
            case 'POST':
                if($this->get == 'ticket')
                    $this->db->postTicket($this->param);
                break;
        }
    }
    
    function addResponse($key, $msg){
        $this->response[$key] = $msg;
    }

    function genToken($user = 'user'){
        $token = array(
                'time' => $this->dateTime->getTimestamp() + 600,
                'user' => $user,
            );
        $jwt = JWT::encode($token, APIRest::$KEY);
        $this->addResponse('t', $jwt);
    }
    
    function send(){
        echo json_encode($this->response);
    }
    
    public static function error($e = 404){  
        echo json_encode(array('e'=> $e));
        exit;
    }
    
    public function utf8_converter($array){
        array_walk_recursive($array, function(&$item, $key){
            if(!mb_detect_encoding($item, 'utf-8', true)){
                $item = utf8_encode($item);
            }
        });
        return $array;
    }
}
