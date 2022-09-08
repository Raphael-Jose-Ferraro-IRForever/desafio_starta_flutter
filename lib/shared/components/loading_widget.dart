import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
          width: 300,
          child: RiveAnimation.asset('assets/animations/loader_white.riv',
              animations: ['loop'], fit: BoxFit.fitWidth)),
    );
  }
}
