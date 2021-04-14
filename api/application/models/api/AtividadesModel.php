<?php


class AtividadesModel extends CI_Model {
    function __construct() {

        parent::__construct();
    }

    function dados($dados = array()) {

        $array = array();

        $array['id'] =null;

        $array['acesso'] =null;

        $array['data'] =null;

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

        $this->db->insert("ATIVIDADES", $dados);

        return $this->db->insert_id();
    }

    function editar($dados) {

        $dados = array_filter($this->dados($dados));

        $this->db->where('ATIVIDADES.id', $dados['id']);

        $this->db->where('ATIVIDADES.exclusao is null');

        $this->db->update("ATIVIDADES", $dados);
    }

    function listar($maximo = NULL, $inicio = NULL) {

        $this->db->from("ATIVIDADES");

        $this->db->order_by('ATIVIDADES.id', 'asc');

        $this->db->where('ATIVIDADES.exclusao is null');

        $query = $this->db->get("", $maximo, $inicio);

        return $query->result_array();
    }

    function filtrar($filtro,$maximo = NULL, $inicio = NULL){

        $this->db->from("ATIVIDADES");
        $this->db->select("ATIVIDADES.*,DATE_FORMAT(data,'%d/%m/%Y %H:%i') AS data ");

        $this->db->order_by('ATIVIDADES.id', 'desc');

        $this->db->where('ATIVIDADES.exclusao is null');

        if(!empty($filtro['de'])){

            $this->db->where('ATIVIDADES.data>=',$filtro['de']);

            unset($filtro['de']);


        }

         if(!empty($filtro['ate'])){

            $this->db->where('ATIVIDADES.data<=',$filtro['ate']);

            unset($filtro['ate']);
        }
        if(!empty($filtro)){

          $filtro=array_filter($this->dados($filtro));

            $this->db->like($filtro);

        }



        $query = $this->db->get("", $maximo, $inicio);

        return $query->result_array();

    }

    function contarTotal($filtro){

        $this->db->from("ATIVIDADES");
        $this->db->select("ATIVIDADES.*,DATE_FORMAT(data,'%d/%m/%Y %H:%i') AS data ");

        $this->db->order_by('ATIVIDADES.id', 'desc');

        $this->db->where('ATIVIDADES.exclusao is null');

        if(!empty($filtro['de'])){

            $this->db->where('ATIVIDADES.data>=',$filtro['de']);

            unset($filtro['de']);


        }

         if(!empty($filtro['ate'])){

            $this->db->where('ATIVIDADES.data<=',$filtro['ate']);

            unset($filtro['ate']);
        }
        if(!empty($filtro)){

          $filtro=array_filter($this->dados($filtro));

            $this->db->like($filtro);

        }



       return $this->db->get()->num_rows();

    }

    function excluir($id) {

        $dados = array();

        $this->db->where('ATIVIDADES.id', $id);

        $dados['exclusao']=date("Y-m-d");

        $this->db->update("ATIVIDADES",$dados);

    }




}
