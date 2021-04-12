
const  moduloGrupoUsuario = {
    el:'#appGrupoUsuario',
    data:{
    id: null,
    id_grupo:null,
    id_usuario:null,
    exclusao:null,
    lista:[],
    dadosGrupoUsuario:null,
    conteudo: null,
    formulario:false,
    visualizar:false,
    total: 0
    },
    methods: {
      limparModulo(){
        appGrupoUsuario.formulario=false;
        appGrupoUsuario.visualizar=false;
        appGrupoUsuario.id_grupo=null;
        appGrupoUsuario.id_usuario=null;
        appGrupoUsuario.exclusao=null;
        },
    incluirGrupoUsuario() {
        appGrupoUsuario.formulario=true;
        appGrupoUsuario.id=null;
      appGrupoUsuario.id_grupo=null;
      appGrupoUsuario.id_usuario=null;
      appGrupoUsuario.exclusao=null;
      },
    salvarGrupoUsuario(){
          var url ='';

          var msg ='';

          if(appGrupoUsuario.id==null){

            msg='Sucesso ao incluir o cadastro!'

            url = config.dominio+'api/GrupoUsuario/incluir';

          }else {

            url = config.dominio+'api/GrupoUsuario/editar';

              msg='Sucesso ao alterar o cadastro!'

          }

          axios.post(url, {
              id:appGrupoUsuario.id,
            id_grupo :appGrupoUsuario.id_grupo,
            id_usuario :appGrupoUsuario.id_usuario,
            exclusao :appGrupoUsuario.exclusao,
            }).then(function(response) {

            appGrupoUsuario.listarGrupoUsuario();

            if(response.status==200){
                appGrupoUsuario.formulario=false;
                alertify.success(msg);

            }else{

              alertify.error('Houve erro no servidor !');

            }

          });

    },
    editarGrupoUsuario(id){
          axios.post(config.dominio+'api/GrupoUsuario/listar',{
            id: id
          }).then(function(response) {
            appGrupoUsuario.formulario=true;
            appGrupoUsuario.total = response.data.length;
            var GrupoUsuarioDados = response.data[0];
            appGrupoUsuarioid=GrupoUsuarioDados.id;
            appGrupoUsuario.id_grupo=GrupoUsuarioDados.id_grupo;
            appGrupoUsuario.id_usuario=GrupoUsuarioDados.id_usuario;
            appGrupoUsuario.exclusao=GrupoUsuarioDados.exclusao;
            });
    },
		listarGrupoUsuario(){
	      axios.post(config.dominio+'api/GrupoUsuario/listar', {
	      }).then(function(response) {
          appGrupoUsuario.limparModulo();
	        appGrupoUsuario.total = response.data.length;
	        appGrupoUsuario.lista = response.data;
	      });


	  },
    verGrupoUsuario(id){
          axios.post(config.dominio+'api/GrupoUsuario/listar',{
            id: id
          }).then(function(response) {
            appGrupoUsuario.visualizar = true;
            appGrupoUsuario.total = response.data.length;
            appGrupoUsuario.dadosGrupoUsuario = response.data[0];
          });


        },

    excluirGrupoUsuario(id) {

      alertify.confirm("Deseja excluir o cadastro?",
        function(){
          axios.post(config.dominio+'api/GrupoUsuario/excluir', {
            id: id
          }).then(function(response) {

            if(response.status==200){

              alertify.success('Sucesso ao deletar cadastro!');

              appGrupoUsuario.listarGrupoUsuario();

            }else{

              alertify.error('Erro no servidor ao deletar cadastro!');

            }

          });
        },
        function(){
          alertify.warning('Exclusão de cadastro cancelada');
        });

    }
  },
  created() {
    this.listarGrupoUsuario();
  }


}
var appGrupoUsuario =new Vue(moduloGrupoUsuario);
