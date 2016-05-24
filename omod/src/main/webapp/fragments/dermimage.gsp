<%
    ui.includeJavascript("dermimage", "jquery.webcam.min.js")
%>

<style type="text/css">
#webcam, #canvas {
    width: 320px;
    border:20px solid #333;
    background:#eee;
    -webkit-border-radius: 20px;
    -moz-border-radius: 20px;
    border-radius: 20px;
}

#webcam {
    position:relative;
    margin-top:50px;
    margin-bottom:50px;
}

#webcam > span {
    z-index:2;
    position:absolute;
    color:#eee;
    font-size:10px;
    bottom: -16px;
    left:152px;
}

#webcam > img {
    z-index:1;
    position:absolute;
    border:0px none;
    padding:0px;
    bottom:-40px;
    left:89px;
}

#webcam > div {
    border:5px solid #333;
    position:absolute;
    right:-90px;
    padding:5px;
    -webkit-border-radius: 8px;
    -moz-border-radius: 8px;
    border-radius: 8px;
    cursor:pointer;
}

#webcam a {
    background:#fff;
    font-weight:bold;
}

#webcam a > img {
    border:0px none;
}

#canvas {
    border:20px solid #ccc;
    background:#eee;
}

#flash {
    position:absolute;
    top:0px;
    left:0px;
    z-index:5000;
    width:100%;
    height:500px;
    background-color:#c00;
    display:none;
}

object {
    display:block; /* HTML5 fix */
    position:relative;
    z-index:1000;
}

</style>
<script>
    var jq = jQuery;
   jq(document).ready(function() {
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
		<h3>PATIENT IMAGE</h3>
	</div>
    <!-- Canvas -->
    <canvas id="myCanvas" width="320" height="240" style="border:1px solid #000000;">
    </canvas>

    <!-- Temp -->
    <div id="webcam"></div>
    <div id="canvas"></div>

    <!-- Buttons -->
    <a class="button" id="but_capture">
        <i class="icon-camera"></i>
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