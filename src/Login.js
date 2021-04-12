
const  moduloLogin = {
    el:'#appLogin',
    data:{
    senha:null,
    senha2:null,
    telefone:null,
    id_aauth:null,
    email:null,
    codigo:null,
    lista:[],
    dadosLogin:null,
    conteudo: null,
    formulario:false,
    visualizar:false,
    esqSenha:false,
    codigoSms:false,
    redefinirSenha:false,
    total: 0,
    listarGrupos:[],
    listaSelGruposUser:[],
    },
    methods: {
    limparModulo(){
        appLogin.formulario=false;
        appLogin.visualizar=false;
        appLogin.esqSenha=false;
        appLogin.codigoSms=false;
        appLogin.nome=null;
        appLogin.senha=null;
        appLogin.telefone=null;
        appLogin.email=null;
        appLogin.id_permissao=null;
        appLogin.exclusao=null;
        },
    verLogin(callback=function(){}){
          axios.post(config.dominio+'api/Login/ver',{

          }).then(function(response) {

            if(response){

              appLogin.verPermissao(response.data.id,function(dadosUser) {

                  callback(dadosUser);

              });

              appLogin.visualizar = false;
              appLogin.total = response.data.length;
              appLogin.dadosLogin = response.data[0];

            }else {
              appLogin.visualizar = true;

            }


          });


        },
    esqueceuSenha() {
        appLogin.esqSenha=true;
        appLogin.codigoSms=false;
      },
    verPermissao(id,cllaback){
                  axios.post(config.dominio+'api/Usuarios/listar',{
                    id_aauth: id
                  }).then(function(response) {

                    cllaback(parseInt(response.data.id_permissao));


                  });


                },
    logar(){
              axios.post(config.dominio+'api/Login/logar',{
                email:appLogin.email,
                senha:appLogin.senha
              }).then(function(response) {

                if(response.data.length>0){
                  appLogin.visualizar = false;
                  appLogin.total = response.data.length;
                  appLogin.dadosLogin = response.data[0];
                  window.location.href = '/';

                }else {

                  alertify.error("Email ou senha incorretos");
                  appLogin.visualizar = true;

                }


              });


            },
    enviarCodigo(){
      if(appLogin.telefone!=null){
              axios.post(config.dominio+'api/usuarios/enviarCodigo',{
                telefone:appLogin.telefone
              }).then(function(response) {


                if(response.data.length>0){

                  appLogin.esqSenha=false;
                  appLogin.codigoSms=true;

                }else {

                  alertify.error("Nenhum registro foi enconrado de acordo com o nímero informado!");

                }


              });
            }else{
                alertify.error("informe o número do celular cadastrado!");
            }


            },
    validarCodigo(){
      if(appLogin.telefone!=null){
              axios.post(config.dominio+'api/usuarios/validarCodigo',{
                telefone:appLogin.telefone,
                codigo:appLogin.codigo
              }).then(function(response) {

                if(response.data.length>0){

                  appLogin.id_aauth=response.data[0].id_aauth;
                  appLogin.esqSenha=false;
                  appLogin.codigoSms=false;
                  appLogin.redefinirSenha=true;
                  alertify.success("Código validado com sucesso! Redefina sua senha.");

                }else {

                  alertify.error("Código inválido!");

                }


              });
            }else{
                alertify.error("informe o número do celular cadastrado!");
            }


            },
    mudarSenha(){
              if(appLogin.senha==appLogin.senha2){
                      axios.post(config.dominio+'api/Login/editar',{
                        id_aauth:appLogin.id_aauth,
                        telefone:appLogin.telefone,
                        senha:appLogin.senha
                      }).then(function(response) {

                        console.log(response.data);

                        if(response.data.length>0){

                          appLogin.esqSenha=false;
                          appLogin.codigoSms=false;
                          appLogin.redefinirSenha=false;
                          alertify.success("Senha alterada com sucesso!");

                        }else {

                          alertify.error("A senha tem que ter de 6 a 8 dígitos!");

                        }


                      });
                    }else{
                        alertify.error("As senhas são diferentes!");
                    }


                    },
    sair(id) {

      alertify.confirm("Deseja excluir o cadastro?",
        function(){
          axios.post(config.dominio+'api/Login/excluir', {
            id: id
          }).then(function(response) {

            if(response.status==200){

              alertify.success('Sucesso ao deletar cadastro!');

              appLogin.listarLogin();

            }else{

              alertify.error('Erro no servidor ao deletar cadastro!');

            }

          });
        },
        function(){
          alertify.warning('Exclusão de cadastro cancelada');
        });

    },
    listarGruposLogin(id_usuario=null){
	      axios.post(config.dominio+'api/Grupo/listar', {
	      }).then(function(response) {
          appLogin.listarGrupos =response.data;

          appLogin.listarGrupoSelLogin(id_usuario);

	      });


	  },
    listarGrupoSelLogin(id_usuario){
	      axios.post(config.dominio+'api/GrupoLogin/listar', {
          id_usuario:id_usuario
	      }).then(function(response) {



          response.data.forEach((item) => {
            console.log(item);

              $(".guposUser input#"+item.id_grupo).attr('checked',true);

          });




	      });


	  },
    selGrupoUser() {
      var checked = [];

      $(".guposUser input[name='id_grupo']:checked").each(function(){ checked.push($(this).val()); });

        appLogin.listaSelGruposUser=checked;

    },
  },
  created() {
    this.verLogin();

  }


}
var appLogin =new Vue(moduloLogin);
