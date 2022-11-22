import 'package:flutter/material.dart';

class DonerCardBody extends StatelessWidget {
  const DonerCardBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.phone,
              size: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
            ),
            const Icon(
              Icons.message,
              size: 30,
            )
          ],
        )
      ],
    );
  }
}
