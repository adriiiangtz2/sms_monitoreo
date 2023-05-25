import 'package:flutter/material.dart';
import 'package:monitoreo_sms/theme/app_theme.dart';
import 'package:monitoreo_sms/widgets/widgets.dart';

class AuthLogin extends StatelessWidget {
  final Widget child;
  const AuthLogin({super.key, required this.child});


  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey.shade200,
      child: Stack(
        children: [
          const _TopBox(),
          SafeArea(
              child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 160, ),
            // color: Colors.red,
            child: const Column(
              children:[
                CircleAvatar(
                  maxRadius: 35,
                  backgroundImage: AssetImage('assets/logo.jpg',),
                  
                ),
                Text(
                  "Monitoreo SudSolutions",
                  style: TextStyle(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ],
            ),
          )),
          child ,
              const SizedBox( height: 100 ),
        ],
      ),
    );
  }
}

class _TopBox extends StatelessWidget {
  const _TopBox();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      // color: Colors.red,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -100,
              right: -40,
              child: Circle(
                size: 280,
                colors: [
                  AppTheme.primary,
                  Colors.blue.shade100,
                ],
              )),
          Positioned(
            top: -90,
            left: -40,
            child: Circle(
              size: 200,
              colors: const [
                Color(0xFD3234A2),
                AppTheme.primary,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
