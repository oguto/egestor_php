<?php

defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . '/libraries/REST_Controller.php';

class Documentos extends REST_Controller {

    public function __construct() {

        parent::__construct();

        $this->load->library('paginacaonelos');

        $this->load->model('api/DocumentosModel');

        $this->load->model('api/PastasModel');

        $this->load->model('api/GrupoDocumentoModel');

        $this->load->model('api/GrupoUsuarioModel');

        $this->load->model('api/GrupoPastaModel');

        $this->load->model('api/UsuariosModel');

        }

    public function listar_post()
    {
        $dados = $this->post();

        if(!empty($dados['pagina'])){

          $pagina = $dados['pagina'];

          unset($dados['pagina']);

        }else{

          $pagina = 0;

        }

        $user =$this->UsuariosModel->filtrar(array("id_aauth"=>$this->aauth->get_user()->id));

        $dados['grupos_user'] =$this->GrupoUsuarioModel->gruposId($user[0]['id']);

        $lista = $this->DocumentosModel->filtrar($dados,10,$pagina);

        $total = $this->DocumentosModel->contarTotal($dados);

        $resultado= array('lista' =>$lista,
              'total' =>$total,
              'paginas' =>ceil($total/10));

      $this->response($resultado, REST_Controller::HTTP_OK);



    }

    public function incluir_post()
    {
        $dados = $this->post();

        $dadosDocumentos =$this->DocumentosModel->dados($dados);

        $buscar = $this->DocumentosModel->filtrar($dadosDocumentos);

        if(empty($buscar)){

          if(!empty($dados['nova_pasta'])){

            $buscarPasta = $this->PastasModel->filtrar(array("nome"=>$dados['nova_pasta']));

            if(empty($buscarPasta)){

              $id_pasta= $this->PastasModel->incluir(array("nome"=>$dados['nova_pasta']));

              $dadosDocumentos['id_pasta']=$id_pasta;

            }else{

              $dadosDocumentos['id_pasta']=$buscarPasta[0]['id'];
            }


          }

            $id = $this->DocumentosModel->incluir($dadosDocumentos);

            foreach ($dados['grupos'] as $grupo) {
              $this->GrupoDocumentoModel->incluir(
                array("id_grupo"=>$grupo,"id_documento"=>$id)
              );
              $this->GrupoPastaModel->incluir(
                array("id_grupo"=>$grupo,"id_pasta"=>$dadosDocumentos['id_pasta'])
              );
            }
        }

        if(!empty($id)){

            $this->response($id, REST_Controller::HTTP_OK);

        }else{

            $this->response(NULL, REST_Controller::HTTP_BAD_REQUEST);
        }

    }

    public function upload_post()
    {
        $dados = $this->post();
         $config['upload_path'] = '../upload/';
         $config['allowed_types'] = 'jpg|pdf|jpeg';
         $config['max_size'] = 200000;
         $config['max_width'] = 15000;
         $config['max_height'] = 15000;
         $config['encrypt_name'] = TRUE;
         $new_name = time().$_FILES["documentos"]['name'];
         $config['file_name'] = $new_name;

         $this->load->library('upload', $config);

         if (!$this->upload->do_upload('documentos')) {

            $error = array('error' => $this->upload->display_errors());

            $this->response($error, REST_Controller::HTTP_OK);

         } else {
             $data = array('arquivo' => $this->upload->data());


             $this->response($data, REST_Controller::HTTP_OK);
         }


    }


    public function editar_post()
    {
        $dados = $this->post();

        $dadosDocumentos =$this->DocumentosModel->dados($dados);

        if(!empty($dados['nova_pasta'])){

          $buscarPasta = $this->PastasModel->filtrar(array("nome"=>$dados['nova_pasta']));

          if(empty($buscarPasta)){

            $id_pasta=  $this->PastasModel->incluir(array("nome"=>$dados['nova_pasta']));

            $dadosDocumentos['id_pasta']=$id_pasta;

          }else{

            $dadosDocumentos['id_pasta']=$buscarPasta[0]['id'];
          }
        }

        $this->GrupoDocumentoModel->deletarPorDoc($dados['id']);

        $this->GrupoPastaModel->deletarPorPasta($dadosDocumentos['id_pasta']);

        foreach ($dados['grupos'] as $grupo) {
          $this->GrupoDocumentoModel->incluir(
            array("id_grupo"=>$grupo,"id_documento"=>$dados['id'])
          );
          $this->GrupoPastaModel->incluir(
            array("id_grupo"=>$grupo,"id_pasta"=>$dadosDocumentos['id_pasta'])
          );
        }

        $this->DocumentosModel->editar($dadosDocumentos);

        $this->response($dados, REST_Controller::HTTP_OK);

    }


     public function excluir_post()
    {
        $dados = $this->post();

        $dadosDocumentos =$this->DocumentosModel->dados($dados);

        $this->DocumentosModel->excluir($dadosDocumentos['id']);

        $this->response($dadosDocumentos, REST_Controller::HTTP_OK);

    }


}
