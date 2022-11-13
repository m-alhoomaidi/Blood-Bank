import 'package:blood_bank_app/widgets/forms/my_text_form_field.dart';
import 'package:blood_bank_app/widgets/home/home_charts.dart';
import 'package:flutter/material.dart';
import '../widgets/home/home_carousel.dart';
import '../widgets/forms/my_button.dart';
import '../widgets/home_drawer/home_drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  static const String routeName = "home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("بنك الدم الإلكتروني"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HomeCarousel(),
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
        onPressed: () {},
      ),
    );
  }
}
