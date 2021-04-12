<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Modern Business - Start Bootstrap Template</title>

  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="css/modern-business.css" rel="stylesheet">
  <link href="css/alertify.css" rel="stylesheet">

  <script src="js/vue.js"></script>
  <script src="js/axios.min.js"></script>
</head>

<body>
  <!-- Navigation -->
  <nav class="navbar fixed-top navbar-expand-lg fixed-top">
    <div class="container">
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="nav nav-tabs" id="nav-tab" role="tablist">

          <li class="nav-item " role="presentation">
            <a href="#nav-home" class="nav-link active" data-toggle="tab" role="tab" aria-controls="nav-home" aria-selected="true">LOGO</a>
          </li>

          <?php
            $path = "components/";
            $diretorio = dir($path);

              while($arquivo = $diretorio -> read()){
              if(strstr($arquivo, 'listar_')!=false){
                $html =explode("listar_", $arquivo);
                $modulo =explode(".html", $html[1]);
                ?>

                <li class="nav-item " role="presentation">
                  <a href="#nav-<?php echo $modulo[0]?>" class="nav-link " data-toggle="tab" role="tab" aria-controls="nav-<?php echo $modulo[0]?>" aria-selected="true"><?php echo $modulo[0]?></a>
                </li>

              <?php
              }
                }
                $diretorio -> close();
              ?>


        </ul>
      </div>
    </div>
  </nav>
  <!-- Page Content -->
  <div class="container corpo">
    <div class="conteudo">
      <div class="tab-content" id="nav-tabContent">

        <div class="tab-pane fade" id="nav-home" role="tabpanel">
          <div id="app">

          </div>
        </div>
        <?php
          $path = "components/";
          $diretorio = dir($path);

          while($arquivo = $diretorio -> read()){
            if(strstr($arquivo, 'listar_')!=false){
              $html =explode("listar_", $arquivo);
              $modulo =explode(".html", $html[1]);
              ?>
                <div class="tab-pane fade" id="nav-<?php echo $modulo[0]?>" role="tabpanel">
                  <div id="app<?php echo $modulo[0]?>">
                    <?php
                    require($path."listar_".$html[1]);
                    require($path."form_".$html[1]);
                    ?>
                  </div>
                </div>

            <?php
            }
              }
              $diretorio -> close();
            ?>

      </div>
    </div>


  </div>
  <!-- /.container -->

  <!-- Footer -->


  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
  <script src="js/alertify.min.js"></script>
  <script type="text/javascript">
  const config={dominio:'http://localhost/freelas/egestor/'}
  </script>

  <!--Modulo-->

  <?php
    $path = "components/";
    $diretorio = dir($path);

    while($arquivo = $diretorio -> read()){
      if(strstr($arquivo, 'listar_')!=false){
        $html =explode("listar_", $arquivo);
        $modulo =explode(".html", $html[1]);
        ?>
        <script src="src/<?php echo $modulo[0]?>.js"></script>
      <?php
      }
        }
        $diretorio -> close();
      ?>


</body>

</html>
