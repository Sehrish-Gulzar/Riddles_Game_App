import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'End_Score_Screen.dart';

class RiddleGamePage extends StatefulWidget {
  @override
  _RiddleGamePageState createState() => _RiddleGamePageState();
}

class _RiddleGamePageState extends State<RiddleGamePage> {
  late AssetsAudioPlayer correctPlayer;
  late AssetsAudioPlayer incorrectPlayer;
  late AssetsAudioPlayer audioPlayer;
  bool isMusicPlaying = true;
  bool isDialogVisible = false;
  int currentRiddleIndex = 0;
  int score = 0;
  bool showHint = false;

  List<Riddle> riddles = [
    Riddle(
      question:
          'I speak without a mouth and hear without ears. I have no body, but I come alive with the wind. What am I?',
      answer: 'Echo',
      hint: 'Think about sound and how it travels.',
    ),
    Riddle(
      question:
          'I am taken from a mine, and shut up in a wooden case, from which I am never released, and yet I am used by almost every person. What am I?',
      answer: 'Pencil ',
      hint: 'It is commonly used for writing and drawing.',
    ),
    Riddle(
      question: 'What has keys but can\'t open locks?',
      answer: 'Piano',
      hint: 'It produces musical notes when played.',
    ),
    Riddle(
      question: 'What can travel around the world while staying in a corner?',
      answer: 'Stamp',
      hint: 'It is often found on envelopes and mail.',
    ),
    Riddle(
      question:
          " woh kosni cheez hy jisy khaany sy insaan tandrust hojata hy or agar wohi cheez insaan ko lag jye toh insaan marr jata hy",
      answer: 'Goli',
      hint: '',
    ),
  ];

  TextEditingController answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    correctPlayer = AssetsAudioPlayer();
    incorrectPlayer = AssetsAudioPlayer();
    audioPlayer = AssetsAudioPlayer();
    playBackgroundMusic();
    shuffleRiddles();
  }

  void showEndGamePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EndGamePage(
          score: score,
          riddles: riddles,
        ),
      ),
    );
  }

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

  void playCorrectSoundEffect() {
    correctPlayer.open(
      Audio('assets/audio/notification-1-126509.mp3'),
      showNotification: false,
    );
  }

  void playIncorrectSoundEffect() {
    incorrectPlayer.open(
      Audio('assets/audio/wrong-47985.mp3'),
      showNotification: false,
    );
  }

  void dispose() {
    audioPlayer.dispose();
    correctPlayer.dispose();
    incorrectPlayer.dispose();
    super.dispose();
  }

  void checkAnswer(String userAnswer) {
    String lowercaseUserAnswer = userAnswer.toLowerCase();
    String lowercaseCorrectAnswer =
        riddles[currentRiddleIndex].answer.toLowerCase();

    setState(() {
      isDialogVisible = true;
    });

    if (lowercaseUserAnswer == lowercaseCorrectAnswer) {
      setState(() {
        score++;
        answerController.clear();
        riddles[currentRiddleIndex].isCompleted =
            true; // Mark riddle as completed
      });
      if (currentRiddleIndex == riddles.length - 1) {
        showEndGamePage();
      }
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Correct!'),
          content: Text('You got it right!'),
          actions: [
            TextButton(
              child: Text('Next'),
              onPressed: () {
                setState(() {
                  currentRiddleIndex++;
                  isDialogVisible = false; // Reset dialog visibility flag
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
      playCorrectSoundEffect();
    } else {
      // Incorrect answer
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Incorrect'),
          content: Text('You got it wrong. Try again!'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                setState(() {
                  answerController.clear();
                  isDialogVisible = false; // Reset dialog visibility flag
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
      playIncorrectSoundEffect();
    }
  }

  void showNextRiddle() {
    int nextRiddleIndex = (currentRiddleIndex + 1) % riddles.length;

    while (nextRiddleIndex != currentRiddleIndex &&
        riddles[nextRiddleIndex].isCompleted) {
      nextRiddleIndex = (nextRiddleIndex + 1) % riddles.length;
    }

    if (nextRiddleIndex == currentRiddleIndex) {
      showEndGamePage();
    } else {
      setState(() {
        currentRiddleIndex = nextRiddleIndex;
        answerController.clear();
        showHint = false;
      });
    }
  }

  void shuffleRiddles() {
    riddles.shuffle();
  }

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
            Padding(
              padding: const EdgeInsets.only(
                  top: 50.0, bottom: 16, left: 16, right: 16),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        height: 250,
                        child: Card(
                          shadowColor: Color(0xff5a0587),
                          color: Colors.transparent,
                          elevation: 2,
                          // Adjust the value to control the shadow intensity
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                              bottomLeft: Radius.circular(40),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                textAlign: TextAlign.center,
                                riddles[currentRiddleIndex].question,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Center(
                          child: Card(
                            shadowColor: Colors.grey,
                            color: Colors.transparent,
                            elevation: 1,
                            child: TextField(
                              controller: answerController,
                              onChanged: (value) {
                                setState(() {});
                              },
                              onSubmitted: (value) {
                                if (answerController.text.isNotEmpty) {
                                  checkAnswer(answerController.text);
                                }
                              },
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff5a0587)),
                                ),
                                hintText: 'Your Answer',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff5a0587),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          onPressed: answerController.text.isNotEmpty
                              ? () => checkAnswer(answerController.text)
                              : null,
                          child: Text('Submit Answer'),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Card(
                                child: Center(
                                  child: Text(
                                    'Score: $score',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                shadowColor: Color(0xff5a0587),
                                color: Colors.transparent,
                                elevation: 2,
                                // Adjust the value to control the shadow intensity
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                  ),
                                ),
                              ),
                              height: 50,
                              width: 100,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff5a0587),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  showHint = true;
                                });
                              },
                              child: Text('Hint'),
                            ),
                            Container(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff5a0587),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                onPressed: showHint ? showNextRiddle : null,
                                child: Text('Skip Riddle'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (showHint) ...[
                        SizedBox(height: 16),
                        Container(
                          child: Text(
                            'Hint: ${riddles[currentRiddleIndex].hint}',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ],
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

class Riddle {
  final String question;
  final String answer;
  final String hint;
  bool isCompleted; // New property

  Riddle({
    required this.question,
    required this.answer,
    required this.hint,
    this.isCompleted = false, // Set default value to false
  });
}
