import 'package:flutter/material.dart';
import 'dart:async';
import 'barrier.dart';
import 'bird.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYAxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = 0;
  bool gameHasStarted = false;

  static double barrierXZero = -1;
  double barrierXOne = barrierXZero + 2;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYAxis = initialHeight - height;
        barrierXZero -= 0.05;
        barrierXOne -= 0.05;
      });
      if (birdYAxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
      if (barrierXZero < -2) {
        barrierXZero += 3.5;

      } else {
        barrierXZero -= 0.05;
      }
      if (barrierXOne < -2) {
        barrierXOne += 3.5;
      } else {
        barrierXOne -= 0.05;
      }
    });
  }

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYAxis;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      color: Colors.blue,
                      alignment: Alignment(0, birdYAxis),
                      duration: const Duration(milliseconds: 0),
                      child: const Bird(),
                    ),
                    Container(
                      alignment: const Alignment(0, -0.3),
                      child: gameHasStarted
                          ? const Text('')
                          : const Text(
                              'TAP TO PLAY',
                              style: TextStyle(
                                letterSpacing: 2,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      alignment: Alignment(barrierXZero, 1.1),
                      child: const Barrier(size: 200.0),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      alignment: Alignment(barrierXZero, -1.1),
                      child: const Barrier(size: 150.0),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      alignment: Alignment(barrierXOne, -1.1),
                      child: const Barrier(size: 180.0),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      alignment: Alignment(barrierXOne, 1.1),
                      child: const Barrier(size: 150.0),
                    ),
                  ],
                )),
            Container(
              height: 20,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Score',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 35),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Best',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 35),
                        ),
                      ],
                    )
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
