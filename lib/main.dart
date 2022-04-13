// Firebase library
import 'package:firebase_core/firebase_core.dart';
// Language
import 'package:easy_localization/easy_localization.dart';
import 'package:hello/Admin/Admin-Screens/Delete_Charety.dart';
import 'package:hello/language/Config/config-lang.dart';
// Provider Library
import 'package:provider/provider.dart';
// Flutter Library
import 'package:flutter/material.dart';
// Page library
import 'package:hello/Home/Home-Screen.dart';
import 'package:hello/Admin/Admin-Screens/feedback-screen.dart';
import 'package:hello/Admin/Admin-Screens/Available-Cash.dart';
import 'package:hello/Admin/Admin-Screens/Available-Donation.dart';
import 'package:hello/Admin/Admin-Screens/CharityNeed.dart';
import 'package:hello/Admin/admain-screen.dart';
import 'package:hello/Views/Charity/Login/Screenes/Sign-In.dart';
import 'package:hello/Views/Charity/Screen-Charity/charity-need.dart';
import 'package:hello/Splash-Page/splash-screen.dart';
import 'package:hello/Views/About/About-Ehsan.dart';
import 'package:hello/Views/Charity/Login/Services/Authentication-Firebase.dart';
import 'package:hello/Views/Talabat/Talpat-Screen/Estefadeh-mohtaj.dart';
import 'package:hello/Views/Talabat/Talpat-Screen/mohtaj-requist.dart';
import 'package:hello/Views/Talabat/talabat.dart';
import 'package:hello/Views/Drawer-Page/feedback.dart';
import 'package:hello/Views/Drawer-Page/setting.dart';
import 'package:hello/Views/Charity/Screen-Charity/Charity.dart';
import 'package:hello/Admin/Admin-Screens/Charity-Requist.dart';
import 'package:hello/Views/Donor/Donor-Screan/Cash-Donate.dart';
import 'package:hello/Views/Donor/Donor-Screan/Donor-Home.dart';
import 'package:hello/Views/Donor/Donor-Screan/donate-something.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: [ConfigLanguage.EN_LOCALE, ConfigLanguage.AR_LOCALE],
      path: ConfigLanguage.LANG_PATH,
      fallbackLocale: ConfigLanguage.EN_LOCALE,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthService>(
            create: (_) => AuthService(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'EHSAN',
          theme: ThemeData(
            primaryColor: Colors.teal,
          ),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: const MyCustomSplashScreen(),
          routes: {
            '/deleteCharety':(context) => const DeleteCharety(),
            '/About': (context) => const MyCustomWidget(),
            '/Talbat': (context) => const Talabat(),
            '/talbmohtaj': (context) => const talbmohtaj(),
            '/talbEstfada': (context) => const talbEstfada(),
            '/Setting': (context) => const Setting(),
            '/MyFeedback': (context) => const MyFeedback(),
            '/Charity': (context) => const Charity(),
            '/DonorHome': (context) => const DonorHome(),
            '/SomthingDonate': (context) => const SomthingDonate(),
            '/CashDonor': (context) => const CashDonor(),
            '/AdminCharRequist': (context) => const CharRequist(),
            '/AdmainHome': (context) => const AdmainHome(),
            '/SignIn': (context) => const SignIn(),
            '/AvailableDonation': (context) => const AvailableDonation(),
            '/AvailableCash': (context) => const AvailableCash(),
            '/CharityNeed': (context) => const CharityNeed(),
            '/CahrityBenefitRequist': (context) =>const CahrityBenefitRequist(),
            '/MyHomePage': (context) => const MyHomePage(),
            '/Feedback': (context) => const FeedbackPage(),
          },
        ));
  }
}
