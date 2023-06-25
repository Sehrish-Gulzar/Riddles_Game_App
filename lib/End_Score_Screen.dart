import 'package:flutter/material.dart';

import 'Riddle_Game_Screen.dart';

class EndGamePage extends StatelessWidget {
  final int score;
  final List<Riddle> riddles;

  const EndGamePage({
    required this.score,
    required this.riddles,
  });

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
              color: Colors.black12,
              colorBlendMode: BlendMode.darken,
            ),
            Positioned(
              top: 20,
              left: 16,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
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
                            'Congratulations!',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Card(
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
                            'Your Score: $score/${riddles.length}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff5a0587),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RiddleGamePage()),
                        );
                        Navigator.pop(context);
                      },
                      child: Text('Play Again'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
