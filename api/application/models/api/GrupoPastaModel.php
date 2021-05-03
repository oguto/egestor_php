<?php


class GrupoPastaModel extends CI_Model {
    function __construct() {

        parent::__construct();
    }

    function dados($dados = array()) {

        $array = array();

        $array['id'] =null;

        $array['id_grupo'] =null;

        $array['id_pasta'] =null;

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

      if(!empty($dados['id_pasta'])){

        $dados=array_filter($this->dados($dados));

        $this->db->insert("GRUPO_PASTA", $dados);

        return $this->db->insert_id();
      }
    }

    function editar($dados) {

        $dados = array_filter($this->dados($dados));

        $this->db->where('GRUPO_PASTA.id', $dados['id']);

        $this->db->where('GRUPO_PASTA.exclusao is null');

        $this->db->update("GRUPO_PASTA", $dados);
    }

    function listar($maximo = NULL, $inicio = NULL) {

        $this->db->from("GRUPO_PASTA");

        $this->db->where('GRUPO_PASTA.exclusao is null');

        $query = $this->db->get("", $maximo, $inicio);

        return $query->result_array();
    }

    function filtrar($filtro,$maximo = NULL, $inicio = NULL){

        $this->db->from("GRUPO_PASTA");

        $this->db->select("GRUPO.*,GRUPO_PASTA.id_pasta,GRUPO.id AS id");

        $this->db->group_by("GRUPO.id");

        $this->db->join('GRUPO', 'GRUPO_PASTA.id_grupo = GRUPO.id','Left');

        $this->db->where('GRUPO_PASTA.exclusao is null');

        $this->db->where($filtro);

        $query = $this->db->get("", $maximo, $inicio);

        return $query->result_array();

    }


    function excluir($id) {

        $dados = array();

        $this->db->where('GRUPO_PASTA.id', $id);

        $dados['exclusao']=date("Y-m-d");

        $this->db->update("GRUPO_PASTA",$dados);

    }
    function deletarPorPasta($id) {

        $this->db->where('GRUPO_PASTA.id_pasta', $id);

        $this->db->delete("GRUPO_PASTA");

    }




}
