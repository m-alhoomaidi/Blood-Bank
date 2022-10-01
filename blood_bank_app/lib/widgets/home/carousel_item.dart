import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  const CarouselItem({
    required this.item,
    Key? key,
  }) : super(key: key);
  final String item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.asset(item, fit: BoxFit.cover, width: 1000.0),
          ],
        ),
      ),
    );
  }
}
