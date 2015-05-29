<?php

ini_set('max_execution_time', 300); 
require_once("helpers.php");

function html2web ($htmlfile, $folder, $url, $sheet)
{
    mkdir($folder);

    //loads intermediary xslt
    $xsl = new DOMDocument('1.0', 'utf-8');
    $xsl->load("xml/curso.xsl");
    //loads the file to convert
    $html = new DOMDocument('1.0', 'utf-8');
    @$html->loadHTMLFile($htmlfile);
    $html->saveHTMLFile('logs/log1rawhtml.html');
    //processor that gives structure
    $proc = new XSLTProcessor;
    $proc->importStylesheet($xsl);

    $xml = $proc->transformToDoc($html);
    $xml->save('logs/3-structure.xml');

    if ($sheet == 'b') 
        $stylesheet = 'xml/bootstrap.xsl';
    if ($sheet == 'x') 
        $stylesheet = 'xml/exelearning.xsl';

    $style = new DOMDocument('1.0', 'utf-8');
    $style->load($stylesheet);

    $proc->registerPHPFunctions(array('normNext', 'normPrev', 'normMenu'));
    $proc->importStylesheet($style);
    $proc->setParameter('', 'url', $url);
    $xpath = new DOMXPath($xml);
    $query = "/temas/tema";

    //for each <tema>, write a file to disk
    foreach ($xpath->query($query) as $key => $node)
    {
        //echo $node->C14N() . PHP_EOL . PHP_EOL ;
        echo $key . trim($node->firstChild->nodeValue);  
        $filename = normalizeString(trim($node->firstChild->nodeValue), 'files');
        $xmlString = $node->ownerDocument->saveXML( $node );
        $xmlString = addDivs($xmlString);
        $xmlNode = new DOMDocument('1.0', 'utf-8');
        $xmlNode->loadXML($xmlString);
        $file =  $proc->transformToXML($xmlNode);
        //flush_table('menu');
        echo $filename . "<br />";
        file_put_contents(__DIR__ . DIRECTORY_SEPARATOR . $folder . DIRECTORY_SEPARATOR .  $filename, $file);
    }
    /*flush_table('prev');
    flush_table('next');
    flush_table('files');
     */
}

?>
