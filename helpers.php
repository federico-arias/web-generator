<?php

/* 
function normalizeString($str)
{ 
    $patterns = array('/[á]/u', '/[é]/u', '/[í]/u', '/[ó]/u', '/[úü]/u',  '/[\s¿<>\?:,\n\r]/');
    $replacements = array('a', 'e', 'i', 'o', 'u', '-');
    $str = strtolower($str);
    //$str = preg_replace('/\s\s/', ' ', $str, -1);
    $str = preg_replace($patterns, $replacements, $str, -1);
    return $str;
}
*/

function normNext($text) {return normalizeString($text);}
function normPrev($text) {return normalizeString($text);}
function normMenu($text) {return normalizeString($text);}

function addDivs($text) {
    $text = preg_replace("/(<[a-z]{1,5}) .*?(?=>)/", "$1", $text);
    $text = preg_replace("#<p.{0,12}\{{2}end\w+\}{2}.{0,14}p>#Us", "</div>", $text);
    $text = preg_replace("#<p.{0,12}\{{2}([a-z]*)\}{2}.{0,12}p>#Us", "<div class='$1'>", $text);
    $text = preg_replace("#\{{2}end[a-z]+?\}{2}#", "</span>", $text);
    $text = preg_replace("#\{{2}([a-z]+?)\}{2}#", "<span class='$1'>", $text);
    return $text;
}

//function normalizeString($text, $table) {
function normalizeString($text) {
  // replace non letter or digits by -
  $text = preg_replace('~[^\\pL\d]+~u', '-', $text);

  // trim
  $text = trim($text, '-');

  // replace non letter or digits by -
  $text = preg_replace('~[^\\pL\d]+~u', '-', $text);

  // trim
  $text = trim($text, '-');

  // transliterate
  $text = iconv('utf-8', 'us-ascii//TRANSLIT', $text);

  // lowercase
  $text = strtolower($text);

  // remove unwanted characters
  $text = preg_replace('~[^-\w]+~', '', $text);

  if (empty($text))
  {
    return 'n-a';
  }

  /*
   * // dba_open('logs/' . $db , "c", "gdbm");
    $dbh = new PDO('sqlite:C:\xampp\htdocs\html2web\logs\filenames.db', '', '', array(
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    ));
  $text = get_unique_filename($text, $table, $dbh);
  register_filename($text, $table, $dbh);
   */

  return $text . ".html";
}

function recurse_copy($src,$dst) { 
    $dir = opendir($src); 
    @mkdir($dst); 
    while(false !== ( $file = readdir($dir)) ) { 
        if (( $file != '.' ) && ( $file != '..' )) { 
            if ( is_dir($src . '/' . $file) ) { 
                recurse_copy($src . '/' . $file,$dst . '/' . $file); 
            } 
            else { 
                copy($src . '/' . $file,$dst . '/' . $file); 
            } 
        } 
    } 
    closedir($dir); 
} 

function file_get_contents_utf8($fn) {
     $content = file_get_contents($fn);
      return mb_convert_encoding($content, 'UTF-8',
          mb_detect_encoding($content, 'UTF-8, ISO-8859-1', true));
}

function get_unique_filename($filename, $table, $dbh)
{
/*
    $filenamesdb = dba_open('logs/' . $db , "r", "gdbm");
    if (dba_exists($filename, $filenamesdb)) {
        dba_close($filenamesdb);
        return ($filename . '-2');
    }
    return $filename;
*/
    global $index;
    $sql = 'SELECT filename FROM ' . $table . ' WHERE filename = :filename';
    $stmt = $dbh->prepare($sql);
    $stmt->bindParam(':filename', $filename);
    $stmt->execute();
    $n = $stmt->fetchAll();
    if (count($n) == 1) {
        return get_unique_filename($filename . '-2', $table, $dbh);
        $index++;
    }
    return $filename;
}

function register_filename($filename, $table, $dbh) 
{
    /*
    $filenamesdb = dba_open('logs/' . $db, "w", "gdbm");
    dba_insert($filename, $db, $filenamesdb); 
    dba_close($filenamesdb);
    $statement = $dbh->prepare('INSERT INTO :tabla (filename) VALUES(:fname)', array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));
    $statement->execute(array(':tabla' => $table, ':fname' => $filename));
     */
    $sql = 'INSERT INTO ' . $table . '(filename) VALUES (:fname)';
    $st = $dbh->prepare($sql);
    $st->bindParam(':fname', $filename);
    $st->execute();
}

function flush_table($table) 
{
    $dbh = new PDO('sqlite:C:\xampp\htdocs\html2web\logs\filenames.db', '', '', array(
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    ));
    $sql = 'DELETE FROM ' . $table;
    $dbh->exec($sql);
}

?>
