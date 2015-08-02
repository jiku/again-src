Template.soundcloud.rendered = function()
{
  (function() {
    var AudioContext;
    var audio;
    var audioContext;
    var source;
    var streamUrl;

    function initAudio() {
      AudioContext = window.AudioContext || window.webkitAudioContext;
      audio = new Audio();
      audio.crossOrigin = "anonymous";
      audioContext = new AudioContext();
      source = audioContext.createMediaElementSource(audio);
      source.connect(audioContext.destination);

      audio.src = streamUrl;
      audio.play();
    };

    function get(url, callback) {
      var request = new XMLHttpRequest();
      request.onreadystatechange = function() {
        if (request.readyState === 4 && request.status === 200) {
          callback(request.responseText);
        }
      }

      request.open("GET", url, true);
      request.send(null);
    }

    var clientParameter = "client_id=3b2585ef4a5eff04935abe84aad5f3f3"
    var trackPermalinkUrl = "https://soundcloud.com/jiku/priss";

    function findTrack() {
      get("http://api.soundcloud.com/resolve.json?url=" +  trackPermalinkUrl + "&" + clientParameter, function (response) {
        var trackInfo = JSON.parse(response);
        streamUrl = trackInfo.stream_url + "?" + clientParameter;
        initAudio();
      });
    };

    findTrack();
  })();
}
