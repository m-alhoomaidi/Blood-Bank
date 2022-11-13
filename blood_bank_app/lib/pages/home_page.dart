import 'package:blood_bank_app/pages/search_page.dart';

import '../style.dart';
import '../widgets/home/home_charts.dart';
import '../widgets/home/home_carousel.dart';
import '../widgets/home_drawer/home_drawer.dart';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = "home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("بنك الدم الإلكتروني"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              color: ePrimColor,
              child: const HomeCarousel(),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Text(
                "إحصائيات",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const HomeCharts(),
          ],
        ),
      ),
      drawer: const HomeDrower(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search_rounded),
        onPressed: () {
          Navigator.of(context).pushNamed(SearchPage.routeName);
        },
      ),
    );
  }
}
