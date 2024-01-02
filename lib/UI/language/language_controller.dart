import 'package:alkhalafsheep/UI/intro/intro_screen.dart';
import 'package:alkhalafsheep/_helpers/shared_pref.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

bool goToLoginScreen = false;

class LanguageScreen extends StatefulWidget {
  static const id = 'lang';

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  bool selectArabic = false;
  bool selectEnglish = false;

  String btnText = 'Continue';

  getUserSavedData() async {}

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => getUserSavedData());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: "logo",
                child: Image.asset(
                  kLogoPath,
                  height: 80,
                ),
              ),
              Card(
                margin: EdgeInsets.all(8),
                elevation: 4,
                child: Column(
                  children: <Widget>[
                    CheckboxListTile(
                      title: const Text('اللغة العربية'),
                      value: selectArabic,
                      onChanged: (bool? value) {
                        setState(() {
                          selectArabic = !selectArabic;
                          selectEnglish = !selectArabic;
                          btnText = 'المتابعة';
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CheckboxListTile(
                      title: const Text('English'),
                      value: selectEnglish,
                      onChanged: (bool? value) {
                        setState(() {
                          selectEnglish = !selectEnglish;
                          selectArabic = !selectEnglish;
                          btnText = YemString.continuez;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
              FlatButton(
                color: kPrimaryColor,
                onPressed: () {
                  setState(() {
                    if (selectArabic) {
                      context.locale = Locale('ar');
                      YemenyPrefs pref = YemenyPrefs();
                      pref.setLang('ar');
                      navigateToNextPage();
                    }
                    if (selectEnglish) {
                      context.locale = Locale('en');
                      YemenyPrefs pref = YemenyPrefs();
                      pref.setLang('en');
                      navigateToNextPage();
                    }
                  });
                },
                child: Text(
                  btnText,
                  style: kWhiteTextColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void navigateToNextPage() {
    if (goToLoginScreen)
      Navigator.of(context).pushReplacementNamed(IntroScreen.id);
  }
}
