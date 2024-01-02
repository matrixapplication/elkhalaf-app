import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alkhalafsheep/UI/home/home_controller.dart';
import 'package:alkhalafsheep/UI/intro/intro_screen.dart';
import 'package:alkhalafsheep/_helpers/shared_pref.dart';
import 'package:alkhalafsheep/elements/YemSnackBar.dart';
import 'package:alkhalafsheep/models/profile_model.dart';
import 'package:alkhalafsheep/network/requests.dart';
import 'package:alkhalafsheep/provider/main_provider.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const id = 'splash';

  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  int splashTime = 2500;
  late AnimationController animationController;
  late Animation<double> animation;
  ProfileModel profileModel = new ProfileModel();
  var _scaffold = GlobalKey<ScaffoldState>();

  init() async {
    String navigateToId = HomeController.id;
    YemenyPrefs pref = YemenyPrefs();
    String? token = await pref.getToken();
    bool? isItFirstTime = await pref.getFirstTimeVisit();
    if (isItFirstTime != null && isItFirstTime) navigateToId = IntroScreen.id;

    if (token != null && token != '') {
      profileModel.id = await pref.getUserId();
      profileModel.name = await pref.getUserName();
      profileModel.tokenId = token;
      profileModel.email = await pref.getEmail();
      profileModel.phone = await pref.getPhone();
      profileModel.image = await pref.getPhoto();
      profileModel.cityId = await pref.getCityId();
      profileModel.cityName = await pref.getCityName();
      profileModel.countryName = await pref.getCountryName();
      profileModel.countryId = await pref.getCountryId();
      profileModel.isAdmin = await pref.getIsTypeAdmin();
    }



    try {
      await NetworkRequests().main(context);

      animationController.dispose();
      Navigator.of(context)
          .pushNamedAndRemoveUntil(navigateToId, (route) => false);
    } catch (e) {
      if (e == 'network') {
        YemSnackBar().showNoInternetConnection(
            scaffoldKey: _scaffold,
            function: () {
              init();
            },
            durationInSeconds: 1000);
      } else {
        YemSnackBar().showServerErrorConnection(
            scaffoldKey: _scaffold,
            function: () {
              init();
            },
            durationInSeconds: 1000);
      }
    }
  }

  void navigationPage() {


    MainDataProvider mainDataProvider =
        Provider.of<MainDataProvider>(context, listen: false);
    if (mainDataProvider == null) {
    } else {}
  }

  @override
  void dispose() {
    super.dispose();
    if (animationController.isAnimating) animationController.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: splashTime));

    animation = new CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    WidgetsBinding.instance!.addPostFrameCallback((_) => init());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffold,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          Opacity(
            opacity: animation.value,
            child: Image.asset(
              kLogoPath,
              width: 250,
              height: 250,
            ),
          ),
          CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff22554E)),
          )
        ],
      ),
    );
  }
}
