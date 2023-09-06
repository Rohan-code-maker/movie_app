import 'package:flutter/material.dart';

import '../colors.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Container(
      height: mq.height * .07,
      width: mq.width * .07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios_new_rounded),
      ),
    );
  }
}