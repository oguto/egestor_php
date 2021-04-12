
const  moduloGrupoDocumento = {
    el:'#appGrupoDocumento',
    data:{
    id: null,
    id_grupo:null,
    id_documento:null,
    exclusao:null,
    lista:[],
    dadosGrupoDocumento:null,
    conteudo: null,
    formulario:false,
    visualizar:false,
    total: 0
    },
    methods: {
      limparModulo(){
        appGrupoDocumento.formulario=false;
        appGrupoDocumento.visualizar=false;
        appGrupoDocumento.id_grupo=null;
        appGrupoDocumento.id_documento=null;
        appGrupoDocumento.exclusao=null;
        },
    incluirGrupoDocumento() {
        appGrupoDocumento.formulario=true;
        appGrupoDocumento.id=null;
      appGrupoDocumento.id_grupo=null;
      appGrupoDocumento.id_documento=null;
      appGrupoDocumento.exclusao=null;
      },
    salvarGrupoDocumento(){
          var url ='';

          var msg ='';

          if(appGrupoDocumento.id==null){

            msg='Sucesso ao incluir o cadastro!'

            url = config.dominio+'api/GrupoDocumento/incluir';

          }else {

            url = config.dominio+'api/GrupoDocumento/editar';

              msg='Sucesso ao alterar o cadastro!'

          }

          axios.post(url, {
              id:appGrupoDocumento.id,
            id_grupo :appGrupoDocumento.id_grupo,
            id_documento :appGrupoDocumento.id_documento,
            exclusao :appGrupoDocumento.exclusao,
            }).then(function(response) {

            appGrupoDocumento.listarGrupoDocumento();

            if(response.status==200){
                appGrupoDocumento.formulario=false;
                alertify.success(msg);

            }else{

              alertify.error('Houve erro no servidor !');

            }

          });

    },
    editarGrupoDocumento(id){
          axios.post(config.dominio+'api/GrupoDocumento/listar',{
            id: id
          }).then(function(response) {
            appGrupoDocumento.formulario=true;
            appGrupoDocumento.total = response.data.length;
            var GrupoDocumentoDados = response.data[0];
            appGrupoDocumentoid=GrupoDocumentoDados.id;
            appGrupoDocumento.id_grupo=GrupoDocumentoDados.id_grupo;
            appGrupoDocumento.id_documento=GrupoDocumentoDados.id_documento;
            appGrupoDocumento.exclusao=GrupoDocumentoDados.exclusao;
            });
    },
		listarGrupoDocumento(){
	      axios.post(config.dominio+'api/GrupoDocumento/listar', {
	      }).then(function(response) {
          appGrupoDocumento.limparModulo();
	        appGrupoDocumento.total = response.data.length;
	        appGrupoDocumento.lista = response.data;
	      });


	  },
    verGrupoDocumento(id){
          axios.post(config.dominio+'api/GrupoDocumento/listar',{
            id: id
          }).then(function(response) {
            appGrupoDocumento.visualizar = true;
            appGrupoDocumento.total = response.data.length;
            appGrupoDocumento.dadosGrupoDocumento = response.data[0];
          });


        },

    excluirGrupoDocumento(id) {

      alertify.confirm("Deseja excluir o cadastro?",
        function(){
          axios.post(config.dominio+'api/GrupoDocumento/excluir', {
            id: id
          }).then(function(response) {

            if(response.status==200){

              alertify.success('Sucesso ao deletar cadastro!');

              appGrupoDocumento.listarGrupoDocumento();

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
    this.listarGrupoDocumento();
  }


}
var appGrupoDocumento =new Vue(moduloGrupoDocumento);
