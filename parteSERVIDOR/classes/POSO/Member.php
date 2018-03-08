<?php

class Member{
    public $id;
    public $login;
    public $password;
    
    function __construct($row){
        $this->id = $row['id'];
        $this->login = $row['login'];
        $this->password = $row['password'];
    }
    
}
