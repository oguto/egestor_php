<?php


class PermissoesModel extends CI_Model {
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

        $this->db->insert("PERMISSOES", $dados);

        return $this->db->insert_id();
    }

    function editar($dados) {

        $dados = array_filter($this->dados($dados));

        $this->db->where('PERMISSOES.id', $dados['id']);

        $this->db->where('PERMISSOES.exclusao is null');

        $this->db->update("PERMISSOES", $dados);
    }

    function listar($maximo = NULL, $inicio = NULL) {

        $this->db->from("PERMISSOES");

        $this->db->where('PERMISSOES.exclusao is null');

        $query = $this->db->get("", $maximo, $inicio);

        return $query->result_array();
    }

    function filtrar($filtro,$maximo = NULL, $inicio = NULL){

        $this->db->from("PERMISSOES");

        $this->db->where('PERMISSOES.exclusao is null');

        $this->db->where($filtro);

        $query = $this->db->get("", $maximo, $inicio);

        return $query->result_array();

    }


    function excluir($id) {

        $dados = array();

        $this->db->where('PERMISSOES.id', $id);

        $dados['exclusao']=date("Y-m-d");

        $this->db->update("PERMISSOES",$dados);

    }




}
