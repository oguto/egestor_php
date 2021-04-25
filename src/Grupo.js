
const  moduloGrupo = {
    el:'#appGrupo',
    data:{
    id: null,
    nome:null,
    exclusao:null,
    lista:[],
    dadosGrupo:null,
    conteudo: null,
    titulo: null,
    formulario:false,
    visualizar:false,
    permissao:null,
    total: 0,
    totalPaginas:0,
    paginaAtual:1
    },
    methods: {
      limparModulo(){
        appGrupo.formulario=false;
        appGrupo.visualizar=false;
        appGrupo.nome=null;
        appGrupo.exclusao=null;
        },
    incluirGrupo() {
      appGrupo.formulario=true;
      appGrupo.titulo="Novo Grupo";
      appGrupo.id=null;
      appGrupo.nome=null;
      appGrupo.exclusao=null;
      },
    salvarGrupo(){
          var url ='';

          var msg ='';

          if(appGrupo.id==null){

            msg='Sucesso ao incluir o cadastro!'

            url = config.dominio+'api/Grupo/incluir';

          }else {

            url = config.dominio+'api/Grupo/editar';

              msg='Sucesso ao alterar o cadastro!'

          }

          axios.post(url, {
              id:appGrupo.id,
            nome :appGrupo.nome,
            exclusao :appGrupo.exclusao,
            }).then(function(response) {

            appGrupo.listarGrupo();

            if(response.status==200){
                appGrupo.formulario=false;
                alertify.success(msg);

            }else{

              alertify.error('Houve erro no servidor !');

            }

          });

    },
    editarGrupo(id){
          axios.post(config.dominio+'api/Grupo/listar',{
            id: id
          }).then(function(response) {
            appGrupo.formulario=true;
            appGrupo.titulo="Editar Grupo";
            appGrupo.total = response.data.length;
            var GrupoDados = response.data.lista[0];
            appGrupo.id=GrupoDados.id;
            appGrupo.nome=GrupoDados.nome;
            appGrupo.exclusao=GrupoDados.exclusao;
            });
    },
		listarGrupo(pagina=0){
	      axios.post(config.dominio+'api/Grupo/listar', {
          pagina:pagina
	      }).then(function(response) {
          appGrupo.limparModulo();
	        appGrupo.total = response.data.lista.length;
	        appGrupo.lista = response.data.lista;
          appGrupo.totalPaginas = response.data.paginas;
          appUsuarios.verUserLogin(function(dadosPermissoes) {
          appGrupo.permissao=dadosPermissoes;

          })
	      });


	  },
    verGrupo(id){
          axios.post(config.dominio+'api/Grupo/listar',{
            id: id
          }).then(function(response) {
            appGrupo.visualizar = true;
            appGrupo.total = response.data.length;
            appGrupo.dadosGrupo = response.data[0];
          });


        },

    excluirGrupo(id) {

      alertify.confirm("Deseja excluir o cadastro?",
        function(){
          axios.post(config.dominio+'api/Grupo/excluir', {
            id: id
          }).then(function(response) {

            if(response.status==200){

              alertify.success('Sucesso ao deletar cadastro!');

              appGrupo.listarGrupo();

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
    this.listarGrupo();

  }


}
var appGrupo =new Vue(moduloGrupo);
