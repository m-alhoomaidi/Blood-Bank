import 'package:blood_bank_app/style.dart';
import 'package:blood_bank_app/widgets/home/carousel_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
            // autoPlay: true,
            // autoPlayInterval: const Duration(seconds: 3),
            enlargeCenterPage: true,
            height: 200,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          carouselController: _controller,
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 200,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CarouselArrow(
                controller: _controller,
                icon: Icons.arrow_back_ios_rounded,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              // (Theme.of(context).brightness ==
                              //             Brightness.dark
                              //         ? Colors.white
                              //         : Colors.black)
                              eSecondColor.withOpacity(
                                  _current == entry.key ? 0.8 : 0.3)),
                    ),
                  );
                }).toList(),
              ),
              CarouselArrow(
                controller: _controller,
                icon: Icons.arrow_forward_ios_rounded,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CarouselArrow extends StatelessWidget {
  const CarouselArrow(
      {Key? key, required CarouselController controller, required this.icon})
      : _controller = controller,
        super(key: key);

  final CarouselController _controller;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 50,
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0),
            backgroundColor: Colors.red.withOpacity(0),
            shadowColor: Colors.red.withOpacity(0),
          ),
          child: SizedBox(
            height: 200,
            child: Icon(
              icon,
              size: 40,
              color: Colors.black45,
            ),
          ),
          onPressed: () {
            _controller.nextPage();
          },
        ),
      ),
    );
  }
}
