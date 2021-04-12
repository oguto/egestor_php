<?php

class Usuario extends CI_Model {


   public function __construct() {

            $this->load->model('admin/Controleacessomodel');


    }

      function dados($dados=array()) {

        $array = array();

        $array['id'] = null;

        $array['tipo'] = null;

        $array['nome'] = null;

        $array['email'] = null;

        $array['senha'] = null;

        $array['admin'] = $this->usuario->verAdmin();

        $array['exclusao'] = null;

        foreach ($array as $key => $value) {

             if(isset($dados[$key])){

                 $array[$key]=$dados[$key];

             } else{

                 if(is_null($array[$key])){

                   $array[$key]=null;

                }

             }

         }


        return $array;
    }



    function logar($dados) {

    if(!empty( $dados['email'])&&!empty($dados['senha'])){

        $this->db->from("USUARIO");

        $this->db->select('USUARIO.*,PESSOA_USUARIO.id_pessoa');

        $this->db->select('USUARIO.id as id');

        $this->db->join("ADMIN","ADMIN.id=USUARIO.admin","left");

        $this->db->join("PESSOA_USUARIO","PESSOA_USUARIO.id_usuario=USUARIO.id","left");

        $this->db->where('USUARIO.email', $dados['email']);

        $this->db->where('ADMIN.chave', $dados['chave']);

        $this->db->where('USUARIO.senha',senha($dados['senha']));

        //$this->db->where('USUARIO.exclusao is null');

        $query = $this->db->get();

        return $query->row_array();
    }

    }


    function editar($dados) {

         $this->db->where('id', $this->verId());

         $this->db->where('USUARIO.exclusao is null');

         $this->db->update("USUARIO", $dados);
    }

    function editarSenha($dados) {

         $this->db->where('id', $dados['id']);

         $this->db->where('USUARIO.exclusao is null');

         $this->db->update("USUARIO", $dados);
    }




    function ver() {


        $this->db->from("USUARIO");

        $this->db->select('*');

        $this->db->select('USUARIO.id as id');

        $this->db->join("ADMIN","ADMIN.id=USUARIO.admin","left");

        $this->db->where('USUARIO.id', $this->verId());

        $this->db->where('USUARIO.exclusao is null');

        $query = $this->db->get();

        return $query->row_array();


    }

    function listar($maximo = NULL, $inicio = NULL) {

        $this->db->from("USUARIO");

        $this->db->where('USUARIO.exclusao is null');

        $this->banco->usuario("USUARIO");

        $query = $this->db->get("", $maximo, $inicio);

        return $query->result_array();
    }


     function recuperar($dados) {


        $this->db->from("USUARIO");

        $this->db->where('USUARIO.chave',$dados['chave']);

        $this->db->where('USUARIO.email',$dados['email']);

        $this->db->where('USUARIO.exclusao is null');

        $query = $this->db->get();

        return $query->row_array();


    }





  public function verId(){


     $user = $this->session->userdata('login');

  	return $user['id'];

  }


  public function verLogin(){


     $user = $this->session->userdata('login');

    return $user;

  }

  public function verAdmin(){

     $user = $this->session->userdata('login');

    return $user['admin'];

  }

  public function verUsuario(){

     $user = $this->session->userdata('usuario');

    return $user;

  }

   public function verTipoAssinatura(){

     $user = $this->session->userdata('login');

    return $user['tipo_assinatura'];

  }

  public function verUserAdmin(){

  	return  $this->session->userdata('id');

  }

  public function verGrupo(){


  }

  public function redirecionar(){

  	if(empty($this->verId())){

      $this->load->view('layout/login/redirect');


  	}

  }



}
