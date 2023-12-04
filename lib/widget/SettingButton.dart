import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

//typedef can be used as a pointer that references a function
typedef CallbackSsetting = void Function(String, int);

class SettingButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final int value;
  final String setting;
  final CallbackSsetting callback;

  const SettingButton({
    Key? key, // Utilize Key directly here
    required this.color,
    required this.text,
    required this.value,
    required this.size,
    required this.setting,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => callback(setting, value),
      color: color,
      minWidth: size,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
