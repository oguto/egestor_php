<?php


class PastasModel extends CI_Model {
    function __construct() {

        parent::__construct();
    }

    function dados($dados = array()) {

        $array = array();

        $array['id'] =null;

        $array['nome'] =null;

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

        $this->db->insert("PASTAS", $dados);

        return $this->db->insert_id();
    }

    function editar($dados) {

        $dados = array_filter($this->dados($dados));

        $this->db->where('PASTAS.id', $dados['id']);

        $this->db->where('PASTAS.exclusao is null');

        $this->db->update("PASTAS", $dados);
    }

    function listar($maximo = NULL, $inicio = NULL) {

        $this->db->from("PASTAS");

        $this->db->where('PASTAS.exclusao is null');

        $query = $this->db->get("", $maximo, $inicio);

        return $query->result_array();
    }

    function filtrar($filtro,$maximo = NULL, $inicio = NULL){

        $this->db->from("PASTAS");

        $this->db->select("PASTAS.*, PASTAS.id AS id");

        $this->db->group_by("PASTAS.id");

        $this->db->where('PASTAS.exclusao is null');

        if(!empty($filtro['id_grupo'])){

        $this->db->join('GRUPO_PASTA', ' PASTAS.id =GRUPO_PASTA.id_pasta','Left');

        $this->db->where('GRUPO_PASTA.id_grupo',$filtro['id_grupo']);
        
        unset($filtro['id_grupo'])

      }


        $this->db->where($filtro);

        $query = $this->db->get("", $maximo, $inicio);

        return $query->result_array();

    }


    function excluir($id) {

        $dados = array();

        $this->db->where('PASTAS.id', $id);

        $dados['exclusao']=date("Y-m-d");

        $this->db->update("PASTAS",$dados);

    }




}
