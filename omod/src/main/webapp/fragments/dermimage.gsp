<%
    ui.includeJavascript("dermimage", "jpeg_camera_with_dependencies.min.js")
%>
<script>
    var jq = jQuery;
</script>

<div id="dermimage-main" class="info-section dermimage">
	<div class="info-header">
		<i class="icon-picture"></i>
		<h3>PATIENT IMAGE</h3>
	</div>
    <!-- Canvas -->
    <canvas id="myCanvas" width="320" height="240" style="border:1px solid #000000;">
    </canvas>

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