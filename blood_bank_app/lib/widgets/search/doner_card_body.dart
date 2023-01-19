import 'package:flutter/material.dart';

class DonerCardBody extends StatelessWidget {
  const DonerCardBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        // border: Border(
        //   top: BorderSide(
        //     width: 1,
        //     color: Colors.black38,
        //   ),
        // ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 120,
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
              ),
            ),
            child: const Icon(
              Icons.phone,
              color: Colors.white,
              size: 30,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          Container(
            height: 50,
            width: 120,
            decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
              ),
            ),
            child: const Icon(
              Icons.message,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
