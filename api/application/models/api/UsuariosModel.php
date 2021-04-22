<?php


class UsuariosModel extends CI_Model {
    function __construct() {

        parent::__construct();
    }

    function dados($dados = array()) {

        $array = array();

        $array['id'] =null;

        $array['nome'] =null;

        $array['senha'] =null;

        $array['telefone'] =null;

        $array['email'] =null;

        $array['id_permissao'] =null;

        $array['id_aauth'] =null;

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

        $this->db->insert("USUARIOS", $dados);

        return $this->db->insert_id();
    }

    function editar($dados) {

        $dados = array_filter($dados);

        $this->db->where('USUARIOS.id', $dados['id']);

        $this->db->where('USUARIOS.exclusao is null');

        $this->db->update("USUARIOS", $dados);
    }
    function editarCodigo($dados) {

        $this->db->where('USUARIOS.id', $dados['id']);

        $this->db->where('USUARIOS.exclusao is null');

        $this->db->update("USUARIOS", $dados);
    }

    function listar($maximo = NULL, $inicio = NULL) {

        $this->db->from("USUARIOS");

        $this->db->where('USUARIOS.exclusao is null');

        $query = $this->db->get("", $maximo, $inicio);

        return $query->result_array();
    }

    function filtrar($filtro,$maximo = NULL, $inicio = NULL){

        $filtro= array_filter($filtro);

        $this->db->from("USUARIOS");

        $this->db->where('USUARIOS.exclusao is null');

        $this->db->where($filtro);

        $query = $this->db->get("", $maximo, $inicio);

        return $query->result_array();

    }


    function contarTotal($filtro){

        $filtro= array_filter($filtro);

        $this->db->from("USUARIOS");

        $this->db->where('USUARIOS.exclusao is null');

        $this->db->where($filtro);

      return $this->db->get()->num_rows();

    }




    function excluir($id) {

        $dados = array();

        $this->db->where('USUARIOS.id', $id);

        $dados['exclusao']=date("Y-m-d");

        $this->db->update("USUARIOS",$dados);

    }




}
