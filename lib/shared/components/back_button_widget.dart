import 'package:desafio_starta_flutter/utils/colors_util.dart';
import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: ColorsUtil.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(Icons.arrow_back_ios_new_rounded,
          color: ColorsUtil.white, size: 20),
    );
  }
}
