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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
<<<<<<< HEAD
            const Icon(
              Icons.phone,
              size: 30,
=======
            Container(
              height: 60,
              width: 150,
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: const Icon(
                Icons.phone,
                color: Colors.white,
                size: 30,
              ),
>>>>>>> b474634751f450913173a4c490aab9f2b51f5293
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
<<<<<<< HEAD
            const Icon(
              Icons.message,
              size: 30,
=======
            Container(
              height: 60,
              width: 150,
              decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: const Icon(
                Icons.message,
                color: Colors.white,
                size: 30,
              ),
>>>>>>> b474634751f450913173a4c490aab9f2b51f5293
            ),
          ],
        )
      ],
    );
  }
}
