import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../resources/style.dart';
import 'carousel_arrow.dart';
import 'carousel_item.dart';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  final CarouselController _controller = CarouselController();

  final List<String> imgList = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.png',
  ];

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgList
        .map((item) => CarouselItem(
              item: item,
            ))
        .toList();

    return Stack(
      children: [
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(
            // padEnds: false,
            // disableCenter: true,
            // padEnds: true,
            viewportFraction: 0.9,
            // autoPlay: true,
            // autoPlayInterval: const Duration(seconds: 3),
            enlargeCenterPage: true,
            height: 200,
            onPageChanged: (index, reason) {
              setState(() {
                print("++++++++++++++++++++++");
                print(index);
                _current = index;
              });
            },
          ),
          carouselController: _controller,
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 150,
          bottom: 10,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // CarouselArrow(
              //   controller: _controller,
              //   icon: Icons.arrow_back_ios_rounded,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: _current == entry.key ? 30 : 12.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:
                              // (Theme.of(context).brightness ==
                              //             Brightness.dark
                              //         ? Colors.white
                              //         : Colors.black)
                              Theme.of(context).primaryColor.withOpacity(
                                  _current == entry.key ? 0.8 : 0.3)),
                    ),
                  );
                }).toList(),
              ),
              // CarouselArrow(
              //   controller: _controller,
              //   icon: Icons.arrow_forward_ios_rounded,
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
