import 'package:blood_bank_app/widgets/home/home_about.dart';
import 'package:blood_bank_app/widgets/home/home_welcome.dart';

import 'search_page.dart';
import '../models/extention.dart';
import '../shared/style.dart';
import '../widgets/home/home_statistics_charts/home_charts.dart';
import '../widgets/home/home_carousel/home_carousel.dart';
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
        actions: [
          IconButton(
            onPressed: () {
              String s = "565655555";
              print("++++++++++++++++++++++");
              print(s.isValidPhone);
              // try {
              //   FirebaseAuth.instance.createUserWithEmailAndPassword(
              //     email: 'email@example.com',
              //     password: 'password',
              //   );
              // } catch (e) {
              //   print(e);
              // }
            },
            icon: const Icon(
              Icons.notifications,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            HomeWelcome(),
            HomeAbout(),

            // Container(
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            //   child: Text(
            //     'إرشــادات صـحيـة:',
            //     style: TextStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: const [
            //       Text(
            //         'أولاً يجب التأكد من فصيلة دم المحتاج.',
            //       ),
            //     ],
            //   ),
            // ),
            //   padding: const EdgeInsets.symmetric(vertical: 10.0),
            //   color: ePrimColor,
            //   child: const HomeCarousel(),
            // ),
            // const Divider(),
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            //   child: Text(
            //     "إحصائيات",
            //     style: TextStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            // const HomeCharts(),

            SizedBox(height: 20),
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
