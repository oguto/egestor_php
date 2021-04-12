<?php

defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . '/libraries/REST_Controller.php';

class GrupoDocumento extends REST_Controller {

    public function __construct() {

        parent::__construct();

        $this->load->library('paginacaonelos');

        $this->load->model('api/GrupoDocumentoModel');

        $this->load->model('api/GrupoModel');

        $this->load->model('api/DocumentosModel');

        }

    public function listar_post()
    {
        $dados = $this->post();

        $resultado = $this->GrupoDocumentoModel->filtrar($dados);

      $this->response($resultado, REST_Controller::HTTP_OK);



    }

    public function incluir_post()
    {
        $dados = $this->post();

        $dadosGrupoDocumento =$this->GrupoDocumentoModel->dados($dados);

        $buscar = $this->GrupoDocumentoModel->filtrar($dadosGrupoDocumento);

        if(empty($buscar)){

            $id = $this->GrupoDocumentoModel->incluir($dadosGrupoDocumento);
        }


        if(!empty($id)){


            $this->response($dadosGrupoDocumento, REST_Controller::HTTP_OK);

        }else{

            $this->response(NULL, REST_Controller::HTTP_BAD_REQUEST);
        }

    }


    public function editar_post()
    {
        $dados = $this->post();

        $dadosGrupoDocumento =$this->GrupoDocumentoModel->dados($dados);

        $this->GrupoDocumentoModel->incluir($dadosGrupoDocumento);

        $this->response($dadosGrupoDocumento, REST_Controller::HTTP_OK);

    }


     public function excluir_post()
    {
        $dados = $this->post();

        $dadosGrupoDocumento =$this->GrupoDocumentoModel->dados($dados);

        $this->GrupoDocumentoModel->excluir($dadosGrupoDocumento['id']);

        $this->response($dadosGrupoDocumento, REST_Controller::HTTP_OK);

    }


}
