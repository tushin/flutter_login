import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoBG extends StatefulWidget {
  const VideoBG({
    super.key,
    required this.asset,
    this.opacity = 1.0,
  });

  final String asset;
  final double opacity;

  @override
  State<VideoBG> createState() => _VideoBGState();
}

class _VideoBGState extends State<VideoBG> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.asset)
      ..initialize().then((_) {
        setState(() {
          _controller.setLooping(true);
          _controller.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    final Widget bg;
    if (!_controller.value.isInitialized) {
      bg = Container();
    } else {
      bg = Container(
        color: Colors.yellow,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: _controller.value.size.width,
            height: _controller.value.size.height,
            child: VideoPlayer(_controller),
          ),
        ),
      );
    }


    return Opacity(
      opacity: widget.opacity,
      child: bg,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
