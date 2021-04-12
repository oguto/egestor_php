function imgload() {
    var pdf = document.getElementById('imgupload');
    var selectedFile = document.getElementById('imgupload').files[0];
    var nombre = selectedFile.name;
    var ext = nombre.split('.').pop();
    if (ext == 'png' || ext == 'jpg' || ext == 'jpeg' || ext == 'gif')
    {
        var img = document.createElement("img");
        // Create a file reader
        var reader = new FileReader();
        // Set the image once loaded into file reader
        reader.onload = function (e) {
            img.src = e.target.result;

            var canvas = document.createElement("canvas");
            //var canvas = $("<canvas>", {"id":"testing"})[0];
            var ctx = canvas.getContext("2d");
            ctx.drawImage(img, 0, 0);

            var MAX_WIDTH = 1800;
            var MAX_HEIGHT = 1200;
            var width = img.width;
            var height = img.height;

            if (width > height) {
                if (width > MAX_WIDTH) {
                    height *= MAX_WIDTH / width;
                    width = MAX_WIDTH;
                }
            } else {
                if (height > MAX_HEIGHT) {
                    width *= MAX_HEIGHT / height;
                    height = MAX_HEIGHT;
                }
            }
            canvas.width = width;
            canvas.height = height;
            var ctx = canvas.getContext("2d");
            ctx.drawImage(img, 0, 0, width, height);

            var dataurl = canvas.toDataURL("image/png");
            document.getElementById("pic").src = dataurl;
        }
        // Load files into file reader
        reader.readAsDataURL(selectedFile);
    }
}
