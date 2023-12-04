import "package:flutter/material.dart";
import "package:flutter_break/settingsScreen.dart";
import "package:flutter_break/widget/ProductivityButton.dart";
import "package:percent_indicator/percent_indicator.dart";
import "./timer.dart";
import './timermodel.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My work breaker",
      theme: ThemeData(primarySwatch: Colors.amber),
      home: TimerHomePage(),
    );
  }
}

void emptyMethod() {}

class TimerHomePage extends StatelessWidget {
  final double defaultPadding = 5.0;
  final CountDownTimer timer = CountDownTimer();
  final List<PopupMenuItem<String>> menuItems = [
    const PopupMenuItem(
      value: "Settings",
      child: Text("Settings"),
    )
  ];
  TimerHomePage({super.key});

  void goToSettings(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (builder) => const SettingsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    timer.startWork();
    return Scaffold(
      appBar: AppBar(
        title: const Text("My work breaker"),
        actions: [
          PopupMenuButton(
              itemBuilder: (BuildContext context) => menuItems.toList(),
              onSelected: (value) =>
                  {value == "Settings" ? goToSettings(context) : ""}),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double availableWidth = constraints.maxWidth;
          return Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                      child: ProductivityButton(
                          color: const Color(0xff009688),
                          text: "Work",
                          onPressed: () => timer.startWork())),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                      child: ProductivityButton(
                          color: const Color(0xff607D8B),
                          text: "Short Break",
                          onPressed: () => timer.startBreak(true))),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                      child: ProductivityButton(
                    color: const Color(0xff455A64),
                    size: 50,
                    text: "Long Break",
                    onPressed: () => timer.startBreak(false),
                  )),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                ],
              ),
              Expanded(
                  child: StreamBuilder<dynamic>(
                      initialData: "00:00",
                      stream: timer.stream(),
                      builder: (context, snapshot) {
                        TimerModel timer = (snapshot.data == "00:00")
                            ? TimerModel("00:00", 1)
                            : snapshot.data;
                        return CircularPercentIndicator(
                          radius: availableWidth / 2.5,
                          lineWidth: 10.0,
                          percent: timer.percent,
                          center: Text(
                            timer.time.toString(),
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          progressColor: const Color(0xff009688),
                        );
                      })),
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                      child: ProductivityButton(
                          color: const Color(0xff212121),
                          text: "Stop",
                          onPressed: () => timer.stopTimer())),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                      child: ProductivityButton(
                          color: Color(0xff212121),
                          text: "Restart",
                          onPressed: () => timer.startTimer())),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
