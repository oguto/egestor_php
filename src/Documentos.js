const BASE_URL = 'http://localhost/documentos/';


function base64Resize(sourceBase64, scale , callBack) {

    const _scale = scale;
    var img = document.createElement('img');
    img.setAttribute("src", sourceBase64);

    img.onload = () => {
        var canvas = document.createElement('canvas');
        canvas.width = img.width * _scale;
        canvas.height = img.height * _scale;

        var ctx = canvas.getContext("2d");
        var cw = canvas.width;
        var ch = canvas.height;
        var maxW = img.width * _scale;
        var maxH = img.height * _scale;

        var iw = img.width;
        var ih = img.height;
        var scl = Math.min((maxW / iw), (maxH / ih));
        var iwScaled = iw * scl;
        var ihScaled = ih * scl;
        canvas.width = iwScaled;
        canvas.height = ihScaled;
        ctx.drawImage(img, 0, 0, iwScaled, ihScaled);
        const newBase64 = canvas.toDataURL("image/jpeg", scl);

        callBack(newBase64);
    }
}

const  moduloDocumentos = {
    el:'#appDocumentos',
    data:{
      titulo: null,
      id: null,
      nome:null,
      nova_pasta:null,
      id_pasta:null,
      data_inicial:null,
      data_final:null,
      data_br:null,
      palavras_chaves:null,
      url:null,
      grupo:null,
      exclusao:false,
      dadosDocumentos:null,
      conteudo: null,
      formulario:false,
      visualizar:false,
      total: 0,
      totalPaginasDocs:0,
      paginaAtualDocs:1,
      totalPaginas:0,
      paginaAtual:1,
      uploadError: null,
      currentStatus: null,
      thumbnail:null,
      listThumbnail:[],
      lista:[],
      listaSelGrupos:[],
      listaArquivos:[],
      listaArqExcluir:[],
      listarGrupos:[],
      listarPastas:[],
      uploadedFiles: [],
    },
    methods: {
    limparModulo(){
        appDocumentos.formulario=false;
        appDocumentos.visualizar=false;
        appDocumentos.nome=null;
        appDocumentos.id=null;
        appDocumentos.id_pasta=null;
        appDocumentos.data_inicial=null;
        appDocumentos.data_final=null;
        appDocumentos.palavras_chaves=null;
        appDocumentos.url=null;
        appDocumentos.listaArqExcluir=[];
        appDocumentos.listaArquivos=[];
        appDocumentos.totalPaginas=0;
        appDocumentos.paginaAtual=1;
        appDocumentos.thumbnail=[];
        appDocumentos.listThumbnail=[];
        },
    incluirDocumentos() {
      appDocumentos.titulo="Novo Documento";
      appDocumentos.listarGruposDoc();
      appDocumentos.listarPastasDoc();
      appDocumentos.limparModulo();
      appDocumentos.formulario=true;
      },
    salvarDocumentos(){
          var dadosArquivos={
            id:appDocumentos.id,
            nome :appDocumentos.nome,
            id_pasta :appDocumentos.id_pasta,
            nova_pasta :appDocumentos.nova_pasta,
            data_inicial :appDocumentos.data_inicial,
            data_final :appDocumentos.data_final,
            palavras_chaves :appDocumentos.palavras_chaves,
            grupos:appDocumentos.listaSelGrupos,
            url :appDocumentos.url,
            thumbnail:appDocumentos.thumbnail,
            exclusao :appDocumentos.exclusao,
            }

            if(appDocumentos.id==null){

              appDocumentos.enviarDocumento(dadosArquivos);

            }else {

                axios.post( config.dominio+'api/Documentos/editar',dadosArquivos).then(function(response) {

                  if(response.status==200){

                    appDocumentos.salvarAtividades("editou o arquivo Nº "+dadosArquivos.id+".");

                      alertify.success("Sucesso ao alterar o documento!");

                  }else{

                      alertify.error("Houve erro ao editar o  arquivo");

                  }

                });

            }

    },
    editarDocumentos(id){
          axios.post(config.dominio+'api/Documentos/listar',{
            id: id,
            exclusao:appDocumentos.exclusao
          }).then(function(response) {
            appDocumentos.titulo="Editar Documento";
            appDocumentos.formulario=true;
            appDocumentos.total = response.data.length;
            var DocumentosDados = response.data[0];
            appDocumentos.id=DocumentosDados.id;
            appDocumentos.nome=DocumentosDados.nome;
            appDocumentos.id_pasta=DocumentosDados.id_pasta;
            appDocumentos.data_inicial=DocumentosDados.data_inicial;
            appDocumentos.data_final=DocumentosDados.data_final;
            appDocumentos.palavras_chaves=DocumentosDados.palavras_chaves;
            appDocumentos.url=DocumentosDados.url;
            appDocumentos.exclusao=DocumentosDados.exclusao;
            appDocumentos.listaArqExcluir=[];
            appDocumentos.listarGruposDoc(id);
            appDocumentos.listarPastasDoc();
            });
    },
		listarDocumentos(pagina=0,grupo=0,pasta=null){

	      axios.post(config.dominio+'api/Documentos/listar',
        {grupo:grupo,id_pasta:pasta,pagina:pagina}).then(function(response) {
          console.log(response);

          if((pagina)!=appDocumentos.paginaAtualDocs){

            appDocumentos.paginaAtualDocs=1;

          }

          appDocumentos.exclusao=false;
          appDocumentos.grupo=grupo;
          appDocumentos.listarGruposDoc();
          appDocumentos.listarPastasDoc();
          appDocumentos.limparModulo();
	        appDocumentos.total = response.data.total;
	        appDocumentos.lista = response.data.lista;
          appDocumentos.totalPaginasDocs=response.data.paginas;
          $(".gruposMenu li").removeClass("active");
          $("li#grupo_"+grupo).addClass("active");
          if(pasta!=null){

            $(".pastas li#pasta_"+pasta).toggleClass("active");

          }


	      });


	  },
    listarExcluidos(pagina=0,grupo=0,pasta=null){

        appDocumentos.listarGruposDoc();

        appDocumentos.grupo=grupo;

	      axios.post(config.dominio+'api/Documentos/listar',
        {grupo:appDocumentos.grupo,
          id_pasta:pasta,
          exclusao:true}).then(function(response) {
          appDocumentos.limparModulo();
          appDocumentos.total = response.data.total;
         appDocumentos.lista = response.data.lista;
          appDocumentos.totalPaginasDocs=response.data.paginas;
          appDocumentos.exclusao=true;
          $(".gruposMenu li").removeClass("active");
          $("li#docExcluido").addClass("active");


	      });


	  },
    verDocumentos(id){
          axios.post(config.dominio+'api/Documentos/listar',{
            id: id,
            exclusao:appDocumentos.exclusao
          }).then(function(response) {
            appDocumentos.visualizar = true;
            appDocumentos.total = response.data.lista.length;
            appDocumentos.dadosDocumentos = response.data.lista[0];
            appDocumentos.verArquivo(response.data.lista[0].url,"documentosPdf",1);
            appDocumentos.listaArqExcluir=[];
            appDocumentos.salvarAtividades("visualizou o arquivo Nº "+appDocumentos.dadosDocumentos.id+".");


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

      appDocumentos.listaArquivos;
     // handle file changes

     if (!appDocumentos.listaArquivos.length) return;

     // append the files to FormData
     Array
       .from(Array(appDocumentos.listaArquivos.length).keys())
       .map(x => {
          var formData = new FormData();
          formData.append('documentos', appDocumentos.listaArquivos[x]);
        appDocumentos.uploadDocumento(formData,function (dadosEnvio) {
          console.log(dadosEnvio);

          dadosArquivos.thumbnail=appDocumentos.listThumbnail[x];

          var upload = dadosEnvio.data;

             if(appDocumentos.listaArquivos.length>1){

               dadosArquivos.nome=appDocumentos.listaArquivos[x].name;

               dadosArquivos.url="/upload/"+upload.arquivo.file_name

             }else{
                  dadosArquivos.url="/upload/"+upload.arquivo.file_name
             }
             axios.post(config.dominio+'api/Documentos/incluir',dadosArquivos).then(function(response) {
               console.log(response.data);

                   appDocumentos.salvarAtividades("enviou o arquivo Nº"+response.data+".");

               if(response.status==200){

                   appDocumentos.listarDocumentos();

                   alertify.success("Sucesso ao enviar o arquivo Nº"+response.data+".");

               }else{

                 alertify.error("Houve erro ao enviar o  arquivo <b><br>"+appDocumentos.listaArquivos[x].name+"</b>");

               }

             });
           });

       });


        appDocumentos.formulario=false;




     // save it

   },
    selecionarDocumento(fieldName, fileList,enviar=false) {

      appDocumentos.listaArquivos=fileList;
     // handle file changes

     if (!fileList.length) return;

     // append the files to FormData
     Array
       .from(Array(fileList.length).keys())
       .map(x => {
          var formData = new FormData();

           appDocumentos.gerarTumb(fileList[x],x);
            formData.append(fieldName, fileList[x]);


         if(enviar){

           appDocumentos.uploadDocumento(formData);

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

              appDocumentos.listarDocumentos();

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
          console.log(response);
          appDocumentos.listarGrupos =response.data.lista;

          if(id!=null){

            appDocumentos.listarGrupoDocumento(id);
          }



	      });


	  },
    listarPastasDoc(){
        axios.post(config.dominio+'api/Pastas/listar', {
        }).then(function(response) {
          appDocumentos.listarPastas = response.data;
        });


    },
    listarGrupoDocumento(id_documento){
	      axios.post(config.dominio+'api/GrupoDocumento/listar', {
          id_documento:id_documento
	      }).then(function(response) {



          response.data.lista.forEach((item) => {
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

                    appDocumentos.listThumbnail[id]=urlTumb;

                  });



               });



            });
          });
        }else{

          base64Resize(url,0.3,function(urlTumb) {

            appDocumentos.listThumbnail[id]=urlTumb;

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

              appDocumentos.totalPaginas=pdf.numPages;

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

        appDocumentos.listaArqExcluir.push(id);


      }else {
        const index = appDocumentos.listaArqExcluir.indexOf(id);

        if (index > -1) {
          appDocumentos.listaArqExcluir.splice(index, 1);
        }

        $('ul#doc_'+id).removeClass("active");
      }

  },
    selGrupoDoc() {
      var checked = [];

      $("input[name='id_grupo']:checked").each(function(){ checked.push($(this).val()); });

        appDocumentos.listaSelGrupos=checked;

    },
    desselecionaTudo(){

        $('.docs').removeClass("active");

        $('.docs input').prop('checked', false);

        appDocumentos.listaArqExcluir=[];

      },
    excluirEmMassa(){

              alertify.confirm("Deseja excluir o cadastro?",
                function(){

                  alertify.success('Sucesso ao deletar cadastro!');

                      appDocumentos.listaArqExcluir.forEach(function(item){


                        axios.post(config.dominio+'api/Documentos/excluir', {
                          id: item
                        });


                      });

                      $('.docs').removeClass("active");

                      $('.docs input').prop('checked', false);

                      appDocumentos.listaArqExcluir=[];

                      appDocumentos.listarDocumentos();


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


      if(acao=="anterior"){
        if (appDocumentos.paginaAtual <= 1) {
          return;
        }
        appDocumentos.paginaAtual--;
        appDocumentos.verArquivo(url,target, appDocumentos.paginaAtual);
      } else if(acao=="proximo"){

        if (appDocumentos.paginaAtual >=appDocumentos.totalPaginas) {
          return;
        }
        appDocumentos.paginaAtual++;

        appDocumentos.verArquivo(url,target, appDocumentos.paginaAtual);



      }

    },
    salvarAtividades(msg){

            url = config.dominio+'api/Atividades/incluir';
          axios.post(url, {
            acesso :msg
            });

    },

  },
  created() {
    this.listarDocumentos();

  }


}
var appDocumentos =new Vue(moduloDocumentos);

new Vue({
  el: '#menuDocumento',
  methods: {
      homeDocumentos(){
        appDocumentos.listarDocumentos();
      }

  }
});
