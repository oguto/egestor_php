<?php

defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . '/libraries/REST_Controller.php';

class Login extends REST_Controller {

    public function __construct() {

        parent::__construct();

        $this->load->library('paginacaonelos');

        $this->load->model('api/UsuariosModel');

        $this->load->model('api/PermissoesModel');

        $this->load->model('api/GrupoUsuarioModel');

          $this->load->library("Aauth");

    }

    public function ver_post()
    {
        $dados = $this->post();

        $resultado = $this->aauth->get_user();

        if($resultado){


            $this->response(array($resultado), REST_Controller::HTTP_OK);

        }else{

          $this->response(array(), REST_Controller::HTTP_OK);

        }




    }

    public function logar_post()
    {
        $dados = $this->post();

        $resultado = $this->aauth->get_user();

        if($this->aauth->login($dados['email'], $dados['senha'])){

            $this->response(array($this->aauth->get_user()), REST_Controller::HTTP_OK);

        }else{

          $this->response(array(), REST_Controller::HTTP_OK);

        }




    }
    public function editar_post()
    {
      $dados = $this->post();

              $login = $this->aauth->update_user($dados['id_aauth'], false, $dados['senha']);

          if($login){

            $this->response(array($login), REST_Controller::HTTP_OK);

          }else {
            $this->response($login, REST_Controller::HTTP_OK);
          }

    }

    public function sair_post()
    {

            $this->response($this->aauth->logout(), REST_Controller::HTTP_OK);

    }






}
