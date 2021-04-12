
const  moduloAtividades = {
    el:'#appAtividades',
    data:{
    id: null,
    acesso:null,
    data:null,
    de:null,
    ate:null,
    exclusao:null,
    lista:[],
    dadosAtividades:null,
    conteudo: null,
    formulario:false,
    visualizar:false,
    total: 0
    },
    methods: {
      limparModulo(){
          appAtividades.formulario=false;
          appAtividades.visualizar=false;
          appAtividades.acesso=null;
          appAtividades.data=null;
          appAtividades.de=null;
          appAtividades.ate=null;
          appAtividades.exclusao=null;
          },
      incluirAtividades() {
          appAtividades.formulario=true;
          appAtividades.id=null;
        appAtividades.acesso=null;
        appAtividades.data=null;
        appAtividades.exclusao=null;
        },
      salvarAtividades(){
            var url ='';

            var msg ='';

            if(appAtividades.id==null){

              msg='Sucesso ao incluir o cadastro!'

              url = config.dominio+'api/Atividades/incluir';

            }else {

              url = config.dominio+'api/Atividades/editar';

                msg='Sucesso ao alterar o cadastro!'

            }

            axios.post(url, {
                id:appAtividades.id,
              acesso :appAtividades.acesso,
              data :appAtividades.data,
              exclusao :appAtividades.exclusao,
              }).then(function(response) {

              appAtividades.listarAtividades();

              if(response.status==200){
                  appAtividades.formulario=false;
                  alertify.success(msg);

              }else{

                alertify.error('Houve erro no servidor !');

              }

            });

      },
      editarAtividades(id){
            axios.post(config.dominio+'api/Atividades/listar',{
              id: id
            }).then(function(response) {
              appAtividades.formulario=true;
              appAtividades.total = response.data.length;
              var AtividadesDados = response.data[0];
              appAtividadesid=AtividadesDados.id;
              appAtividades.acesso=AtividadesDados.acesso;
              appAtividades.data=AtividadesDados.data;
              appAtividades.exclusao=AtividadesDados.exclusao;
              });
      },
  		listarAtividades(){
  	      axios.post(config.dominio+'api/Atividades/listar', {
            acesso:appAtividades.acesso,
            de:appAtividades.de,
            ate:appAtividades.ate
          }).then(function(response) {
            //appAtividades.limparModulo();
  	        appAtividades.total = response.data.length;
  	        appAtividades.lista = response.data;
  	      });


  	  },
      verAtividades(id){
            axios.post(config.dominio+'api/Atividades/listar',{
              id: id
            }).then(function(response) {
              appAtividades.visualizar = true;
              appAtividades.total = response.data.length;
              appAtividades.dadosAtividades = response.data[0];
            });


          },
      excluirAtividades(id) {

        alertify.confirm("Deseja excluir o cadastro?",
          function(){
            axios.post(config.dominio+'api/Atividades/excluir', {
              id: id
            }).then(function(response) {

              if(response.status==200){

                alertify.success('Sucesso ao deletar cadastro!');

                appAtividades.listarAtividades();

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
  
    this.listarAtividades();
  }


}
var appAtividades =new Vue(moduloAtividades);


new Vue({
  el: '#menuAtividades',
  methods: {
      homeAtividades(){


        appAtividades.listarAtividades();
      }

  }
});
