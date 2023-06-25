import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class StartGame extends StatefulWidget {
  const StartGame({super.key});

  @override
  State<StartGame> createState() => _StartGameState();
}

class _StartGameState extends State<StartGame> {
  late AssetsAudioPlayer audioPlayer;
  bool isMusicPlaying = true;
  bool isDialogVisible = false;
  void playBackgroundMusic() {
    audioPlayer.open(
      Audio('assets/audio/lofi-ambient-pianoline-03-116136.mp3'),
      showNotification: false,
      loopMode: LoopMode.single,
    );
  }

  void toggleBackgroundMusic() {
    if (!isDialogVisible) {
      if (isMusicPlaying) {
        audioPlayer.pause();
      } else {
        audioPlayer.play();
      }
      setState(() {
        isMusicPlaying = !isMusicPlaying;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image(
              image: AssetImage(
                  "assets/images/pexels-constantin-dorin-adrian-3611882.jpg"),
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 20,
              left: 10,
              child: Container(
                child: Opacity(
                  opacity: 0.5,
                  child: Image(
                    image: AssetImage(
                      "assets/images/logo-no-background.png",
                    ),
                    width: 300,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 10,
              child: IconButton(
                icon: Icon(isMusicPlaying ? Icons.volume_up : Icons.volume_off),
                color: Color(0xff5a0587),
                onPressed: toggleBackgroundMusic,
              ),
            ),
            Positioned(
              top: 200,
              right: 16,
              child: Container(
                child: Opacity(
                  opacity: 0.7,
                  child: Image(
                    image: AssetImage(
                      "assets/images/5210980-removebg-preview.png",
                    ),
                    width: 300,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
