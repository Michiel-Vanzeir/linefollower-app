// ignore_for_file: non_constant_identifier_names
import 'package:joystick/joystick.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Controls extends StatefulWidget {
  const Controls({Key? key}) : super(key: key);

  @override
  _ControlsState createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  bool algorithm_status = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          const Text(
            "Linefollowing algorithm",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 15,
          ),
          ToggleSwitch(
            totalSwitches: 2,
            minWidth: 100,
            minHeight: 60,
            cornerRadius: 20,
            initialLabelIndex: algorithm_status ? 1 : 0,
            activeBgColor:
                algorithm_status ? [Colors.green] : [const Color(0xffF5493D)],
            activeFgColor: Colors.white,
            inactiveBgColor: Colors.grey,
            inactiveFgColor: Colors.black,
            customTextStyles: [
              TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color:
                      algorithm_status ? Colors.grey.shade800 : Colors.white),
              TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color:
                      algorithm_status ? Colors.white : Colors.grey.shade800),
            ],
            labels: const ['OFF', 'ON'],
            iconSize: 25,
            icons: const [Icons.close, Icons.check],
            onToggle: (index) {
              setState(() {
                algorithm_status = index == 1;
                change_linefollower_status(algorithm_status);
              });
            },
          ),
          const SizedBox(
            height: 35,
          ),
          SizedBox(
            width: 200,
            height: 200,
            child: Joystick(
              size: 200,
              isDraggable: false,
              joystickMode: JoystickModes.all,
              iconColor: Colors.white,
              backgroundColor: const Color(0xff084B83),
              opacity: 1,
              onUpPressed: () => motor_control("up"),
              onDownPressed: () => motor_control("down"),
              onLeftPressed: () => motor_control("left"),
              onRightPressed: () => motor_control("right"),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          ElevatedButton.icon(
            icon: const Icon(
              Icons.stop_circle_outlined,
              color: Colors.white,
              size: 30.0,
            ),
            label: const Text(
              'Stop the robot',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              motor_control("stop");
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              primary: const Color(0xffF5493D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void change_linefollower_status(status) async {
  final url =
      Uri.parse('http://192.168.1.44:8080/algorithm_status?status=$status');
  await http.get(url);
}

void motor_control(direction) async {
  double lThrottle = 0.0;
  double rThrottle = 0.0;

  switch (direction) {
    case "up":
      lThrottle = 0.480;
      rThrottle = 0.627692;
      break;
    case "left":
      lThrottle = 0.0;
      rThrottle = 0.627692;
      break;
    case "right":
      lThrottle = 0.480;
      rThrottle = 0.0;
      break;
    case "down":
      lThrottle = -0.480;
      rThrottle = -0.627692;
      break;
    case "stop":
      lThrottle = 0.0;
      rThrottle = 0.0;
      break;
    default:
      lThrottle = 0.0;
      rThrottle = 0.0;
  }

  final url = Uri.parse(
      'http://192.168.1.44:8080/motor_throttle?sender=flutter_app&left_motor=$lThrottle&right_motor=$rThrottle');
  await http.get(url);
}
