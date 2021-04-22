<?php

defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . '/libraries/REST_Controller.php';

class Grupo extends REST_Controller {

    public function __construct() {

        parent::__construct();

        $this->load->library('paginacaonelos');

        $this->load->model('api/GrupoModel');

        $this->load->model('api/GrupoUsuarioModel');

        $this->load->model('api/UsuariosModel');

          $this->load->library("Aauth");

        }

    public function listar_post()
    {
        $dados = $this->post();

        if(!empty($dados['pagina'])){

          $pagina = $dados['pagina'];

          unset($dados['pagina']);

        }else{

          $pagina = null;

        }

        $login=$this->aauth->get_user();

        $user= $this->UsuariosModel->filtrar(array('id_aauth' =>$login->id))[0];

        if($user['id_permissao']==2){

            $lista= $this-> GrupoUsuarioModel->filtrar(array('id_usuario' =>$user['id']));

        }else{

            $lista = $this->GrupoModel->filtrar($dados);

        }

        $total = $this->GrupoModel->contarTotal($dados);

        $resultado= array('lista' =>$lista,
              'total' =>$total,
              'paginas' =>ceil($total/10));



      $this->response($resultado, REST_Controller::HTTP_OK);



    }

    public function incluir_post()
    {
        $dados = $this->post();

        $dadosGrupo =$this->GrupoModel->dados($dados);

        $buscar = $this->GrupoModel->filtrar($dadosGrupo);

        if(empty($buscar)){

            $id = $this->GrupoModel->incluir($dadosGrupo);
        }


        if(!empty($id)){


            $this->response($dadosGrupo, REST_Controller::HTTP_OK);

        }else{

            $this->response(NULL, REST_Controller::HTTP_BAD_REQUEST);
        }

    }


    public function editar_post()
    {
        $dados = $this->post();

        $dadosGrupo =$this->GrupoModel->dados($dados);

        $this->GrupoModel->editar($dadosGrupo);

        $this->response($dadosGrupo, REST_Controller::HTTP_OK);

    }


     public function excluir_post()
    {
        $dados = $this->post();

        $dadosGrupo =$this->GrupoModel->dados($dados);

        $this->GrupoModel->excluir($dadosGrupo['id']);

        $this->response($dadosGrupo, REST_Controller::HTTP_OK);

    }


}
