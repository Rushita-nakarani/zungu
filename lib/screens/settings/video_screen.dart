import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:zungu_mobile/utils/custom_extension.dart';

import '../../constant/string_constants.dart';
import '../../widgets/no_content_label.dart';

class VideoShowingScreen extends StatefulWidget {
  final String videoUrl;
  const VideoShowingScreen({super.key, required this.videoUrl});

  @override
  State<VideoShowingScreen> createState() => _VideoShowingScreenState();
}

class _VideoShowingScreenState extends State<VideoShowingScreen> {
  //----------------------------Variables-----------------------------//

  // Chewie Controller
  ChewieController? _chewieController;
  YoutubePlayerController? _youtubeController;

  //Currrent Index int
  int currentIndex = 0;
  bool isYoutube = false;

  Orientation _orientation = Orientation.portrait;

  @override
  void initState() {
    super.initState();
    isYoutube = widget.videoUrl.isYoutubeLink;
    if (isYoutube) {
      _youtubeController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl) ?? "",
        flags: const YoutubePlayerFlags(
          mute: true,
        ),
      );
    } else {
      _chewieController = ChewieController(
        videoPlayerController: VideoPlayerController.network(widget.videoUrl),
        aspectRatio: 6 / 5,
        autoInitialize: true,
        autoPlay: true,
        // cupertinoProgressColors: ChewieProgressColors(
        //   playedColor: Colors.blue,
        //   bufferedColor: Colors.grey,
        //   handleColor: Colors.lightBlue,
        //   backgroundColor: Colors.grey.shade50,
        // ),
        // materialProgressColors: ChewieProgressColors(
        //   playedColor: Colors.blue,
        //   bufferedColor: Colors.grey,
        //   handleColor: Colors.lightBlue,
        //   backgroundColor: Colors.grey.shade50,
        // ),
        errorBuilder: (context, errorMessage) {
          return NoContentLabel(title: errorMessage);
        },
      );
    }
    // _playVideo();
  }

  @override
  void dispose() {
    super.dispose();
    if (isYoutube) {
      _youtubeController?.dispose();
    } else {
      _chewieController?.dispose();
      _chewieController?.videoPlayerController.dispose();
    }
  }

  //----------------------------UI-----------------------------//

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          _orientation = orientation;
          if (_orientation == Orientation.landscape) {
            return Scaffold(
              body: _buildBody(),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(title: const Text(StaticString.videoPlayers)),
              body: _buildBody(),
            );
          }
        },
      ),
    );
    // return StatusbarContentStyle(
    //   statusbarContentColor: StatusbarContentColor.Black,
    //   child: Scaffold(
    //     appBar: AppBar(title: const Text(StaticString.videoPlayers)),
    //     body: _buildBody(),
    //   ),
    // );
  }
  //----------------------------Widgets-----------------------------//

  // Body
  Widget _buildBody() {
    return SafeArea(
      child: isYoutube
          ? YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _youtubeController!,
                showVideoProgressIndicator: true,
                topActions: [
                  if (_orientation == Orientation.landscape)
                    IconButton(
                      onPressed: () {
                        _youtubeController?.toggleFullScreenMode();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
              builder: (context, player) {
                return Column(
                  children: [
                    player,
                  ],
                );
              },
            )
          : Chewie(
              controller: _chewieController!,
            ),
    );
  }
}
