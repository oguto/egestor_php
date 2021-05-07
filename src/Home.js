const  moduloHome = {
    el:'#appHome',
    data:{
      titulo: null,
      id: null,
      nome:null,
      nova_pasta:null,
      id_pasta:null,
      data_inicial:null,
      data_final:null,
      palavras_chaves:null,
      url:null,
      exclusao:null,
      usuario: "",
      statusDoc:"",
      dadosDocumentos:null,
      conteudo: null,
      formulario:false,
      visualizar:false,
      total: 0,
      totalPaginas:1,
      paginaAtual:1,
      uploadError: null,
      thumbnail:null,
      listThumbnail:[],
      lista:[],
      listaSelGrupos:[],
      listaArquivos:[],
      listaArqExcluir:[],
      listarGrupos:[],
      listarPastas:[],
      uploadedFiles: [],
      pasta:".."
    },
    methods: {
    limparModulo(){
        appHome.formulario=false;
        appHome.visualizar=false;
        appHome.nome=null;
        appHome.id=null;
        appHome.id_pasta=null;
        appHome.data_inicial=null;
        appHome.data_final=null;
        appHome.palavras_chaves=null;
        appHome.url=null;
        appHome.exclusao=null;
        appHome.listaArqExcluir=[];
        appHome.listaArquivos=[];
        appHome.totalPaginas=0;
        appHome.thumbnail=[];
        appHome.listThumbnail=[];
        },
    incluirDocumentos() {
      appHome.titulo="Novo Documento";
      appHome.listarGruposDoc();
      appHome.listarPastasDoc();
      appHome.limparModulo();
      appHome.formulario=true;
      },
    salvarDocumentos(){
          var dadosArquivos={
            id:appHome.id,
            nome :appHome.nome,
            id_pasta :appHome.id_pasta,
            nova_pasta :appHome.nova_pasta,
            data_inicial :appHome.data_inicial,
            data_final :appHome.data_final,
            palavras_chaves :appHome.palavras_chaves,
            grupos:appHome.listaSelGrupos,
            url :appHome.url,
            thumbnail:appHome.thumbnail,
            exclusao :appHome.exclusao,
            }

            if(appHome.id==null){

              appHome.enviarDocumento(dadosArquivos);

            }else {

                axios.post( config.dominio+'api/Documentos/editar',dadosArquivos).then(function(response) {

                  if(response.status==200){

                    appHome.salvarAtividades("editou o arquivo Nº "+dadosArquivos.id+".");

                      alertify.success("Sucesso ao alterar o documento!");

                  }else{

                      alertify.error("Houve erro ao editar o  arquivo");

                  }

                });

            }

    },
    editarDocumentos(id){
          axios.post(config.dominio+'api/Documentos/listar',{
            id: id
          }).then(function(response) {
            appHome.titulo="Editar Documento";
            appHome.formulario=true;
            appHome.total = response.data.length;
            var DocumentosDados = response.data[0];
            appHome.id=DocumentosDados.id;
            appHome.nome=DocumentosDados.nome;
            appHome.id_pasta=DocumentosDados.id_pasta;
            appHome.data_inicial=DocumentosDados.data_inicial;
            appHome.data_final=DocumentosDados.data_final;
            appHome.palavras_chaves=DocumentosDados.palavras_chaves;
            appHome.url=DocumentosDados.url;
            appHome.exclusao=DocumentosDados.exclusao;
            appHome.listaArqExcluir=[];
            appHome.listarGruposDoc(id);
            appHome.listarPastasDoc();
            });
    },
		listarDocumentos(status="ativo",pagina=0){
	      axios.post(config.dominio+'api/Documentos/listar',
        {status:status,pagina:pagina}).then(function(response) {
          appHome.limparModulo();
	        appHome.total = response.data.total;
	        appHome.lista = response.data.lista;
          appHome.totalPaginas = response.data.paginas;
          appHome.statusDoc=status;

	      });
	  },
    verDocumentos(id){
          axios.post(config.dominio+'api/Documentos/listar',{
            id: id
          }).then(function(response) {
            appHome.visualizar = true;
            appHome.total = response.data.total;
            appHome.dadosDocumentos = response.data.lista[0];
            appHome.verArquivo(response.data.lista[0].url,"documentosPdf",1);
            appHome.listaArqExcluir=[];
            appHome.salvarAtividades("visualizou o arquivo Nº "+appHome.dadosDocumentos.id+".");


          });


        },
    uploadDocumento(formData,callback) {
      axios.post(config.dominio+'api/Documentos/upload', formData,{
        headers: {
        'Content-Type': 'multipart/form-data'
      }}
    ).then(function(response) {
      console.log(response);
        callback(response);
      });
    },
    enviarDocumento(dadosArquivos) {

      appHome.listaArquivos;
     // handle file changes

     if (!appHome.listaArquivos.length) return;

     // append the files to FormData
     Array
       .from(Array(appHome.listaArquivos.length).keys())
       .map(x => {
          var formData = new FormData();
          formData.append('documentos', appHome.listaArquivos[x]);
        appHome.uploadDocumento(formData,function (dadosEnvio) {
          console.log(dadosEnvio);

          dadosArquivos.thumbnail=appHome.listThumbnail[x];

          var upload = dadosEnvio.data;

             if(appHome.listaArquivos.length>1){

               dadosArquivos.nome=appHome.listaArquivos[x].name;

               dadosArquivos.url="/upload/"+upload.arquivo.file_name

             }else{
                  dadosArquivos.url="/upload/"+upload.arquivo.file_name
             }
             axios.post(config.dominio+'api/Documentos/incluir',dadosArquivos).then(function(response) {
               console.log(response.data);

                   appHome.salvarAtividades("enviou o arquivo Nº"+response.data+".");

               if(response.status==200){

                   appHome.listarDocumentos();

                   alertify.success("Sucesso ao enviar o arquivo Nº"+response.data+".");

               }else{

                 alertify.error("Houve erro ao enviar o  arquivo <b><br>"+appHome.listaArquivos[x].name+"</b>");

               }

             });
           });

       });


        appHome.formulario=false;




     // save it

   },
    selecionarDocumento(fieldName, fileList,enviar=false) {

      appHome.listaArquivos=fileList;
     // handle file changes

     if (!fileList.length) return;

     // append the files to FormData
     Array
       .from(Array(fileList.length).keys())
       .map(x => {
          var formData = new FormData();

           appHome.gerarTumb(fileList[x],x);
            formData.append(fieldName, fileList[x]);


         if(enviar){

           appHome.uploadDocumento(formData);

         }


       });


     // save it

   },
    excluirDocumentos(id) {

      alertify.confirm("Deseja excluir o cadastro?",
        function(){
          axios.post(config.dominio+'api/Documentos/excluir', {
            id: id
          }).then(function(response) {

            if(response.status==200){

              alertify.success('Sucesso ao deletar cadastro!');

              appHome.listarDocumentos();

            }else{

              alertify.error('Erro no servidor ao deletar cadastro!');

            }

          });
        },
        function(){
          alertify.warning('Exclusão de cadastro cancelada');
        });

    },
    listarGruposDoc(id=null){
	      axios.post(config.dominio+'api/Grupo/listar', {
	      }).then(function(response) {
          appHome.listarGrupos =response.data;

          if(id!=null){

            appHome.listarGrupoDocumento(id);
          }



	      });


	  },
    listarPastasDoc(){
        axios.post(config.dominio+'api/Pastas/listar', {
        }).then(function(response) {
          appHome.listarPastas = response.data;
        });


    },
    listarGrupoDocumento(id_documento){
	      axios.post(config.dominio+'api/GrupoDocumento/listar', {
          id_documento:id_documento
	      }).then(function(response) {



          response.data.forEach((item) => {
            console.log(item);


              $(".gruposDoc input#"+item.id_grupo).attr('checked',true);

          });




	      });


	  },
    gerarTumb(arquivos,id=0){

      var url ='';
      var reader = new FileReader();
      reader.onloadend = function () {
      var url =reader.result;


      if(arquivos.type=="application/pdf"){
          pdfjsLib.GlobalWorkerOptions.workerSrc = './js/pdf.worker.js';
          var loadingTask = pdfjsLib.getDocument(url);
          loadingTask.promise.then(function(pdf) {
            pdf.getPage(1).then(function(page) {

              var scale = 1.5;
              var viewport = page.getViewport({
                scale: scale,
              });

              //
              // Prepare canvas using PDF page dimensions
              //
              var canvas = document.createElement('canvas');
              canvas.id = "prev_"+id;
              canvas.style="direction: ltr;";
              canvas.height = viewport.height;
              canvas.width = viewport.width;
              var context = canvas.getContext('2d');

              document.getElementById('previsualizar').appendChild(canvas);

                                      //
              // Render PDF page into canvas context
              //
              var renderContext = {
                canvasContext: context,
                viewport: viewport,
              };
                page.render(renderContext).promise.then(function(){

                  var img =  ($('canvas#prev_'+id)[0]).toDataURL("image/png");

                  base64Resize(img,0.3,function(urlTumb) {

                    appHome.listThumbnail[id]=urlTumb;

                  });



               });



            });
          });
        }else{

          base64Resize(url,0.3,function(urlTumb) {

            appHome.listThumbnail[id]=urlTumb;

          });

        }

      }
      reader.readAsDataURL(arquivos);

    },
    verArquivo(url,target=null,pagina){

      if(url.search(".pdf")>=1){

        pdfjsLib.GlobalWorkerOptions.workerSrc = './js/pdf.worker.js';

        var loadingTask = pdfjsLib.getDocument(url);
        loadingTask.promise.then(function(pdf) {
          //
          // Fetch the first page
          //
          pdf.getPage(pagina).then(function(page) {
            var scale = 1.5;
            var viewport = page.getViewport({
              scale: scale,
            });

            //
            // Prepare canvas using PDF page dimensions
            //
            var canvas = document.getElementById(target);
            var context = canvas.getContext('2d');
            canvas.height = viewport.height;
            canvas.width = viewport.width;

            //
            // Render PDF page into canvas context
            //
            var renderContext = {
              canvasContext: context,
              viewport: viewport,
            };

            page.render(renderContext).promise.then(function(){

              appHome.totalPaginas=pdf.numPages;

           });

          });

        });
      }else{
        window.onload = function() {

          var image = new Image();
          var canvas = document.getElementById(target);
          var context = canvas.getContext('2d');
          console.log(canvas);
          var ctx = tela.getContext('2d');

          image.addEventListener('load', e => {

            ctx.drawImage(this,this.width, this.height);
          });
          image.src = url;

          }



      }

    },
    selDoc(id) {
      if(!$('ul#doc_'+id).hasClass("active")){

        $('ul#doc_'+id).addClass("active");

        appHome.listaArqExcluir.push(id);


      }else {
        const index = appHome.listaArqExcluir.indexOf(id);

        if (index > -1) {
          appHome.listaArqExcluir.splice(index, 1);
        }

        $('ul#doc_'+id).removeClass("active");
      }

  },
    selGrupoDoc() {
      var checked = [];

      $("input[name='id_grupo']:checked").each(function(){ checked.push($(this).val()); });

        appHome.listaSelGrupos=checked;

    },
    desselecionaTudo(){

        $('.docs').removeClass("active");

        $('.docs input').prop('checked', false);

        appHome.listaArqExcluir=[];

      },
    excluirEmMassa(){

              alertify.confirm("Deseja excluir o cadastro?",
                function(){

                  alertify.success('Sucesso ao deletar cadastro!');

                      appHome.listaArqExcluir.forEach(function(item){


                        axios.post(config.dominio+'api/Documentos/excluir', {
                          id: item
                        });


                      });

                      $('.docs').removeClass("active");

                      $('.docs input').prop('checked', false);

                      appHome.listaArqExcluir=[];

                      appHome.listarDocumentos();


                },
                function(){
                  alertify.warning('Exclusão de cadastro cancelada');
                });


      },
    gerarImg(id,url){

        var canvas = document.createElement('canvas');
        canvas.width ="100%";
        canvas.height = "100%";
        console.log(canvas);
       var ctx = canvas.getContext("2d");
       ctx.drawImage(url, 10, 10);

     },
    mudarPagina(url,target=null,acao){

      console.log(appHome.paginaAtual);

      if(acao=="anterior"){
        if (appHome.paginaAtual <= 1) {
          return;
        }
        appHome.paginaAtual--;
        appHome.verArquivo(url,target, appHome.paginaAtual);
      } else if(acao=="proximo"){

        if (appHome.paginaAtual >=appHome.totalPaginas) {
          return;
        }
        appHome.paginaAtual++;

        appHome.verArquivo(url,target, appHome.paginaAtual);



      }

    },
    salvarAtividades(msg){

            url = config.dominio+'api/Atividades/incluir';
          axios.post(url, {
            acesso :msg
            });

    },
    verLogin(){
          axios.post(config.dominio+'api/Login/ver',{

          }).then(function(response) {
            console.log(response.data.length);

            if(response.data.length>0){

              appHome.login = true;
              appHome.total = response.data.length;
              appHome.dadosLogin = response.data[0];
              appHome.usuario = response.data[0].username;

              console.log(response.data[0]);

            }else {
              appHome.visualizar = true;
              window.location.href = 'login.html';

            }


          });


        }

  },
  created() {
    this.listarDocumentos();
    this.verLogin();

  }


};

var appHome =new Vue(moduloHome);

new Vue({
  el: '#menuSair',
  methods: {
      sair(){
        axios.post(config.dominio+'api/Login/sair',{

        }).then(function(response) {

          appHome.verLogin();


        });
      }

  }
});
