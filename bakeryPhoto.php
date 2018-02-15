<?php
/*
 * Template Name: list of images
 */
 header("Cache-Control: no-store, no-cache, must-revalidate, max-age-0");
 header("Cache-Control: post-check-0, pre-check-0", false);
 header("Progma: no-cache");
 
 $images = array();
 
  //PAN     
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/bread/1.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/bread/2.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/bread/3.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/bread/4.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/bread/5.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/bread/6.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/bread/7.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/bread/8.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/bread/9.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/bread/10.jpg";
 
 //BOLLERIA
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/pastries/11.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/pastries/12.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/pastries/13.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/pastries/14.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/pastries/15.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/pastries/16.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/pastries/17.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/pastries/18.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/pastries/19.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/pastries/20.jpg";
 
 //CROISSANT
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/croissants/21.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/croissants/22.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/croissants/23.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/croissants/24.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/croissants/25.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/croissants/26.jpg";
 
 //NAVIDAD
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/christmas/27.JPG";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/christmas/28.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/christmas/29.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/christmas/30.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/christmas/31.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/christmas/32.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/christmas/33.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/christmas/34.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/christmas/35.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/christmas/36.jpg";
 
 //OTROS
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/others/37.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/others/38.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/others/39.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/others/40.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/others/41.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/others/42.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/others/43.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/others/44.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/others/45.jpg";
 $images[]= "https://bakery-server-franor21.c9users.io/bakeryPhotos/others/46.jpg";

 echo json_encode($images);
 ?>