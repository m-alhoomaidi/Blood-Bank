import 'package:flutter/material.dart';

class DonerCardDetails extends StatelessWidget {
  final String bloodTayep;
  final String donerName;
  final String donerCity;
  final String donerPhone;
  const DonerCardDetails({
    Key? key,
    required this.bloodTayep,
    required this.donerName,
    required this.donerCity,
    required this.donerPhone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: Alignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.11,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(1.0),
          // decoration: const BoxDecoration(
          //   color: Colors.redAccent,
          //   borderRadius: BorderRadius.only(
          //     bottomLeft: Radius.circular(20),
          //     bottomRight: Radius.circular(20),
          //   ),
          // ),
          child: Row(
            children: [
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.3,
              //   width: MediaQuery.of(context).size.width * 0.3,
              //   child: Center(
              //     child: CircleAvatar(
              //         backgroundColor: Colors.red,
              //         radius: 40,
              //         child: Text(bloodTayep)),
              //   ),
              // ),
              // const SizedBox(
              //   width: 5,
              // ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  children: [
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Wrap(
                        children: [
                          Text(
                            donerName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    const Spacer(),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Wrap(
                        children: [
                          const Text(
                            "من منطقة",
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(" - "),
                          Text(donerCity,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    // const Spacer(),
                    // Align(
                    //   alignment: Alignment.topRight,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       const Icon(
                    //         Icons.phone,
                    //         size: 30,
                    //       ),
                    //       SizedBox(
                    //         width: MediaQuery.of(context).size.width * 0.2,
                    //       ),
                    //       const Icon(
                    //         Icons.message,
                    //         size: 30,
                    //       )
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
        // AnimatedPadding(
        //   padding: EdgeInsets.only(top: 150, bottom: 0.0),
        //   duration: Duration(milliseconds: 1000),
        //   curve: Curves.fastLinearToSlowEaseIn,
        //   child: cardItem(onTap: () {}),
        // ),
      ],
    );
  }
}

class cardItem extends StatelessWidget {
  final onTap;
  const cardItem({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        height: 220,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color(0xffFF6594).withOpacity(0.2), blurRadius: 25),
            ],
            color: Colors.white.withOpacity(1.0),
            borderRadius: BorderRadius.all(Radius.circular(30))),
      ),
    );
  }
}
