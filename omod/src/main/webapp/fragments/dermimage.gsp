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
    <!-- Buttons -->
    <a class="button" id="but_capture">
        <i class="icon-camera"></i>
        Capture
    </a>
    <a class="button" id="but_upload">
        <i class="icon-upload-alt"></i>
        Upload
    </a>
    <a class="button" id="but_delete">
        <i class="icon-upload-alt"></i>
        Upload
    </a>
</div>