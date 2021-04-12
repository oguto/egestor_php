<?php

defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . '/libraries/REST_Controller.php';

class Pastas extends REST_Controller {

    public function __construct() {

        parent::__construct();

        $this->load->library('paginacaonelos');

        $this->load->model('api/PastasModel');

        }

    public function listar_post()
    {
        $dados = $this->post();

        $resultado = $this->PastasModel->filtrar($dados);

      $this->response($resultado, REST_Controller::HTTP_OK);



    }

    public function incluir_post()
    {
        $dados = $this->post();

        $dadosPastas =$this->PastasModel->dados($dados);

        $buscar = $this->PastasModel->filtrar($dadosPastas);

        if(empty($buscar)){

            $id = $this->PastasModel->incluir($dadosPastas);
        }


        if(!empty($id)){


            $this->response($dadosPastas, REST_Controller::HTTP_OK);

        }else{

            $this->response(NULL, REST_Controller::HTTP_BAD_REQUEST);
        }

    }


    public function editar_post()
    {
        $dados = $this->post();

        $dadosPastas =$this->PastasModel->dados($dados);

        $this->PastasModel->incluir($dadosPastas);

        $this->response($dadosPastas, REST_Controller::HTTP_OK);

    }


     public function excluir_post()
    {
        $dados = $this->post();

        $dadosPastas =$this->PastasModel->dados($dados);

        $this->PastasModel->excluir($dadosPastas['id']);

        $this->response($dadosPastas, REST_Controller::HTTP_OK);

    }


}
