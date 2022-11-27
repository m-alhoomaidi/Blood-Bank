import 'package:flutter/material.dart';

class ResultTabs extends StatefulWidget {
  ResultTabs({Key? key}) : super(key: key);

  @override
  State<ResultTabs> createState() => _ResultTabsState();
}

class _ResultTabsState extends State<ResultTabs> {
  int current = 0;

  List<String> items = [
    'A+',
    'O+',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    current = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.all(5),
                  width: 70,
                  height: 45,
                  decoration: BoxDecoration(
                    color: current == index ? Colors.white : Colors.white70,
                    borderRadius: current == index
                        ? BorderRadius.circular(10)
                        : BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        items[index],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: current == index
                              ? FontWeight.bold
                              : FontWeight.w500,
                        ),
                      ),
                      // ignore: prefer_const_constructors
                      Text(
                        '5',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: current == index,
                child: Container(
                  width: 60,
                  height: 3,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
