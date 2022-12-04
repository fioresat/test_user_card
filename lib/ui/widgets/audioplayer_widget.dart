import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../consts/images.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioasset;

  const AudioPlayerWidget({
    Key? key,
    required this.audioasset,
  }) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  AudioPlayer player = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    setAudio();
    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future<void> _play() async {
    if (isPlaying) {
      await player.pause();
    } else {
      await player.resume();
    }
  }

  Future setAudio() async {
    player.setSourceAsset(widget.audioasset);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _play();
      },
      child: !isPlaying
          ? Image.asset(imagePlayButton)
          : const Icon(Icons.motion_photos_paused_rounded,
              color: Color(0xffFE8068), size: 50),
    );
  }
}
