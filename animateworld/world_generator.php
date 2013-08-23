#!/usr/bin/php5
<?php
$data = array();
$base_url = "http://worldgen-1.bin.sh/worldgen.cgi?";
$data["iter"]=5000;
$data["palette"]="Alternate";
$data["cmd"]="Create";
$data["height"]=100;
$data["pct_ice"]=10;
$data["seed"]=rand(1,pow(2,24));
$data["rotate"]=0;
$data["projection"]="Spherical";
$data["pct_water"]=10;
$data["motif"]="";

function build_url($base_url,$data){
  $temp = array();
  foreach($data as $key => $datapoint){
    $temp[] = "$key=$datapoint";
  }
  return $base_url.implode("&",$temp);
}
$time_est = array();
$time = time();
passthru("mkdir world_$time");
for($i=1;$i<=360;$i++){
  $start = microtime(1);
  $data["rotate"]=$i;
  $raw = file_get_contents(build_url($base_url,$data));
  file_put_contents("world_$time/$i.gif",$raw);
  $end = microtime(1);
  $time_est[] = $end-$start;
  echo "[$i/360] ".floor(array_sum($time_est)/count($time_est)*(360-$i))."s remain.\n";
}
