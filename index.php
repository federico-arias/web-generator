<!DOCTYPE html>
<html lang="es">
<meta charset="utf-8" />
<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/pure-min.css">
<body>

<div class="pure-g">
    <div class="pure-u-1-3"><p></p></div>
    <div class="pure-u-1-3">
        <form action="main.php" method="post" enctype="multipart/form-data" class="pure-form pure-form-stacked">
           <legend>Selecciona un archivo para subir: </legend>
            <input type="file" name="src" id="file-id">

            <label for="url-id">URL</label>
            <input type="text" name="url" id="url-id">

            <!--
            Nombre de archivo: <input type="text" name="nombreArchivo"><br />
            Estilo: <input type="radio" name="estilo" value="bootstrap">Bootstrap<br />
            <input type="radio" name="estilo" value="eXeLearning">eXeLearning<br />
            -->
            <label for="templating-id">Plantilla a usar</label>
            <select id="templating-id" name="style">
                <option value="b">Responsiva</option>
                <option value="x">eXeLearning</option>
            </select>
            <button type="submit" id="boton-id" class="pure-button pure-button-primary" name="submit">Crear módulo</button>

        </form>
    </div>
    <div class="pure-u-1-3"><p></p></div>
</div>

</body>
</html>
