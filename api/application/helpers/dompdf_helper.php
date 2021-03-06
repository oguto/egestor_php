<?php if (!defined('BASEPATH')) exit('No direct script access allowed');
function gerarPdf($html, $filename='', $stream=TRUE) 
{
    require_once(APPPATH."third_party/dompdf/dompdf_config.inc.php");

    $dompdf = new DOMPDF();
    $dompdf->load_html($html);
    $dompdf->render();
    if ($stream) {
        $dompdf->stream($filename.".pdf");
    } else {
        return $dompdf->output();
    }
}
?>