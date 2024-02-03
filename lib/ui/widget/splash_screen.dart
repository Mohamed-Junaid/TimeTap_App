import 'package:coding_problem/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), ()async {
      Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Home()),
                (route) => false);

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/122.jpg',
              fit: BoxFit.cover,
            ),
          ),Center(child:
          Padding(
            padding: EdgeInsets.only(top: 150.h),
            child: Text('Welcome',
              style: TextStyle(fontSize: 30.sp,
                color: Colors.white,
                  fontWeight: FontWeight.w700),),
          ))
        ],
      )

    );
  }
}
