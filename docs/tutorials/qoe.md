<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Measuring video quality for video streaming applications</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

<h3 class="small-subtitle" id="qoe">QoE testing with EUS</h3>

Quality of Experience <a href="https://en.wikipedia.org/wiki/Quality_of_experience" target="_blank" title="QoE">(QoE)</a> is a measure of the delight or annoyance of a customer's experiences with a service. EUS offers an api for calculating QoE metrics for video, which is very useful for testing quality in videoconferencing applications such as <a href="https://openvidu.io/" target="_blank">OpenVidu</a>.

The QoE test offered by EUS consists of the comparison of two videos: the first video would be the original video published by an endpoint and the second the video received through that endpoint. This comparison generates several csv with different quality metrics. You can take a look at these <a href="https://github.com/elastest/elastest-webrtc-qoe-meter/blob/master/data/openvidu_objective_results_10%25_packet_loss.csv" target="_blank">example results</a>.

This functionality is available since version 2.1.0 of ElasTest, and a <a href="/docs/demos/qoe" target="_blank">sample demo project</a> is included. Is only available in elastest mini and siglenode modes, for Docker and <a target="_blank" href="/docs/tutorials/using-browsers-in-elastest/#browsersInAWS">AWS</a>. For Kubernetes (EK and HEK) is not available yet

In order to calculate qoe metrics, it is **necessary** that the videos to be processed (original video + received video) have a **padding at the beginning and at the end**. For this you can use <a href="https://github.com/elastest/elastest-webrtc-qoe-meter/blob/master/scripts/generate_input_video.sh" target="_blank">this script</a>. It is recommended to set a padding of at least 12 seconds, replacing the default value of the variable PADDING_DURATION_SEC (5).

Once you have obtained the original video (.y4m) and audio (.wav) with padding (two files are generated automatically), you must **include it as a fake resource capability** in your test, so that instead of showing the video from the camera this video is used.

```
    ChromeOptions options = new ChromeOptions();
    // This flag avoids to grant the user media
    options.addArguments("--use-fake-ui-for-media-stream");
    // This flag fakes user media with synthetic video
    options.addArguments("--use-fake-device-for-media-stream");
    // This flag allows to load fake media files from host
    options.addArguments("--allow-file-access-from-files");
    // This flag sets the video input (with padding)
    options.addArguments("--use-file-for-fake-video-capture=/path/to/video_with_padding.y4m");
    // This flag sets the audio input
    options.addArguments("--use-file-for-fake-audio-capture=/path/to/audio_with_padding.wav");

```

The browser must be able to access these files. To do this EUS has an **api** to be able to **upload these files** during the execution to the browser container. If the files are accessible from the test you can simply attach them to the call, but you can also have them in an online repository and send the url to the request and the EUS itself download it into the browser container, which is exactly what is done in the above mentioned <a href="/docs/demos/qoe" target="_blank">sample demo project</a>.

To do this, call to the EUS api with path **`/browserfile/session/{sessionId}/`** and the following parameters:

- **fileUrl**: the remote and accesible url where the video is stored.
- **fileName**: the name under which the video will be saved inside the browser container. Should be the same as that defined in **`--use-file-for-fake-video-capture`**
- **filePath**: the path under which the video will be saved inside the browser container. Should be the same as that defined in **`--use-file-for-fake-video-capture`**

Then do the same for the audio file.

To start the test call the EUS api (/session/{sessionId}/webrtc/qoe/meter/start) with the following parameters:

- **presenterPath**: the path of the original video in the container of the browser that emits it.
- **presenterSessionId**: the session id of the browser that broadcasts the original video.
- **viewerPath**: the path of the received video in the container of the browser that receives it.
- **viewerSessionId**: the session id of the browser receiving the broadcast video.

This request is in charge of **initiating the service** that is in charge of calculating the QoE metric, obtaining and passing to this service the videos of the browser containers. Then it executes in the **background the calculation** of the metrics and it will **return the Id of the service** as an answer, so that from the test the EUS can be polled to know the state of the calculation. Once completed, the EUS itself will obtain the **csv generated and attach them** to the execution. It will also calculate the **average of each metric and attach** it.
