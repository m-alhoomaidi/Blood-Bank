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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Column(
            children: [
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
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Wrap(
                  children: [
                    const Text(
                      "المنطقة",
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(" - "),
                    Text(donerCity,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// class cardItem extends StatelessWidget {
//   final onTap;
//   const cardItem({super.key, this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 25),
//         height: 220,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//             boxShadow: [
//               BoxShadow(
//                   color: Color(0xffFF6594).withOpacity(0.2), blurRadius: 25),
//             ],
//             color: Colors.white.withOpacity(1.0),
//             borderRadius: BorderRadius.all(Radius.circular(30))),
//       ),
//     );
//   }
// }
