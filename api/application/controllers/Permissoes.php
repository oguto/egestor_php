<?php

defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . '/libraries/REST_Controller.php';

class Permissoes extends REST_Controller {

    public function __construct() {

        parent::__construct();

        $this->load->library('paginacaonelos');

        $this->load->model('api/PermissoesModel');

        }

    public function listar_post()
    {
        $dados = $this->post();

        $resultado = $this->PermissoesModel->filtrar($dados);

      $this->response($resultado, REST_Controller::HTTP_OK);



    }

    public function incluir_post()
    {
        $dados = $this->post();

        $dadosPermissoes =$this->PermissoesModel->dados($dados);

        $buscar = $this->PermissoesModel->filtrar($dadosPermissoes);

        if(empty($buscar)){

            $id = $this->PermissoesModel->incluir($dadosPermissoes);
        }


        if(!empty($id)){


            $this->response($dadosPermissoes, REST_Controller::HTTP_OK);

        }else{

            $this->response(NULL, REST_Controller::HTTP_BAD_REQUEST);
        }

    }


    public function editar_post()
    {
        $dados = $this->post();

        $dadosPermissoes =$this->PermissoesModel->dados($dados);

        $this->PermissoesModel->incluir($dadosPermissoes);

        $this->response($dadosPermissoes, REST_Controller::HTTP_OK);

    }


     public function excluir_post()
    {
        $dados = $this->post();

        $dadosPermissoes =$this->PermissoesModel->dados($dados);

        $this->PermissoesModel->excluir($dadosPermissoes['id']);

        $this->response($dadosPermissoes, REST_Controller::HTTP_OK);

    }


}
