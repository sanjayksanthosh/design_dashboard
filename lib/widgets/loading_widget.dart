import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(20)),
      child: Center(child: 
    
                  Lottie.asset('assets/lotties/loadingAnimation.json'),
    
    ),);
  }
}