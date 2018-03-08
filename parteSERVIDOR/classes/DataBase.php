<?php

class BakeryDatabase{
    
    private $host = "localhost";
    private $db_name = "bakery";
    private $username = "ma";
    private $password = "";
    private $memberTable = 'member';
    public $con;
 
    public function __construct(){
 
        $this->con = null;
 
        try{
            $this->con = mysqli_connect($this->host ,$this->username, $this->password, $this->db_name);
        }catch(Exception $exception){
            echo "Connection error: " . $exception->getMessage();
        }
    }
    
    
    public function getData($table = 'product', $conditions = -1){
        $wheres = '';
        if($conditions != -1){
            $wheres = $this->buildQuery($conditions);
        }       
        
        try{
            $query = 'select * from ' . strtolower($table) . $wheres . ';';
            $resultset = mysqli_query($this->con, $query);
            $num = mysqli_num_rows($resultset);
        }catch(Exception $exception){
            ApiREST::error();
        }
        
        if($num < 1)
            ApiREST::error();
        
        $output = array();
        while($row = $resultset->fetch_array(MYSQL_ASSOC)){
            $output[] = $row ;
        }
        return $output;
    }
    
    function buildQuery($conditions){
        $wheres = ' where ';
        $conditions['q'] = null;
        $condition = array_map(function ($c){return !$c ? null : "'$c'";}, $conditions);
        $wheres .= http_build_query($condition, '', ' and ');
        return $wheres = urldecode($wheres);
    }
    
    public function getTicketsByCategory($idCategory = 1){
        try{
            $query = 'SELECT (select product from product where id=idproduct) as name,idproduct,SUM(quantity) as quantity,
                SUM(price) as total FROM ticketdetail WHERE idproduct in (select id from product where idfamily = ' . $idCategory . ') group by name;';
            $resultset = mysqli_query($this->con, $query);
            $num = mysqli_num_rows($resultset);
        }catch(Exception $exception){
            ApiREST::error();
        }
        
        if($num < 1)
            ApiREST::error();
        
        $output = array();
        while($row = $resultset->fetch_array(MYSQL_ASSOC)){
            $output[] = $row ;
        }
        return $output;
    }
    
    
    public function postTicket($data){
        $object =  json_decode($data);
        $id;
        try{
            $query = "insert into ticket values(null, \"$object->date\", $object->member, null);";
            $resultset = mysqli_query($this->con, $query);
            $id =  mysqli_insert_id ( $this->con );
        }catch(Exception $exception){
            ApiREST::error();
        }
        
        $tickets = $object->details;
        foreach($tickets as $ticket){
            try{
                $query = "insert into ticketdetail values(null, $id, $ticket->product, $ticket->quantity, $ticket->price);";
                $resultset = mysqli_query($this->con, $query);
            }catch(Exception $exception){
                ApiREST::error();
            }
        }
        
    }
}