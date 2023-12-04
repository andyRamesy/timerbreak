import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_break/widget/SettingButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Settings")), body: const Settings());
  }
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextStyle textStyle = const TextStyle(fontSize: 24);
  TextEditingController textWork = TextEditingController();
  TextEditingController textShort = TextEditingController();
  TextEditingController textLong = TextEditingController();
  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  late int workTime;
  late int shortBreak;
  late int longBreak;
  late SharedPreferences prefsData;

  Future<void> _readSettings() async {
    prefsData = await SharedPreferences.getInstance();
    int? workTime = prefsData.getInt(WORKTIME);
    int? shortBreak = prefsData.getInt(SHORTBREAK);
    int? longBreak = prefsData.getInt(LONGBREAK);

    //set value when the app start
    if (workTime == null) await prefsData.setInt(WORKTIME, int.parse("30"));
    if (shortBreak == null) {
      await prefsData.setInt(
          SHORTBREAK, int.parse("5")); //set value when the app start
    }
    if (longBreak == null) {
      await prefsData.setInt(
          LONGBREAK, int.parse("20")); //set value when the app start
    }

    setState(() {
      textWork.text = workTime.toString();
      textShort.text = shortBreak.toString();
      textLong.text = longBreak.toString();
    });
  }

  void updateSettings(String key, int value) {
    switch (key) {
      case WORKTIME:
        int? workTime = prefsData.getInt(WORKTIME);
        if (workTime != null) {
          workTime += value;
          if (workTime >= 1 && workTime <= 180) {
            prefsData.setInt(WORKTIME, workTime);
            setState(() => textWork.text = workTime.toString());
          }
        }
        print("worktime updated");
        break;
      case SHORTBREAK:
        int? short = prefsData.getInt(SHORTBREAK);
        if (short != null) {
          short += value;
          if (short >= 1 && short <= 120) {
            prefsData.setInt(SHORTBREAK, short);
            setState(() {
              textShort.text = short.toString();
            });
          }
        }
        print("shortbreak updated");

        break;
      case LONGBREAK:
        int? long = prefsData.getInt(LONGBREAK);
        if (long != null) {
          long += value;
          if (long >= 1 && long <= 180) {
            prefsData.setInt(LONGBREAK, long);
            setState(() {
              textLong.text = long.toString();
            });
          }
        }
        print(
          "longbreak updated ${prefsData.getInt(LONGBREAK)}",
        );

        break;
      default:
    }
  }

  @override
  void initState() {
    TextEditingController textWork = TextEditingController();
    TextEditingController textShort = TextEditingController();
    TextEditingController textLong = TextEditingController();
    _readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      scrollDirection: Axis.vertical,
      childAspectRatio: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      padding: const EdgeInsets.all(20.0),
      children: <Widget>[
        //Work
        Text(
          "Work",
          style: textStyle,
        ),
        const Text(" "),
        const Text(" "),
        SettingButton(
          color: const Color(0xff455A64),
          text: "-",
          value: -1,
          size: 20,
          callback: updateSettings,
          setting: WORKTIME,
        ),
        TextField(
          style: textStyle,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          controller: textWork,
        ),
        SettingButton(
            color: const Color(0xff009688),
            text: "+",
            value: 1,
            size: 20,
            callback: updateSettings,
            setting: WORKTIME),
        //Short
        Text(
          "Short",
          style: textStyle,
        ),
        const Text(" "),
        const Text(" "),
        SettingButton(
            color: const Color(0xff455A64),
            text: "-",
            value: -1,
            size: 20,
            callback: updateSettings,
            setting: SHORTBREAK),
        TextField(
          style: textStyle,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          controller: textShort,
        ),
        SettingButton(
            color: const Color(0xff009688),
            text: "+",
            value: 1,
            size: 20,
            callback: updateSettings,
            setting: SHORTBREAK),
        //Long
        Text(
          "Long",
          style: textStyle,
        ),
        const Text(" "),
        const Text(" "),
        SettingButton(
            color: const Color(0xff455A64),
            text: "-",
            value: -1,
            size: 20,
            callback: updateSettings,
            setting: LONGBREAK),
        TextField(
          style: textStyle,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          controller: textLong,
        ),
        SettingButton(
            color: const Color(0xff009688),
            text: "+",
            value: 1,
            size: 20,
            callback: updateSettings,
            setting: LONGBREAK),
      ],
    );
  }
}
