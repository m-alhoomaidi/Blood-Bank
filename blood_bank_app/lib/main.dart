import 'package:blood_bank_app/cubit/search_cubit/search_cubit.dart';
import 'package:blood_bank_app/cubit/signup_cubit/signup_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/signin_cubit/signin_cubit.dart';
import 'pages/search_page.dart';
import 'pages/setting_page.dart';
import 'pages/user_date_page.dart';
import 'pages/home_page.dart';
import 'pages/sign_up_page.dart';
import 'pages/sign_in_page.dart';
import 'pages/sing_up_center_page.dart';
import 'style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (BuildContext context) => SignupCubit()),
      BlocProvider(create: (BuildContext context) => SingInCubit()),
      BlocProvider(create: (BuildContext context) => SearchCubit()),
    ],
    child: const MyApp(),
  ));
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
        SettingPage.routeName: (context) => const SettingPage(),
        UserDataPage.routeName: (context) => const UserDataPage(),
      },
    );
  }
}
