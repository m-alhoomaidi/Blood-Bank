import 'package:flutter/material.dart';

class DonerCardBody extends StatelessWidget {
  const DonerCardBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Padding(
          padding: EdgeInsets.only(bottom: 12.0),
          child: Text("data"),
        ),
        Text("tayeb"),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
