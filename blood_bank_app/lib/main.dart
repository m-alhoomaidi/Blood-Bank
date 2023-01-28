import 'package:blood_bank_app/pages/about_page.dart';
import 'package:blood_bank_app/pages/edit_main_center_data.dart';
import 'package:blood_bank_app/pages/profile_center.dart';
import 'package:blood_bank_app/presentation/resources/theme_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'presentation/onboarding/introduction_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'cubit/profile_cubit/profile_cubit.dart';
import 'cubit/search_cubit/search_cubit.dart';
import 'cubit/signin_cubit/signin_cubit.dart';
import 'cubit/signup_cubit/signup_cubit.dart';
import 'pages/home_page.dart';
import 'pages/search_map.dart';
import 'pages/search_page.dart';
import 'pages/setting_page.dart';
import 'pages/sign_in_page.dart';
import 'pages/sign_up_page.dart';
import 'pages/sing_up_center_page.dart';
import 'pages/user_date_page.dart';
import 'dependency_injection.dart' as di;

//----------------------------
//-------------

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

//---------------------
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    // title // description
    importance: Importance.high,
    playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification!.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          color: Colors.blue,
          playSound: true,
          icon: '@mipmap/ic_launcher',
        ),
      ));
}

//-------------------------------------.
final AndroidInitializationSettings _androidInitializationSettings =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
final DarwinInitializationSettings _darwinInitializationSettings =
    DarwinInitializationSettings();

void initialisendNotfications() async {
  InitializationSettings initializationSettings =
      InitializationSettings(android: _androidInitializationSettings);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future backgroundMessage(RemoteMessage message) async {
  print("+++++++++++++++++++++++++++++++++++++++++++++++++++");
  Fluttertoast.showToast(msg: message.notification!.body.toString());
  // flutterLocalNotificationsPlugin.show(0, message.notification!.title, message, notificationDetails)
}
// final AndroidInitializationSettings

// Future updateLocation(RemoteMessage msg) async {
//   print("==========onBackground==========");
//   Fluttertoast.showToast(msg: "update location\n${msg.notification!.body}");
//   await Firebase.initializeApp();
//   print("=========update====location=======\n${msg.notification!.body}");
//   await FirebaseFirestore.instance
//       .collection("donors")
//       .doc("H5PPBI8VBBNikBYvmifb")
//       .update({
//     "lan": 2.02121510,
//     "lon": 2.42144775,
//   }).then((value) {
//     print("==========Done==========");
//   });
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.initApp();
  await Hive.initFlutter();
  await Hive.openBox(dataBoxName);

  //-----------------------------------
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  initialisendNotfications();
  //-----------------------------------------------------

  // FirebaseMessaging.onBackgroundMessage(
  //     (message) => backgroundMessage(message));
  // FirebaseMessaging.onMessage.listen((event) {
  //   print("--------------------------------00");
  //   print(event.data);
  // });
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (BuildContext context) => di.sl<SignUpCubit>()),
      BlocProvider(create: (BuildContext context) => di.sl<SingInCubit>()),
      BlocProvider(create: (BuildContext context) => di.sl<SearchCubit>()),
      BlocProvider(create: (BuildContext context) => di.sl<ProfileCubit>())
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
      theme: getApplicationTheme(),
      // theme: ThemeData(
      //   primarySwatch: Colors.red,
      //   primaryColor: ePrimColor,
      //   fontFamily: "Almarai",
      //   // textTheme: Theme.of(context).textTheme.copyWith(
      //   //       bodyText2: TextStyle(
      //   //         color: eTextColor,
      //   //         fontFamily: 'Almarai',
      //   //       ),
      //   //     ),
      // ),
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
        SignInPage.routeName: (context) => const SignInPage(),
        SignUpCenter.routeName: (context) => const SignUpCenter(),
        SearchPage.routeName: (context) => const SearchPage(),
        SettingPage.routeName: (context) => const SettingPage(),
        UserDataPage.routeName: (context) => const UserDataPage(),
        SearchMapPage.routeName: (context) => const SearchMapPage(),
        // OnBoardingView.routeName: (context) => const OnBoardingView(),
        IntroductionPage.routeName: (context) => const IntroductionPage(),
        ProfileCenterPage.routeName: (context) => ProfileCenterPage(),
        EditMainCenterDataPage.routeName: (context) => EditMainCenterDataPage(),
        AboutPage.routeName: (context) => const AboutPage()
      },
    );
  }
}
