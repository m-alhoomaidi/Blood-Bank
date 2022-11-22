<<<<<<< HEAD
import 'package:blood_bank_app/pages/search_page.dart';
import 'package:blood_bank_app/pages/setting_page.dart';

=======
import '../pages/search_page.dart';
>>>>>>> b474634751f450913173a4c490aab9f2b51f5293
import '../style.dart';
import '../pages/home_page.dart';
import '../pages/sign_up_page.dart';
import '../pages/sign_in_page.dart';
import '../pages/sing_up_center_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: ePrimColor,
        fontFamily: "Almarai",
        // textTheme: Theme.of(context).textTheme.copyWith(
        //       bodyText2: TextStyle(
        //         color: eTextColor,
        //         fontFamily: 'Almarai',
        //       ),
        //     ),
      ),
      locale: const Locale("ar", "AE"),
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale("ar", "AE")],
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        SignUpPage.routeName: (context) => const SignUpPage(),
        SignInPage.routeName: (context) => SignInPage(),
        SignUpCenter.routeName: (context) => const SignUpCenter(),
        SearchPage.routeName: (context) => const SearchPage(),
        SettingPage.routeName: (context) => const SettingPage()
      },
    );
  }
}
