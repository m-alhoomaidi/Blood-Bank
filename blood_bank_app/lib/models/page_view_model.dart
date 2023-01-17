import 'package:flutter/cupertino.dart';
import 'package:introduction_screen/introduction_screen.dart';

class MyPageViewModel extends StatelessWidget {
  const MyPageViewModel({super.key});

  @override
  Widget build(BuildContext context) {
    return PageViewModel(
      // titleWidget: Text("data"),
      // body:
      //     'Body of 1st Page With that out of the way let’s create our introduction screen. First, let’s create ourselves an',
      bodyWidget: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/images/4.jpg',
                scale: 1.3,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Title of 1st Page',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Title of 1stuier qierguqer dshvjKHD JDEC S  gqprugq rgqpru  Page jhdscvjHDC c  SUCY cu cUC ',
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
      // titleWidget: Text('Title of 1st Page'),
      title: '',
      // image: Center(
      //   child: Image.asset('assets/images/4.jpg'),
      // ),
      decoration: const PageDecoration(
          // contentMargin: EdgeInsets.all(10),
          // imagePadding: EdgeInsets.only(top: 40),
          // titlePadding: EdgeInsets.symmetric(vertical: 20),
          ),
    );
  }
}
