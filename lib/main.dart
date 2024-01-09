import 'package:alkhalafsheep/models/profile_model.dart';
import 'package:alkhalafsheep/provider/cart_provider.dart';
import 'package:alkhalafsheep/provider/main_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'UI/splash/splash_controller.dart';
import 'route_generator.dart';
import 'utilities/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: supportedLocales,
    startLocale: supportedLocales[0],
    fallbackLocale: supportedLocales[0],
    path: 'resources/langs',
    saveLocale: true,
    useOnlyLangCode: true,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  //status bar color
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: kPrimaryColor));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => MainDataProvider()),
        ChangeNotifierProvider(create: (context) => ProfileModel()),
      ],
      child: MaterialApp(
        title: kAppName,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: supportedLocales,
        locale: supportedLocales[0],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: kPrimarySwatchColor2,
            primaryColor: kPrimaryColor2,
            textTheme: GoogleFonts.cairoTextTheme(
              Theme.of(context).textTheme,
            )),
        initialRoute: SplashScreen.id,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

final supportedLocales = <Locale>[
  const Locale('ar'),
  const Locale('en'),
];
