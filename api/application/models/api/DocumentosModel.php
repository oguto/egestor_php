<?php


class DocumentosModel extends CI_Model {
    function __construct() {

        parent::__construct();
    }

    function dados($dados = array()) {

        $array = array();

        $array['id'] =null;

        $array['nome'] =null;

        $array['id_pasta'] =null;

        $array['data_inicial'] =null;

        $array['data_final'] =null;

        $array['palavras_chaves'] =null;

        $array['url'] =null;

        $array['thumbnail'] =null;

        $array['exclusao'] =null;

        foreach ($array as $key => $value) {

             if(isset($dados[$key])){

                 $array[$key]=$dados[$key];

             } else{

               if(is_null($array[$key])){

                   $array[$key] = null;

                }
              }

        }


        return $array;
    }



    function incluir($dados) {

        $dados=array_filter($this->dados($dados));

        $this->db->insert("DOCUMENTOS", $dados);

        return $this->db->insert_id();
    }

    function editar($dados) {

        $dados = array_filter($this->dados($dados));

        $this->db->where('DOCUMENTOS.id', $dados['id']);

        $this->db->where('DOCUMENTOS.exclusao is null');

        $this->db->update("DOCUMENTOS", $dados);
    }

    function listar($maximo = NULL, $inicio = NULL) {

        $this->db->from("DOCUMENTOS");

        $this->db->where('DOCUMENTOS.exclusao is null');

        $query = $this->db->get("", $maximo, $inicio);

        return $query->result_array();
    }

    function filtrar($filtro,$maximo = NULL, $inicio = NULL){

      $filtro= array_filter($filtro);

      $this->db->select("DOCUMENTOS.*,DOCUMENTOS.id AS id, DATE_FORMAT(data_final,'%d/%m/%Y ') AS data_br, DATE_FORMAT(data_inicial,'%d/%m/%Y ') AS data_inicio_br ");


        $this->db->group_by("DOCUMENTOS.id");

        $this->db->from("DOCUMENTOS");



        if(!empty($filtro['exclusao'])){

            $this->db->where('DOCUMENTOS.exclusao is not null');

            unset($filtro['exclusao']);

        }else{

          $this->db->where('DOCUMENTOS.exclusao is null');

        }


        if( empty($filtro['id_pasta']) &&
            empty($filtro['exclusao']) &&
            empty($filtro['id']) ){

            $this->db->where('DOCUMENTOS.id_pasta is null');

        }

        $this->db->join('GRUPO_DOCUMENTO', 'DOCUMENTOS.id = GRUPO_DOCUMENTO.id_documento','Left');


        if(!empty($filtro['grupos_user'])){

          $this->db->where_in('GRUPO_DOCUMENTO.id_grupo',$filtro['grupos_user']);

          unset($filtro['grupos_user']);

        }



          if(!empty($filtro['grupo'])){

            $this->db->where('GRUPO_DOCUMENTO.id_grupo',$filtro['grupo']);

            unset($filtro['grupo']);

          }
          if(!empty($filtro['id'])){

            $this->db->where('DOCUMENTOS.id',$filtro['id']);

            unset($filtro['id']);

          }

        if(!empty($filtro['status'])){

          if($filtro['status']=="ativo"){

            $this->db->where('DOCUMENTOS.data_final>=',date('Y-m-d'));

          }else{

            $this->db->where('DOCUMENTOS.data_final<',date('Y-m-d'));

          }

          unset($filtro['status']);

        }


        $this->db->where($filtro);


        $query = $this->db->get("", $maximo, $inicio);



        return $query->result_array();

    }


    function contarTotal($filtro){

      $filtro= array_filter($filtro);

      unset($filtro['pagina']);

      $this->db->select("DOCUMENTOS.*,DOCUMENTOS.id AS id");

        $this->db->group_by("DOCUMENTOS.id");

        $this->db->from("DOCUMENTOS");

        if(!empty($filtro['exclusao'])){

            $this->db->where('DOCUMENTOS.exclusao is not null');

            unset($filtro['exclusao']);

        }else{

          $this->db->where('DOCUMENTOS.exclusao is null');

        }



        $this->db->join('GRUPO_DOCUMENTO', 'DOCUMENTOS.id = GRUPO_DOCUMENTO.id_documento','Left');

        if(!empty($filtro['grupos_user'])){

          $this->db->where_in('GRUPO_DOCUMENTO.id_grupo',$filtro['grupos_user']);

          unset($filtro['grupos_user']);

        }
          if(!empty($filtro['grupo'])){

            $this->db->where('GRUPO_DOCUMENTO.id_grupo',$filtro['grupo']);

            unset($filtro['grupo']);

          }
          if(!empty($filtro['id'])){

            $this->db->where('DOCUMENTOS.id',$filtro['id']);

            unset($filtro['id']);

          }

        if(!empty($filtro['status'])){

          if($filtro['status']=="ativo"){

            $this->db->where('DOCUMENTOS.data_final>=',date('Y-m-d'));

          }else{

            $this->db->where('DOCUMENTOS.data_final<',date('Y-m-d'));

          }

          unset($filtro['status']);

        }

        $this->db->where($filtro);

        return $this->db->get()->num_rows();

    }


    function excluir($id) {

        $dados = array();

        $this->db->where('DOCUMENTOS.id', $id);

        $dados['exclusao']=date("Y-m-d");

        $this->db->update("DOCUMENTOS",$dados);

    }




}
