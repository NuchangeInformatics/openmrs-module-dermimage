<%
    ui.includeJavascript("dermimage", "webcam.js")
    ui.includeJavascript("dermimage", "jquery.form.js")

    ui.includeJavascript("uicommons", "angular.js")
    ui.includeJavascript("uicommons", "ngDialog/ngDialog.js")
    ui.includeCss("uicommons", "ngDialog/ngDialog.min.css")

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

#progressbox {
    position: relative;
    width: 400px;
    border: 1px solid #ddd;
    padding: 1px;
    border-radius: 3px;
}

#progressbar {
    background-color: lightblue;
    width: 0%;
    height: 20px;
    border-radius: 4px;
}

#percent {
    position: absolute;
    display: inline-block;
    top: 3px;
    left: 48%;
}
</style>

<script>
    var jq = jQuery;
    var image_pointer = 0;
    var folder = "../../moduleServlet/dermimage/DermImageServlet?patId=${patient.id}&image=";
    var filesList = "${listOfFiles}";
    var num_files = ${numberOfFiles};


    // File list
    filesList = filesList.slice(1,-1);
    filesList = filesList.split(",");


    jq(document).ready(function () {

        // Detect if flash fallback has to be forced
        // REF: STACKOVERFLOW 4565112
        // Ref: https://pixlcore.com/read/WebcamJS
        // Ref: https://github.com/jhuckaby/webcamjs
        var flash = false;
        var isChromium = window.chrome,
                winNav = window.navigator,
                vendorName = winNav.vendor,
                isOpera = winNav.userAgent.indexOf("OPR") > -1,
                isIEedge = winNav.userAgent.indexOf("Edge") > -1,
                isIOSChrome = winNav.userAgent.match("CriOS");

        if (window.location.protocol != "https:" && vendorName === "Google Inc." )
            flash = true;

        Webcam.set({
            width: 320,
            height: 240,
            dest_width: 320,
            dest_height: 240,
            image_format: 'png',
            jpeg_quality: 90,
            force_flash: flash
        });
        Webcam.attach( '#webcam' );

        function take_snapshot() {
            Webcam.snap( function(data_uri) {
                //document.getElementById('webcam_result').innerHTML = '<img width="320" height="240" src="'+data_uri+'"/>';
                // Sanitize
                var to_send = data_uri.replace('data:image/png;base64,', '');
                jq.post("${ ui.actionLink("saveWebcam")}", {
                            returnFormat: 'json',
                            patientId: "${patient.id}",
                            type: "data",
                            image: to_send
                        },
                        function (data) {
                            if(data.indexOf("${MESSAGE_SUCCESS}")>=0){
                                jq().toastmessage('showSuccessToast', "Image Saved.");
                                location.reload();
                            }else{
                                jq().toastmessage('showErrorToast', "Error. Please try again");
                            }
                        })
                        .error(function () {
                            jq().toastmessage('showErrorToast', "Error. Try again after page refresh");
                        });
            } );

        }
        ////////////////End of Wecam functions ////////////////////////////////////////

        // Form Upload progressbar begin
        // Ref: simplecodestuffs file-upload-with-progress-bar-using-jquery-in-servlet
        var options = {
            beforeSend : function() {
                jq("#progressbox").show();
                // clear everything
                jq("#progressbar").width('0%');
                jq("#message").empty();
                jq("#percent").html("0%");
            },
            uploadProgress : function(event, position, total, percentComplete) {
                jq("#progressbar").width(percentComplete + '%');
                jq("#percent").html(percentComplete + '%');

                // change message text to red after 50%
                if (percentComplete > 50) {
                    jq("#message").html("<font color='red'>File Upload is in progress</font>");
                }
            },
            success : function() {
                jq("#progressbar").width('100%');
                jq("#percent").html('100%');
            },
            complete : function(response) {
                jq("#message").html("<font color='blue'>Your file has been uploaded!</font>");
                location.reload();
            },
            error : function() {
                jq("#message").html("<font color='red'> ERROR: unable to upload files</font>");
            }
        };
        jq("#UploadForm").ajaxForm(options);
        //Form Upload progressbar end


        jq("#webcam").hide();
        jq("#responds").hide();
        jq("#but_webcam_upload").hide();
        jq("#upload_form").hide();
        jq("#but_delete").hide();


        jq("#but_capture").click(function (e) {
            jq("#webcam").toggle();
            jq("#responds").toggle();
            jq("#patientimg").toggle();
            jq("#but_webcam_upload").toggle();
            jq("#but_upload").toggle();
         });

        jq("#but_webcam_upload").click(function (e) {
            take_snapshot();
            jq("#upload_form").hide();
            jq("#but_capture").click(); //Hide webcam after capture.
        });

        jq("#but_upload").click(function (e) {
            jq("#upload_form").show();
        });

        jq("#but_left").click(function (e) {
            if(image_pointer > 0) image_pointer--;
            jq("#patientimg").attr('src',folder+(filesList[image_pointer]).trim());
            jq("#file_date").text(filesList[image_pointer]);
            jq("#but_delete").show();
        });

        jq("#but_right").click(function (e) {
            if(image_pointer < num_files-1) image_pointer++;
            jq("#patientimg").attr('src', folder+(filesList[image_pointer]).trim());
            jq("#file_date").text(filesList[image_pointer]);
            jq("#but_delete").show();
        });

        jq("#but_delete").click(function (e) {
             jq.post("${ ui.actionLink("deleteImage")}", {
                        returnFormat: 'json',
                        patientId: "${patient.id}",
                        type: "data",
                        image: (filesList[image_pointer]).trim()
                    },
                    function (data) {
                        if(data.indexOf("${MESSAGE_SUCCESS}")>=0){
                            jq().toastmessage('showSuccessToast', "Image Deleted.");
                            location.reload();
                        }else{
                            jq().toastmessage('showErrorToast', "Error. Try again after page refresh");
                        }
                    })
                    .error(function () {
                        jq().toastmessage('showErrorToast', "Error. Try again after page refresh");
                    });
        });

    });
</script>

<div id="dermimage-main" class="info-section dermimage">
    <div class="info-header">
        <i class="icon-picture"></i>

        <h3>CLINICAL IMAGES</h3>
    </div>
    <!-- Canvas  if required
    <canvas id="myCanvas" width="320" height="240" style="border:1px solid #000000;">
    </canvas>
    -->

    <!-- img tag -->
    <div id="file_date"></div>
    <img alt="" id="patientimg" width="320" height="240"
         src="../../ms/uiframework/resource/dermimage/images/blank.png" />


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

    <!-- Upload form -->
    <div id="upload_form">
        <form id="UploadForm" method="post" action="../../moduleServlet/dermimage/DermUploadServlet?patientId=${patient.id}" enctype="multipart/form-data">
            Select Image to upload:
            <input type="file" size="60" id="myfile" name="myfile">
            <!--<input type="hidden" name="patientId" value="${patient.id}" />-->
            <input type="submit" value="Upload" />
            <div id="progressbox">
                <div id="progressbar"></div>
                <div id="percent">0%</div>
            </div>
            <br />
            <div id="message"></div>
        </form>
    </div>
    <!-- Messages -->
    <div id="responds"><small>Click the second (upload) button to capture.</small></div>
</div>
