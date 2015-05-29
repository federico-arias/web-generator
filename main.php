<?php
//error_reporting(0);
require_once("html2web.php");
require_once("HZip.php");

$tmpHTMLfilename = $_FILES["src"]["tmp_name"];
//folder name, zip name and tmp html file name
$folder = basename($tmpHTMLfilename);
//$titulo = $_POST["titulo"];
$url = $_POST["url"];
$style = $_POST["style"];

/*
 * Step 1: transform the file
 */

html2web($tmpHTMLfilename, $folder, $url, $style);

/*
 * Step 2: copy vendor libraries (jquery, bootstrap, etc.) 
 */

recurse_copy("./vendor" . $style, $folder);

/*
 * Step 3: zip and download the file
 */

//HZip::zipDir($folder, $folder . ".zip");

?>
<!doctype html>
<html lang="es">
<head>
<meta charset="utf-8" />
</head>
<body>
Descarga tu archivo <a href="<?=$folder . '.zip'?>">aquí</a>.
</body>
</html>
