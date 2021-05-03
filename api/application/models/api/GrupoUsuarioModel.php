<?php


class GrupoUsuarioModel extends CI_Model {
    function __construct() {

        parent::__construct();
    }

    function dados($dados = array()) {

        $array = array();

        $array['id'] =null;

        $array['id_grupo'] =null;

        $array['id_usuario'] =null;

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

        $this->db->insert("GRUPO_USUARIO", $dados);

        return $this->db->insert_id();
    }

    function editar($dados) {

        $dados = array_filter($this->dados($dados));

        $this->db->where('GRUPO_USUARIO.id', $dados['id']);

        $this->db->where('GRUPO_USUARIO.exclusao is null');

        $this->db->update("GRUPO_USUARIO", $dados);
    }

    function listar($maximo = NULL, $inicio = NULL) {

        $this->db->from("GRUPO_USUARIO");

        $this->db->where('GRUPO_USUARIO.exclusao is null');

        $query = $this->db->get("", $maximo, $inicio);

        return $query->result_array();
    }

    function filtrar($filtro,$maximo = NULL, $inicio = NULL){

        $this->db->from("GRUPO_USUARIO");

        $this->db->select("GRUPO.*,GRUPO_USUARIO.id_usuario,GRUPO.id AS id");

        $this->db->group_by("GRUPO.id");

        $this->db->join('GRUPO', 'GRUPO_USUARIO.id_grupo = GRUPO.id','Left');

        $this->db->where('GRUPO_USUARIO.exclusao is null');

        $this->db->where('GRUPO.exclusao is null');

        $this->db->where($filtro);

        $query = $this->db->get("", $maximo, $inicio);

        return $query->result_array();

    }


    function excluir($id) {

        $dados = array();

        $this->db->where('GRUPO_USUARIO.id', $id);

        $dados['exclusao']=date("Y-m-d");

        $this->db->update("GRUPO_USUARIO",$dados);

    }
    function deletarPorUser($id) {

        $this->db->where('GRUPO_USUARIO.id_usuario', $id);

        $this->db->delete("GRUPO_USUARIO");

    }




}
