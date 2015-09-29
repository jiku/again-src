#   React.render(<Player />, document.getElementById("player"))
#
# Player = React.createClass
#   PlayButton: =>
#     className={String}
#     playing={Boolean}
#     seeking={Boolean}
#     # seekingIcon={ReactElement}
#     # optional icon that will be showed when track is seeking new position to play
#     onTogglePlay={Function}
#     # soundCloudAudio={instanceof SoundCloudPlayer}
#     soundCloudAudio={SoundCloudPlayer}
#
#   render: ->
#     <div id="react-soundplayer">
#       {@PlayButton()}
#     </div>
