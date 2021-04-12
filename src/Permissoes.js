
const  moduloPermissoes = {
    el:'#appPermissoes',
    data:{
    id: null,
    nome:null,
    exclusao:null,
    lista:[],
    dadosPermissoes:null,
    conteudo: null,
    formulario:false,
    visualizar:false,
    total: 0
    },
    methods: {
      limparModulo(){
        appPermissoes.formulario=false;
        appPermissoes.visualizar=false;
        appPermissoes.nome=null;
        appPermissoes.exclusao=null;
        },
    incluirPermissoes() {
        appPermissoes.formulario=true;
        appPermissoes.id=null;
      appPermissoes.nome=null;
      appPermissoes.exclusao=null;
      },
    salvarPermissoes(){
          var url ='';

          var msg ='';

          if(appPermissoes.id==null){

            msg='Sucesso ao incluir o cadastro!'

            url = config.dominio+'api/Permissoes/incluir';

          }else {

            url = config.dominio+'api/Permissoes/editar';

              msg='Sucesso ao alterar o cadastro!'

          }

          axios.post(url, {
              id:appPermissoes.id,
            nome :appPermissoes.nome,
            exclusao :appPermissoes.exclusao,
            }).then(function(response) {

            appPermissoes.listarPermissoes();

            if(response.status==200){
                appPermissoes.formulario=false;
                alertify.success(msg);

            }else{

              alertify.error('Houve erro no servidor !');

            }

          });

    },
    editarPermissoes(id){
          axios.post(config.dominio+'api/Permissoes/listar',{
            id: id
          }).then(function(response) {
            appPermissoes.formulario=true;
            appPermissoes.total = response.data.length;
            var PermissoesDados = response.data[0];
            appPermissoesid=PermissoesDados.id;
            appPermissoes.nome=PermissoesDados.nome;
            appPermissoes.exclusao=PermissoesDados.exclusao;
            });
    },
		listarPermissoes(){
	      axios.post(config.dominio+'api/Permissoes/listar', {
	      }).then(function(response) {
          appPermissoes.limparModulo();
	        appPermissoes.total = response.data.length;
	        appPermissoes.lista = response.data;
	      });


	  },
    verPermissoes(id){
          axios.post(config.dominio+'api/Permissoes/listar',{
            id: id
          }).then(function(response) {
            appPermissoes.visualizar = true;
            appPermissoes.total = response.data.length;
            appPermissoes.dadosPermissoes = response.data[0];
          });


        },

    excluirPermissoes(id) {

      alertify.confirm("Deseja excluir o cadastro?",
        function(){
          axios.post(config.dominio+'api/Permissoes/excluir', {
            id: id
          }).then(function(response) {

            if(response.status==200){

              alertify.success('Sucesso ao deletar cadastro!');

              appPermissoes.listarPermissoes();

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
    this.listarPermissoes();
  }


}
var appPermissoes =new Vue(moduloPermissoes);
