import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LedsScreen extends StatefulWidget {
  LedsScreen({Key? key}) : super(key: key);

  @override
  State<LedsScreen> createState() => _LedsScreenState();
}

class _LedsScreenState extends State<LedsScreen> {
  String nodeUri = "http://192.168.4.1/";
  bool redButtonPressed = false;
  bool greenButtonPressed = false;
  bool blueButtonPressed = false;
  bool redLedOff = true;
  bool greenLedOff = true;
  bool blueLedOff = true;

  Key? key;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'LED controller',
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _redButtonPressed();
                if (redLedOff) {
                  _turnOnLed('red');
                  setState(() {
                    redLedOff = !redLedOff;
                  });
                } else {
                  _turnOffLed('red');
                  setState(() {
                    redLedOff = !redLedOff;
                  });
                }
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                width: 160,
                height: 160,
                child: Icon(
                  Icons.lightbulb_rounded,
                  size: 60,
                  color: redButtonPressed ? Colors.red[200] : Colors.red,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: redButtonPressed
                        ? Colors.grey.shade200
                        : Colors.grey.shade300,
                  ),
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: redButtonPressed
                      ? []
                      : [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            offset: Offset(6, 6),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-6, -6),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                        ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                _greenButtonPressed();
                if (greenLedOff) {
                  _turnOnLed('green');
                  setState(() {
                    greenLedOff = !greenLedOff;
                  });
                } else {
                  _turnOffLed('green');
                  setState(() {
                    greenLedOff = !greenLedOff;
                  });
                }
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                width: 160,
                height: 160,
                child: Icon(
                  Icons.lightbulb_rounded,
                  size: 60,
                  color: greenButtonPressed ? Colors.green[200] : Colors.green,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: greenButtonPressed
                        ? Colors.grey.shade200
                        : Colors.grey.shade300,
                  ),
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: greenButtonPressed
                      ? []
                      : [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            offset: Offset(6, 6),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-6, -6),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                        ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                _blueButtonPressed();
                if (blueLedOff) {
                  _turnOnLed('blue');
                  setState(() {
                    blueLedOff = !blueLedOff;
                  });
                } else {
                  _turnOffLed('blue');
                  setState(() {
                    blueLedOff = !blueLedOff;
                  });
                }
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                width: 160,
                height: 160,
                child: Icon(
                  Icons.lightbulb_rounded,
                  size: 60,
                  color: blueButtonPressed ? Colors.blue[200] : Colors.blue,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: blueButtonPressed
                        ? Colors.grey.shade200
                        : Colors.grey.shade300,
                  ),
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: blueButtonPressed
                      ? []
                      : [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            offset: Offset(6, 6),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-6, -6),
                            blurRadius: 15,
                            spreadRadius: 1,
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

  void _turnOnLed(String color) async {
    String ledParam = "";

    switch (color) {
      case "red":
        ledParam = "red_on";
        break;

      case "green":
        ledParam = "green_on";
        break;

      case "blue":
        ledParam = "blue_on";
        break;
      default:
        print("Invalid led!");
        return;
    }

    http.Response r = await http.get(Uri.parse(nodeUri + ledParam));

    print(Uri.parse(nodeUri + ledParam));

    if (r.statusCode == 200) {
      print(r.body);
    } else {
      print(r.body);
    }
  }

  void _turnOffLed(String color) async {
    String ledParam = "";

    switch (color) {
      case "red":
        ledParam = "red_off";
        break;

      case "green":
        ledParam = "green_off";
        break;

      case "blue":
        ledParam = "blue_off";
        break;
      default:
        print("Invalid led!");
        return;
    }

    http.Response r = await http.get(Uri.parse(nodeUri + ledParam));
    if (r.statusCode == 200) {
      print(r.body);
    } else {
      print(r.body);
    }
  }

  void _redButtonPressed() {
    if (redButtonPressed == false) {
      setState(() {
        redButtonPressed = true;
      });
    } else if (redButtonPressed == true) {
      setState(() {
        redButtonPressed = false;
      });
    }
  }

  void _greenButtonPressed() {
    if (greenButtonPressed == false) {
      setState(() {
        greenButtonPressed = true;
      });
    } else if (greenButtonPressed == true) {
      setState(() {
        greenButtonPressed = false;
      });
    }
  }

  void _blueButtonPressed() {
    if (blueButtonPressed == false) {
      setState(() {
        blueButtonPressed = true;
      });
    } else if (blueButtonPressed == true) {
      setState(() {
        blueButtonPressed = false;
      });
    }
  }
}
