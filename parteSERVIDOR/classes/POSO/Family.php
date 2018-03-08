<?php

class Family{
    public $id;
    public $family;
    
    function __construct($row){
        $this->id = $row['id'];
        $this->family = $row['family'];
    }
    
}