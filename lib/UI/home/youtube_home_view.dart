// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class YoutubeView extends StatefulWidget {
//   final String url;

//   YoutubeView({this.url});

//   @override
//   _YoutubeViewState createState() => _YoutubeViewState();
// }

// class _YoutubeViewState extends State<YoutubeView> {
//   YoutubePlayerController _controller = null;
//   bool _isPlayerReady = false;
//   PlayerState _playerState;
//   YoutubeMetaData _videoMetaData;

//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController(
//       initialVideoId: widget.url.split('v=')[1],
//       flags: YoutubePlayerFlags(
//         autoPlay: false,
//         loop: true,
//         mute: false,
//         hideControls: true,
//         hideThumbnail: true,
//         controlsVisibleAtStart: false,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     if (_controller != null)
//       _controller.dispose();
//     super.dispose();
//   }
//   void listener() {
//     if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
//       setState(() {
//         _playerState = _controller.value.playerState;
//         _videoMetaData = _controller.metadata;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (){
//         _controller.value.isPlaying
//             ? _controller.pause()
//             : _controller.play();
//         setState(() {});
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: YoutubePlayer(
//           controller: _controller,
//           width: double.infinity,
//           showVideoProgressIndicator: true,
//           progressIndicatorColor: Colors.amber,
//           progressColors: ProgressBarColors(
//             playedColor: Colors.amber,
//             handleColor: Colors.amberAccent,
//           ),
//           onReady: () {
//             _controller.addListener(listener);
//           },
//         ),
//       ),
//     );
//   }
// }
