import 'dart:async';
import 'dart:math';
import 'package:coding_problem/ui/widget/countdown_painter.dart';
import 'package:coding_problem/ui/widget/my_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  late SharedPreferences _prefs;
  int _countdown = 5;
  late Timer _timer;
  int _currentSecond = 0;
  int _randomNumber = 0;
  int _attempts = 0;
  String? _errorMessage;
  bool _started = false;
  bool _successAlreadyAchieved = false;

  void _updateNumbers() {
    _currentSecond = DateTime.now().second % 60;
    _randomNumber = Random().nextInt(60);
  }

  @override
  void initState() {
    super.initState();
    _randomNumber = 1;
    _currentSecond = 0;
    _attempts = 0;
    _initPrefs();
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0 && _message != "Success :)") {
          _countdown--;
          _successAlreadyAchieved = false;
        } else if (_message == "Success :)") {
          _timer.cancel();
        } else {
          _countdown = 0;
          _timer.cancel();
          _showTimeoutErrorMessage();
        }
      });
    });
    _started = true;
  }

  void _onSuccess() {
    if (!_successAlreadyAchieved) {
      setState(() {
        _successfulAttempts++;
        _message = "Success :)";
        _containerColor = Colors.green;
        _successAlreadyAchieved = true; // Set flag to true
      });
    }
  }

  void _showTimeoutErrorMessage() {
    setState(() {
      _errorMessage =
          'Sorry! timeout and one attempt is considered for failure as penalty.';
    });
  }

  void _onFailure() {
    setState(() {
      _message = "Sorry, try again!";
      _containerColor = Colors.orangeAccent;
    });
  }

  void _resetCountdown() {
    setState(() {
      _countdown = 5;
      _errorMessage = null;
    });
    _timer.cancel();
    _startCountdown();
  }

  Color _containerColor = Colors.orangeAccent;
  String _message = "Click to Start";
  int _successfulAttempts = 0;

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _countdown = _prefs.getInt('countdown') ?? 5;
      _attempts = _prefs.getInt('attempts') ?? 0;
      _successfulAttempts = _prefs.getInt('successfulAttempts') ?? 0;
    });
  }

  void _fullReset() {
    setState(() {
      _countdown = 5;
      _currentSecond = 0;
      _randomNumber = 0;
      _attempts = 0;
      _errorMessage = null;
      _started = false;
      _successAlreadyAchieved = false;
      _containerColor = Colors.orangeAccent;
      _message = "Click to Start";
      _successfulAttempts = 0;
    });
    _timer.cancel();

  }

  Future<void> _saveData() async {
    await _prefs.setInt('countdown', _countdown);
    await _prefs.setInt('attempts', _attempts);
    await _prefs.setInt('successfulAttempts', _successfulAttempts);
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (_errorMessage != null) {
      content = Container(
        width: 325.w,
        height: 100.h,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Center(
          child: Text(
            _errorMessage!,
            style: TextStyle(color: Colors.white, fontSize: 22.sp),
          ),
        ),
      );
    } else {
      if (_started) {
        if (_currentSecond == _randomNumber) {
          _onSuccess();
        } else {
          _onFailure();
        }
      }
      if (!_started) {
        _containerColor = Colors.blue;
      }
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.w, top: 10.h),
            child: Text(
              _message,
              style: GoogleFonts.poppins(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            height: 0.5.h,
            color: Colors.black,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.w, top: 10.h),
            child: Text(
              _currentSecond == _randomNumber
                  ? " Score: $_successfulAttempts/$_attempts"
                  : "Attempts: $_attempts",
              style: GoogleFonts.poppins(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
        ],
      );
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.only(top: 22.h),
              child: PopupMenuButton(color: Colors.white,
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: Container(
                        width: 80.w,
                        height: 40.h,
                        child: Row(
                          children: [
                            Icon(Icons.refresh),
                            SizedBox(width: 5.0),
                            Text('Full Reset'),
                          ],
                        ),
                      ),
                      onTap: () {
                        _fullReset();
                      },
                    ),
                  ];
                },
              ),
            ),
          ],
          title: Padding(
            padding: EdgeInsets.only(top: 25.h),
            child: Text('TimeTap Challenge',
                style: GoogleFonts.aboreto(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
          ),
          flexibleSpace: ClipPath(
            clipper: MyClipper(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Colors.purple,
                    Colors.blue,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 12.w, top: 20.h),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueAccent.withOpacity(0.2),
                  ),
                  width: 170.w,
                  height: 120.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.w, top: 30.h),
                        child: Text(
                          "Current Second",
                          style: GoogleFonts.poppins(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        height: 0.5.h,
                        color: Colors.black,
                      ),
                      SizedBox(height: 10.h),
                      Center(
                        child: Text(
                          "$_currentSecond",
                          style: GoogleFonts.poppins(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.purpleAccent.withOpacity(0.2),
                  ),
                  width: 170.w,
                  height: 120.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.w, top: 30.h),
                        child: Text(
                          "Random Number",
                          style: GoogleFonts.poppins(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        height: 0.5.h,
                        color: Colors.black,
                      ),
                      SizedBox(height: 10.h),
                      Center(
                        child: Text(
                          "$_randomNumber",
                          style: GoogleFonts.poppins(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 200.w),
              child: Text(
                ' Score: $_successfulAttempts/$_attempts',
                style: TextStyle(color: Colors.black, fontSize: 22.sp),
              ),
            ),
            Container(
              width: 325.w,
              height: 100.h,
              child: content,
              decoration: BoxDecoration(
                boxShadow: kElevationToShadow[4],
                borderRadius: BorderRadius.circular(5),
                color: _errorMessage != null ? Colors.red : _containerColor,
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 62.5.r,
                  backgroundColor: Colors.grey,
                ),
                Container(
                  width: 120.r,
                  height: 120.r,
                  child: CustomPaint(
                    painter: CountdownPainter(
                      count: _countdown,
                      strokeWidth: 5.0,
                      color: Colors.lightGreen,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 58.r,
                  backgroundColor: Colors.white,
                  child: Text("$_countdown",
                      style: GoogleFonts.poppins(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                ),
              ],
            ),
            SizedBox(
              height: 50.h,
            ),
            GestureDetector(
              onTap: () {
                if (!_started) {
                  _startCountdown();
                }
                setState(() {
                  _attempts++;
                });
                _updateNumbers();
                _resetCountdown();
                _saveData();
              },
              child: Container(
                  width: 125.w,
                  height: 41.h,
                  child: Center(
                    child: Text("Click",
                        style: GoogleFonts.poppins(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                  ),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red.withOpacity(0.8))),
            ),
          ],
        ),
      ),
    );
  }
}

