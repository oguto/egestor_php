
const  moduloPastas = {
    el:'#appPastas',
    data:{
    id: null,
    nome:null,
    exclusao:null,
    lista:[],
    dadosPastas:null,
    conteudo: null,
    formulario:false,
    visualizar:false,
    total: 0
    },
    methods: {
      limparModulo(){
        appPastas.formulario=false;
        appPastas.visualizar=false;
        appPastas.nome=null;
        appPastas.exclusao=null;
        },
    incluirPastas() {
        appPastas.formulario=true;
        appPastas.id=null;
      appPastas.nome=null;
      appPastas.exclusao=null;
      },
    salvarPastas(){
          var url ='';

          var msg ='';

          if(appPastas.id==null){

            msg='Sucesso ao incluir o cadastro!'

            url = config.dominio+'api/Pastas/incluir';

          }else {

            url = config.dominio+'api/Pastas/editar';

              msg='Sucesso ao alterar o cadastro!'

          }

          axios.post(url, {
              id:appPastas.id,
            nome :appPastas.nome,
            exclusao :appPastas.exclusao,
            }).then(function(response) {

            appPastas.listarPastas();

            if(response.status==200){
                appPastas.formulario=false;
                alertify.success(msg);

            }else{

              alertify.error('Houve erro no servidor !');

            }

          });

    },
    editarPastas(id){
          axios.post(config.dominio+'api/Pastas/listar',{
            id: id
          }).then(function(response) {
            appPastas.formulario=true;
            appPastas.total = response.data.length;
            var PastasDados = response.data[0];
            appPastasid=PastasDados.id;
            appPastas.nome=PastasDados.nome;
            appPastas.exclusao=PastasDados.exclusao;
            });
    },
		listarPastas(){
	      axios.post(config.dominio+'api/Pastas/listar', {
	      }).then(function(response) {
          appPastas.limparModulo();
	        appPastas.total = response.data.length;
	        appPastas.lista = response.data;
	      });


	  },
    verPastas(id){
          axios.post(config.dominio+'api/Pastas/listar',{
            id: id
          }).then(function(response) {
            appPastas.visualizar = true;
            appPastas.total = response.data.length;
            appPastas.dadosPastas = response.data[0];
          });


        },

    excluirPastas(id) {

      alertify.confirm("Deseja excluir o cadastro?",
        function(){
          axios.post(config.dominio+'api/Pastas/excluir', {
            id: id
          }).then(function(response) {

            if(response.status==200){

              alertify.success('Sucesso ao deletar cadastro!');

              appPastas.listarPastas();

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
    this.listarPastas();
  }


}
var appPastas =new Vue(moduloPastas);
