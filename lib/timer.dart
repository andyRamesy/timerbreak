import "dart:async";
import "./timermodel.dart";
import "package:shared_preferences/shared_preferences.dart";

class CountDownTimer {
  double _radius = 1;
  bool _isActive = true;
  late Timer timer;
  late Duration _time;
  late Duration _fullTime;
  int work = 0;
  get percent => _radius;
  Duration get time => _time;
  int shortBreak = 5;
  int longBreak = 20;
  String _currentTimerType = 'work';

//he asterisk (*) after async isused to say that a Stream is being returned
  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (int a) {
      String time;
      if (_isActive) {
        _time = _time - const Duration(seconds: 1);
        _radius = _time.inSeconds / _fullTime.inSeconds;
        if (_time.inSeconds <= 0) {
          _isActive = false;
        }
      }
      time = returnTime(_time);
      return TimerModel(time, _radius);
    });
  }

  //function formating the time
  String returnTime(Duration t) {
    String minutes =
        (t.inMinutes < 60) ? '${t.inMinutes}' : t.inMinutes.toString();
    int numSeconds = t.inSeconds - (t.inMinutes * 60);
    String seconds = (numSeconds < 10) ? "0$numSeconds" : numSeconds.toString();
    String formatedTime = "$minutes:$seconds";
    return formatedTime;
  }

  void startWork() async {
    await readSettings();
    _currentTimerType = 'work';
    _radius = 1;
    _time = Duration(minutes: work, seconds: 0);
    _fullTime = _time;
  }

  void restart() async {
    await readSettings();
    _radius = 1;
    _isActive = true;
    switch (_currentTimerType) {
      case 'work':
        _time = Duration(minutes: work, seconds: 0);
        break;
      case 'shortBreak':
        _time = Duration(minutes: shortBreak, seconds: 0);
        break;
      case 'longBreak':
        _time = Duration(minutes: longBreak, seconds: 0);
        break;
    }
    _fullTime = _time;
  }

  void stopTimer() {
    _isActive = false;
  }

  void startTimer() async {
    await readSettings();
    if (_time.inSeconds > 0) _isActive = true;
  }

  void startBreak(bool isShort) async {
    await readSettings();
    _currentTimerType = isShort ? 'shortBreak' : 'longBreak';
    _radius = 1;
    _time = Duration(minutes: (isShort) ? shortBreak : longBreak, seconds: 0);
    _fullTime = _time;
  }

  Future readSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    work = (prefs.getInt("workTime") == null ? 30 : prefs.getInt("workTime"))!;
    shortBreak =
        (prefs.getInt("shortBreak") == null ? 30 : prefs.getInt("shortBreak"))!;
    longBreak =
        (prefs.getInt("longBreak") == null ? 30 : prefs.getInt("longBreak"))!;
    print("long break in timer ${prefs.getInt("LONGBREAK")}");
  }
}
