<?php

defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . '/libraries/REST_Controller.php';

class GrupoUsuario extends REST_Controller {

    public function __construct() {

        parent::__construct();

        $this->load->library('paginacaonelos');

        $this->load->model('api/GrupoUsuarioModel');

        $this->load->model('api/GrupoModel');

        $this->load->model('api/UsuariosModel');

        }

    public function listar_post()
    {
        $dados = $this->post();

        $resultado = $this->GrupoUsuarioModel->filtrar($dados);

      $this->response($resultado, REST_Controller::HTTP_OK);



    }

    public function incluir_post()
    {
        $dados = $this->post();

        $dadosGrupoUsuario =$this->GrupoUsuarioModel->dados($dados);

        $buscar = $this->GrupoUsuarioModel->filtrar($dadosGrupoUsuario);

        if(empty($buscar)){

            $id = $this->GrupoUsuarioModel->incluir($dadosGrupoUsuario);
        }


        if(!empty($id)){


            $this->response($dadosGrupoUsuario, REST_Controller::HTTP_OK);

        }else{

            $this->response(NULL, REST_Controller::HTTP_BAD_REQUEST);
        }

    }


    public function editar_post()
    {
        $dados = $this->post();

        $dadosGrupoUsuario =$this->GrupoUsuarioModel->dados($dados);

        $this->GrupoUsuarioModel->incluir($dadosGrupoUsuario);

        $this->response($dadosGrupoUsuario, REST_Controller::HTTP_OK);

    }


     public function excluir_post()
    {
        $dados = $this->post();

        $dadosGrupoUsuario =$this->GrupoUsuarioModel->dados($dados);

        $this->GrupoUsuarioModel->excluir($dadosGrupoUsuario['id']);

        $this->response($dadosGrupoUsuario, REST_Controller::HTTP_OK);

    }


}
