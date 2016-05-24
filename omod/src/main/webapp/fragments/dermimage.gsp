<%
    ui.includeJavascript("dermimage", "jquery.webcam.min.js")
%>

<style type="text/css">
#webcam {
    width: 320px;
    border:5px solid #009384;
    background:#009384;
    -webkit-border-radius: 20px;
    -moz-border-radius: 20px;
    border-radius: 20px;
}

#webcam {
    position:relative;
    margin-top:50px;
    margin-bottom:50px;
}



</style>
<script>
    var jq = jQuery;
   jq(document).ready(function() {
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
        });

       jq("#webcam").webcam({
           width: 320,
           height: 240,
           mode: "callback",
           swffile: "../../ms/uiframework/resource/dermimage/scripts/jscam.swf",
           onTick: function () {
           },
           onSave: function () {
           },
           onCapture: function () {
                webcam.save('${ ui.actionLink("saveWebcam")}');
           },
           debug: function () {
           },
           onLoad: function () {
           }
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
</div>