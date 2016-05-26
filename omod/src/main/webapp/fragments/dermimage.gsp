<%
    ui.includeJavascript("dermimage", "jquery.webcam.min.js")
%>

<style type="text/css">
#webcam {
    width: 320px;
    border: 5px solid #009384;
    background: #009384;
    -webkit-border-radius: 20px;
    -moz-border-radius: 20px;
    border-radius: 20px;
}

#webcam {
    position: relative;
    margin-top: 50px;
    margin-bottom: 50px;
}



</style>
<h3>${folder} <br>${listOfFiles} <br> ${numberOfFiles}</h3>
<script>
    var jq = jQuery;
    var image_pointer = 0;
    var folder = "${folder}";
    var filesList = "${listOfFiles}";
    var num_files = ${numberOfFiles};
    // File list
    filesList = filesList.slice(1,-1);
    filesList = filesList.split(",");


    //Ref: http://www.williammalone.com/briefs/how-to-draw-image-html5-canvas/
    function drawImage() {
        var context = document.getElementById('myCanvas').getContext("2d");
        var file = folder+'/'+filesList[image_pointer];
        alert(file);
        var img = new Image();
        img.onload = function () {
            context.drawImage(img, 0, 0, 320, 240);
        };
        img.src = file;
    }
    jq(document).ready(function () {

        jq("#webcam").hide();
        jq("#but_webcam_upload").hide();

        jq("#but_capture").click(function (e) {
            jq("#webcam").toggle();
            jq("#myCanvas").toggle();
            jq("#but_webcam_upload").toggle();
            jq("#but_upload").toggle();
        });


        jq("#but_webcam_upload").click(function (e) {
            webcam.capture();
            jq("#but_capture").click();
        });



        jq("#but_left").click(function (e) {
            if(image_pointer > 0) image_pointer--;
            drawImage();
        });

        jq("#but_right").click(function (e) {
            if(image_pointer < num_files) image_pointer++;
            drawImage();
        });

        // Ref: http://www.xarg.org/project/jquery-webcam-plugin/
        jq(function () {
            var pos = 0, ctx = null, saveCB, image = [];

            var canvas = document.createElement("canvas");
            canvas.setAttribute('width', 320);
            canvas.setAttribute('height', 240);

            if (canvas.toDataURL) {

                ctx = canvas.getContext("2d");

                image = ctx.getImageData(0, 0, 320, 240);

                saveCB = function (data) {

                    var col = data.split(";");
                    var img = image;

                    for (var i = 0; i < 320; i++) {
                        var tmp = parseInt(col[i]);
                        img.data[pos + 0] = (tmp >> 16) & 0xff;
                        img.data[pos + 1] = (tmp >> 8) & 0xff;
                        img.data[pos + 2] = tmp & 0xff;
                        img.data[pos + 3] = 0xff;
                        pos += 4;
                    }
                    var to_send = canvas.toDataURL("image/png").replace('data:image/png;base64,', '');
                    if (pos >= 4 * 320 * 240) {
                        ctx.putImageData(img, 0, 0);
                        jq.post("${ ui.actionLink("saveWebcam")}", {
                                    returnFormat: 'json',
                                    patientId: "${patient.id}",
                                    type: "data",
                                    image: to_send
                                },
                                function (data) {
                                    response = data.message;
                                    jQuery("#responds").empty();
                                    jQuery("#responds").append(response);
                                })
                                .error(function () {
                                    //notifyError("Programmer error: delete identifier failed");
                                });
                        pos = 0;
                    }
                };

            } else {

                saveCB = function (data) {
                    image.push(data);

                    pos += 4 * 320;

                    if (pos >= 4 * 320 * 240) {
                        jq.post("${ ui.actionLink("saveWebcam")}", {
                            returnFormat: 'json',
                            patientID: "${patient.id}",
                            type: "pixel",
                            image: image.join('|')
                        });
                        pos = 0;
                    }
                };
            }

            jq("#webcam").webcam({

                width: 320,
                height: 240,
                mode: "callback",
                swffile: "../../ms/uiframework/resource/dermimage/scripts/jscam.swf",

                onSave: saveCB,

                onCapture: function () {
                    webcam.save();
                },

                debug: function (type, string) {
                    console.log(type + ": " + string);
                }
            });

        });

    });
</script>

<div id="dermimage-main" class="info-section dermimage">
    <div class="info-header">
        <i class="icon-picture"></i>

        <h3>CLINICAL IMAGES</h3>
    </div>
    <!-- Canvas -->
    <canvas id="myCanvas" width="320" height="240" style="border:1px solid #000000;">
    </canvas>

    <!-- Web Cam -->
    <div id="webcam"></div>

    <!-- Buttons -->

    <a class="button" id="but_capture">
        <i class="icon-camera"></i>
    </a>
    <a class="button" id="but_webcam_upload">
        <i class="icon-upload-alt"></i>
    </a>
    <a class="button" id="but_upload">
        <i class="icon-upload-alt"></i>
    </a>
    <a class="button" id="but_left">
        <i class="icon-arrow-left"></i>
    </a>
    <a class="button" id="but_right">
        <i class="icon-arrow-right"></i>
    </a>
    <a class="button" id="but_delete">
        <i class="icon-remove"></i>
    </a>

    <!-- Messages -->
    <div id="responds"></div>
</div>