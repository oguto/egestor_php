<?php

defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . '/libraries/REST_Controller.php';

class Usuarios extends REST_Controller {

    public function __construct() {

        parent::__construct();

        $this->load->library('paginacaonelos');

        $this->load->model('api/UsuariosModel');

        $this->load->model('api/PermissoesModel');

        $this->load->model('api/GrupoUsuarioModel');

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

        $lista = $this->UsuariosModel->filtrar($dados,10,$pagina);

        $total = $this->UsuariosModel->contarTotal($dados);

        $resultado= array('lista' =>$lista,
              'total' =>$total,
              'paginas' =>ceil($total/10));      

      $this->response($resultado, REST_Controller::HTTP_OK);

        $this->load->database();



    }

    public function enviarCodigo_post()
    {

      $dados = $this->post();

      $buscar = $this->UsuariosModel->filtrar(array('telefone' =>$dados['telefone']));

      if(!empty($buscar)){

        $codigo= $buscar[0]['id'].date('Hid');

        $this->UsuariosModel->editarCodigo(array('id' =>$buscar[0]['id'],'codigo'=>$codigo));

        enviarSMS("Código de verificação: ".$codigo,"55".$dados['telefone']);

        $this->response($buscar, REST_Controller::HTTP_OK);

      }else{

        $this->response(array(), REST_Controller::HTTP_OK);

      }



    }
    public function validarCodigo_post()
    {

      $dados = $this->post();

      $buscar = $this->UsuariosModel->filtrar(array('telefone' =>$dados['telefone'],'codigo' =>$dados['codigo']));

      if(!empty($buscar)){

        $this->UsuariosModel->editarCodigo(array('id' =>$buscar[0]['id'],'codigo'=>null));

        enviarSMS("Senha de acesso:".$buscar[0]['senha'],"55".$dados['telefone']);

        $this->response($buscar, REST_Controller::HTTP_OK);

      }else{

        $this->response(array(), REST_Controller::HTTP_OK);

      }



    }
    public function incluir_post()
    {
        $dados = $this->post();

        $dadosUsuarios =$this->UsuariosModel->dados($dados);

        $buscar = $this->UsuariosModel->filtrar($dadosUsuarios);

        if(empty($buscar)){


            $login = $this->aauth->create_user($dadosUsuarios['email'],
                                              $dadosUsuarios['senha'],
                                              $dadosUsuarios['nome']);

                                             print_r($login);
                                             print_r($dadosUsuarios);

            if($login){

              $dadosUsuarios['id_aauth']=$login;

              $id = $this->UsuariosModel->incluir($dadosUsuarios);

              foreach ($dados['grupos'] as $grupo) {
                $this->GrupoUsuarioModel->incluir(
                  array("id_grupo"=>$grupo,"id_usuario"=>$id)
                );
              }
            }
        }



        if(!empty($id)){


            $this->response($dadosUsuarios, REST_Controller::HTTP_OK);

        }else{

            $this->response($this->aauth->print_errors(), REST_Controller::HTTP_BAD_REQUEST);
        }

    }


    public function editar_post()
    {
        $dados = $this->post();

        $dadosUsuarios =$this->UsuariosModel->dados($dados);

        $this->UsuariosModel->editar($dadosUsuarios);

        $this->GrupoUsuarioModel->deletarPorUser($dados['id']);

      foreach ($dados['grupos'] as $grupo) {
        $this->GrupoUsuarioModel->incluir(
          array("id_grupo"=>$grupo,"id_usuario"=>$dados['id'])
        );
      }

        $this->response($dadosUsuarios, REST_Controller::HTTP_OK);

    }


     public function excluir_post()
    {
        $dados = $this->post();

        $dadosUsuarios =$this->UsuariosModel->dados($dados);

        $this->UsuariosModel->excluir($dadosUsuarios['id']);

        $this->response($dadosUsuarios, REST_Controller::HTTP_OK);

    }


}
