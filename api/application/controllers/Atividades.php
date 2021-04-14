<?php

defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . '/libraries/REST_Controller.php';

class Atividades extends REST_Controller {

    public function __construct() {

        parent::__construct();

        $this->load->library('paginacaonelos');

        $this->load->model('api/AtividadesModel');

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

          $pagina = $pagina-1;
          if($pagina<0){
              $pagina =0;
          }

      

        $lista = $this->AtividadesModel->filtrar($dados,10,$pagina*10);

        $total = $this->AtividadesModel->contarTotal($dados);

        $resultado= array('lista' =>$lista,
              'total' =>$total,
              'paginas' =>ceil($total/10));

      $this->response($resultado, REST_Controller::HTTP_OK);



    }

    public function incluir_post()
    {
        $dados = $this->post();
        $user = $this->aauth->get_user();

        $dados['acesso'] =  $user->username." ".$dados['acesso'];

        $dados['data'] =date('Y-m-d h:i:s');

        $dadosAtividades =$this->AtividadesModel->dados($dados);

        $buscar = $this->AtividadesModel->filtrar($dadosAtividades);

        if(empty($buscar)){

            $id = $this->AtividadesModel->incluir($dadosAtividades);

        }


        if(!empty($id)){


            $this->response($dadosAtividades, REST_Controller::HTTP_OK);

        }else{

            $this->response(NULL, REST_Controller::HTTP_BAD_REQUEST);
        }

    }


    public function editar_post()
    {
        $dados = $this->post();

        $dadosAtividades =$this->AtividadesModel->dados($dados);

        $this->AtividadesModel->incluir($dadosAtividades);

        $this->response($dadosAtividades, REST_Controller::HTTP_OK);

    }


     public function excluir_post()
    {
        $dados = $this->post();

        $dadosAtividades =$this->AtividadesModel->dados($dados);

        $this->AtividadesModel->excluir($dadosAtividades['id']);

        $this->response($dadosAtividades, REST_Controller::HTTP_OK);

    }


}
