
const  moduloUsuarios = {
    el:'#appUsuarios',
    data:{
    id: null,
    nome:null,
    senha:null,
    telefone:null,
    email:null,
    id_permissao:null,
    exclusao:null,
    lista:[],
    grupos:[],
    dadosUsuarios:null,
    conteudo: null,
    formulario:false,
    visualizar:false,
    total: 0,
    totalPaginas:0,
    paginaAtual:1,
    listarGrupos:[],
    listaSelGruposUser:[],
    dadosLogin:null,
    permissao:null
  },
  methods:{
    validarForm(){

      var enviar = false;

      var campos =[{campo:'nome',valor:this.nome},
                   {campo:'senha',valor:this.senha},
                   {campo:'telefone',valor:this.telefone},
                   {campo:'email',valor:this.email},
                   {campo:'id_permissao',valor:this.id_permissao}
                 ];

      campos.forEach((item) => {

        if(item.valor==null){
            enviar =false;

            $("#appUsuarios form [name='"+item.campo+"']").parent().addClass("required");
            $("#appUsuarios form select[name='"+item.campo+"']").parent().parent().addClass("required");


        }
        else if(item.valor==""){
            enviar =false;
            $("#appUsuarios form [name='"+item.campo+"']").parent().addClass("required");
              $("#appUsuarios form select[name='"+item.campo+"']").parent().parent().addClass("required");


        }
        else{
            enviar = true;
            $("#appUsuarios form [name='"+item.campo+"']").parent().removeClass("required");
              $("#appUsuarios form select[name='"+item.campo+"']").parent().parent().removeClass("required");

        }


      });

          if(this.senha.length<6) {
                enviar =false;
              $("#appUsuarios form [name='senha']").parent().addClass("required");

              alertify.error('Senha: Digite no mínimo 6 caracteres');
              return;


          }else if(this.senha.length>8) {
              enviar =false;
            $("#appUsuarios form [name='senha']").parent().addClass("required");
              alertify.error('Senha: Digite no máximo 8 caracteres');
              return;

          }else{

            this.salvarUsuarios();


          }

          return;




      },
    limparModulo(){
        appUsuarios.formulario=false;
        appUsuarios.visualizar=false;
        appUsuarios.nome=null;
        appUsuarios.senha=null;
        appUsuarios.telefone=null;
        appUsuarios.email=null;
        appUsuarios.id_permissao=null;
        appUsuarios.exclusao=null;
        },
    incluirUsuarios() {
        appUsuarios.formulario=true;
        appUsuarios.id=null;
        appUsuarios.nome=null;
        appUsuarios.senha=null;
        appUsuarios.telefone=null;
        appUsuarios.email=null;
        appUsuarios.id_permissao=null;
        appUsuarios.exclusao=null;
        appUsuarios.listarGruposUsuario();
        appUsuarios.listarGrupoSelUsuario();
      },
    salvarUsuarios(){
          var url ='';

          var msg ='';

          if(appUsuarios.id==null){

            msg='Sucesso ao incluir o cadastro!'

            url = config.dominio+'api/Usuarios/incluir';

          }else {

            url = config.dominio+'api/Usuarios/editar';

              msg='Sucesso ao alterar o cadastro!'

          }

          axios.post(url, {
            id:appUsuarios.id,
            nome :appUsuarios.nome,
            senha :appUsuarios.senha,
            telefone :appUsuarios.telefone,
            email :appUsuarios.email,
            id_permissao :appUsuarios.id_permissao,
            grupos:appUsuarios.listaSelGruposUser,
            exclusao :appUsuarios.exclusao,
            }).then(function(response) {

            appUsuarios.listarUsuarios();

            if(response.status==200){
                appUsuarios.formulario=false;
                alertify.success(msg);

            }else{

              alertify.error('Houve erro no servidor !');

            }

          });

    },
    editarUsuarios(id){
          axios.post(config.dominio+'api/Usuarios/listar',{
            id: id
          }).then(function(response) {
            appUsuarios.formulario=true;
            appUsuarios.total = response.data.total;
            var UsuariosDados = response.data.lista[0];
            appUsuarios.id=UsuariosDados.id;
            appUsuarios.nome=UsuariosDados.nome;
            appUsuarios.senha=UsuariosDados.senha;
            appUsuarios.telefone=UsuariosDados.telefone;
            appUsuarios.email=UsuariosDados.email;
            grupos:appUsuarios.listaSelGruposUser,
            appUsuarios.id_permissao=UsuariosDados.id_permissao;
            appUsuarios.exclusao=UsuariosDados.exclusao;
            appUsuarios.listarGruposUsuario(id);

            });
    },
		listarUsuarios(pagina=0){
	      axios.post(config.dominio+'api/Usuarios/listar', {
            pagina:pagina
	      }).then(function(response) {
          appUsuarios.limparModulo();
	        appUsuarios.total = response.data.lista.length;
	        appUsuarios.lista = response.data.lista;
          appUsuarios.totalPaginas = response.data.paginas;
	      });


	  },
    verUsuarios(id){
          axios.post(config.dominio+'api/Usuarios/listar',{
            id: id
          }).then(function(response) {
            appUsuarios.visualizar = true;
            appUsuarios.total = response.data.total;
            appUsuarios.dadosUsuarios = response.data.lista[0];
          });


        },
    verUsuariosAauth(id){
              axios.post(config.dominio+'api/Usuarios/listar',{
                id_aauth: id
              }).then(function(response) {
                appUsuarios.permissao =parseInt(response.data.lista[0].id_permissao);

                if(appUsuarios.permissao==2){

                  $('#menuUsuarios').hide();
                  $('#menuGrupo').hide();
                  //$('#menuAtividades').hide();
                }
              });


            },
    excluirUsuarios(id) {

      alertify.confirm("Deseja excluir o cadastro?",
        function(){
          axios.post(config.dominio+'api/Usuarios/excluir', {
            id: id
          }).then(function(response) {

            if(response.status==200){

              alertify.success('Sucesso ao deletar cadastro!');

              appUsuarios.listarUsuarios();

            }else{

              alertify.error('Erro no servidor ao deletar cadastro!');

            }

          });
        },
        function(){
          alertify.warning('Exclusão de cadastro cancelada');
        });

    },
    listarGruposUsuario(id_usuario=null){
	      axios.post(config.dominio+'api/Grupo/listar', {
	      }).then(function(response) {
          appUsuarios.listarGrupos =response.data.lista;

          appUsuarios.listarGrupoSelUsuario(id_usuario);

	      });


	  },
    gruposUsuario(id_usuario=null){
        axios.post(config.dominio+'api/Grupo/listar', {
        }).then(function(response) {
          console.log(response);
          appUsuarios.gruposUser= response.data.lista;

        });

        console.log(appUsuarios.gruposUser);


    },
    listarGrupoSelUsuario(id_usuario){
	      axios.post(config.dominio+'api/GrupoUsuario/listar', {
          id_usuario:id_usuario
	      }).then(function(response) {

          response.data.forEach((item) => {
              $(".guposUser input#"+item.id).attr('checked',true);

          });




	      });


	  },
    selGrupoUser() {
      var checked = [];

      $(".guposUser input[name='id_grupo']:checked").each(function(){ checked.push($(this).val()); });

        appUsuarios.listaSelGruposUser=checked;

    },
    verLogin(){
          axios.post(config.dominio+'api/Login/ver',{

          }).then(function(response) {
            console.log(response.data.length);

            if(response.data.length>0){

              appUsuarios.dadosLogin = response.data[0];

              appUsuarios.verUsuariosAauth(response.data[0].id);

              console.log(response.data[0]);

            }else {
              appHome.visualizar = true;
              window.location.href = 'login.html';

            }


          });


        },
    verUserLogin(callback=function(){}){
              axios.post(config.dominio+'api/Login/ver',{

              }).then(function(response) {

                if(response){
                  console.log(response);

                  appUsuarios.verPermissao(response.data[0].id,function(dadosUser) {

                      callback(dadosUser);

                  });


                }


              });


            },
    verPermissao(id,callback){
        console.log(id);
                      axios.post(config.dominio+'api/Usuarios/listar',{
                        id_aauth: id
                      }).then(function(response) {
                        console.log(response);

                        callback(response.data.lista[0].id_permissao);


                      });


                    },

  },
    created() {
      this.listarUsuarios();
      this.listarGruposUsuario();
      this.verLogin();
    }


}
var appUsuarios =new Vue(moduloUsuarios);
