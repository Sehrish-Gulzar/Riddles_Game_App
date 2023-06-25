import 'package:flutter/material.dart';

import 'main.dart';

class StartGame extends StatefulWidget {
  const StartGame({super.key});

  @override
  State<StartGame> createState() => _StartGameState();
}

class _StartGameState extends State<StartGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
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
            Container(
              child: Opacity(
                opacity: 0.5,
                child: Image(
                  image: AssetImage(
                    "assets/images/5210980-removebg-preview.png",
                  ),
                  width: 300,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 115, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff5a0587),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => RiddleGame()),
                        );
                      },
                      child: Text('Start Game'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
