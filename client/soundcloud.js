Template.soundcloud.onCreated = Template.soundcloud.created = function() {
  console.log("holy shit why nothing...");
  var onPlay = function(track) {
    console.log('Listening custom event', track); // Should contain what track to play, etc...
    findTrack();
  };
  SoundEvent.on('play', onPlay);
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

    var clientParameter = "client_id=5ae0c6ffd01e8b8580395dd8cfaa1e0f"

    var trackPermalinkUrl = "https://soundcloud.com/jiku/priss";

    function findTrack() {
      get("http://api.soundcloud.com/resolve.json?url=" +  trackPermalinkUrl + "&" + clientParameter, function (response) {
        var trackInfo = JSON.parse(response);
        streamUrl = trackInfo.stream_url + "?" + clientParameter;
        initAudio();
      });
    };

}

Template.soundcloud.onDestroyed = Template.soundcloud.destroyed = function() {
  SoundEvent.removeListener('play', onPlay);
}
