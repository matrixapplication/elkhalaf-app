import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:alkhalafsheep/UI/about_policy/about_bolicy_controller.dart';
import 'package:alkhalafsheep/UI/account/contact_us_controller.dart';
import 'package:alkhalafsheep/UI/login/login_controller.dart';
import 'package:alkhalafsheep/UI/my_orders/my_orders_controller.dart';
import 'package:alkhalafsheep/UI/order_addresses/order_addresses_controller.dart';
import 'package:alkhalafsheep/UI/profile/profile_screen.dart';
import 'package:alkhalafsheep/UI/register/register_controller.dart';
import 'package:alkhalafsheep/UI/splash/splash_controller.dart';
import 'package:alkhalafsheep/_helpers/shared_pref.dart';
import 'package:alkhalafsheep/models/profile_model.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/echo.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:provider/provider.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../provider/main_provider.dart';

class AccountView extends StatelessWidget {
  static String id = 'account';
  final String? title;

  const AccountView({this.title});

  @override
  Widget build(BuildContext context) {
    final _decoration = BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.4),
        borderRadius: BorderRadius.circular(4),
        color: Colors.white);
    ProfileModel profileModel = Provider.of<ProfileModel>(context, listen: false);
    Echo('${profileModel.tokenId}');
    Echo('${profileModel.name}');
    MainDataProvider mainDataProvider =
    Provider.of<MainDataProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                if (profileModel.name != null)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(top: 12),
                    decoration: _decoration,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(width: 20),
                            Text(
                              profileModel.name!,
                              style: kTextPrimaryHeader,
                            ),
                            GestureDetector(
                              onTap: () {
                              //  Navigator.push(
                              //    context,
                              //    PageRouteBuilder(
                              //      pageBuilder:
                              //          (context, animation1, animation2) =>
                              //              ProfileScreen(),
                              //      transitionsBuilder: (context, animation1,
                              //              animation2, child) =>
                              //          FadeTransition(
                              //              opacity: animation1, child: child),
                              //      transitionDuration:
                              //          Duration(milliseconds: 600),
                              //    ),
                              //  );

                                Navigator.of(context).push(SwipeablePageRoute(
                                  builder: (BuildContext context) =>
                                      ProfileScreen(),
                                ));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Icon(Icons.edit, color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                        if (profileModel.cityName != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(profileModel.cityName!, style: kTextGreyBody),
                              SizedBox(width: 8),
                              Icon(Icons.location_city, color: Colors.grey),
                            ],
                          ),
                        SizedBox(height: 4),
                        if (profileModel.phone != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(profileModel.phone!, style: kTextGreyBody),
                              SizedBox(width: 8),
                              Icon(Icons.phone, color: Colors.grey),
                            ],
                          )
                      ],
                    ),
                  ),
                SizedBox(height: 8),
                //My Orders
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 12),
                  decoration: _decoration,
                  child: GestureDetector(
                    onTap: () {
                      navigateToMyOrders(context);
                    },
                    child: ListTile(
                      title: Text(YemString.my_orders, style: kTextGreyBody),
                      leading: Icon(Icons.history, color: kPrimaryColor),
                      trailing: Icon(Icons.arrow_forward, color: kPrimaryColor),
                    ),
                  ),
                ),
                //Address's
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 12),
                  decoration: _decoration,
                  child: GestureDetector(
                    onTap: () {
                      navigateToMyAddresses(context);
                    },
                    child: ListTile(
                      title: Text(YemString.my_addresses, style: kTextGreyBody),
                      leading: Icon(Icons.gps_fixed, color: kPrimaryColor),
                      trailing: Icon(Icons.arrow_forward, color: kPrimaryColor),
                    ),
                  ),
                ),
                //Setting
                /*Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 12),
                  decoration: _decoration,
                  child: GestureDetector(
                    onTap: () {},
                    child: ListTile(
                      title: Text(YemString.setting, style: kTextGreyBody),
                      leading: Icon(Icons.settings, color: kPrimaryColor),
                      trailing: Icon(Icons.arrow_forward, color: kPrimaryColor),
                    ),
                  ),
                ),*/
                //About
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 12),
                  decoration: _decoration,
                  child: GestureDetector(
                    onTap: () {
//                      Navigator.push(
//                        context,
//                        PageRouteBuilder(
//                          pageBuilder: (context, animation1, animation2) =>
//                              AboutPolicyController(pageId: '3',),
//                          transitionsBuilder: (context, animation1, animation2,
//                              child) =>
//                              FadeTransition(opacity: animation1, child: child),
//                          transitionDuration: Duration(milliseconds: 600),
//                        ),
//                      );
                      Navigator.of(context).push(SwipeablePageRoute(
                        builder: (BuildContext context) =>
                            AboutPolicyController(
                          pageId: 'about',
                        ),
                      ));
                    },
                    child: ListTile(
                      title: Text(YemString.about, style: kTextGreyBody),
                      leading: Icon(Icons.info_outline, color: kPrimaryColor),
                      trailing: Icon(Icons.arrow_forward, color: kPrimaryColor),
                    ),
                  ),
                ),
                //Contact us
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 12),
                  decoration: _decoration,
                  child: GestureDetector(
                    onTap: () {
                    //  Navigator.push(
                    //    context,
                    //    PageRouteBuilder(
                    //      pageBuilder: (context, animation1, animation2) =>
                    //          ContactUs(),
                    //      transitionsBuilder: (context, animation1, animation2,
                    //              child) =>
                    //          FadeTransition(opacity: animation1, child: child),
                    //      transitionDuration: Duration(milliseconds: 600),
                    //    ),
                    //  );

                      Navigator.of(context).push(SwipeablePageRoute(
                        builder: (BuildContext context) => ContactUs(),
                      ));
                    },
                    child: ListTile(
                      title: Text(YemString.contact_us, style: kTextGreyBody),
                      leading: Icon(Icons.contact_mail, color: kPrimaryColor),
                      trailing: Icon(Icons.arrow_forward, color: kPrimaryColor),
                    ),
                  ),
                ),
                //Policy
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 12),
                  decoration: _decoration,
                  child: GestureDetector(
                    onTap: () {
//                      Navigator.push(
//                        context,
//                        PageRouteBuilder(
//                          pageBuilder: (context, animation1, animation2) =>
//
//                          transitionsBuilder: (context, animation1, animation2,
//                              child) =>
//                              FadeTransition(opacity: animation1, child: child),
//                          transitionDuration: Duration(milliseconds: 600),
//                        ),
//                      );
                      Navigator.of(context).push(SwipeablePageRoute(
                        builder: (BuildContext context) =>
                            AboutPolicyController(
                          pageId: 'policy',
                        ),
                      ));
                    },
                    child: ListTile(
                      title: Text(YemString.policy_terms, style: kTextGreyBody),
                      leading: Icon(Icons.security, color: kPrimaryColor),
                      trailing: Icon(Icons.arrow_forward, color: kPrimaryColor),
                    ),
                  ),
                ),
                //Logout
                profileModel.tokenId != null && profileModel.tokenId!.isNotEmpty
                    ? Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 12),
                        decoration: _decoration,
                        child: GestureDetector(
                          onTap: () async {
                            YemenyPrefs pref = YemenyPrefs();
                             pref.logout();
                            await Provider.of<ProfileModel>(context,listen: false).clear;
                            Provider.of<ProfileModel>(context, listen: false).id = null;
                            Provider.of<ProfileModel>(context, listen: false).tokenId = null;
                            Provider.of<ProfileModel>(context, listen: false).name = null;
                            Provider.of<ProfileModel>(context, listen: false).phone = null;
                            sleep(Duration(seconds: 1));
                            Navigator.pushNamed(context, SplashScreen.id);
                          },
                          child: ListTile(
                            title: Text(YemString.logout, style: kTextGreyBody),
                            leading:
                                Icon(Icons.exit_to_app, color: kPrimaryColor),
                            trailing:
                                Icon(Icons.arrow_forward, color: kPrimaryColor),
                          ),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 12),
                        decoration: _decoration,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, RegisterController.id);
                          },
                          child: ListTile(
                            title:
                                Text(YemString.register, style: kTextGreyBody),
                            leading: Icon(Icons.input, color: kPrimaryColor),
                            trailing:
                                Icon(Icons.arrow_forward, color: kPrimaryColor),
                          ),
                        ),
                      ),

                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 12),
                  decoration: _decoration,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        child: Image.asset('assets/img/whats.png',
                          width: 30,
                          height: 30,
                        ),
                        onTap: (){
                          launch('${mainDataProvider.mainData!.whatsapp}');
                        },
                      ),
                      // SocialMediaButton.whatsapp(
                      //   url: '',
                      //   onTap: () {},
                      //   size: 35,
                      //   color: Colors.green,
                      // ),
                      GestureDetector(
                          onTap: () async{
                            Uri telephoneUrl = Uri.parse("tel:${mainDataProvider.mainData!.phone}");
                            await launchUrl(telephoneUrl);
                          },
                          child: Icon(
                            Icons.call,
                            color: Colors.green,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void navigateToMyOrders(BuildContext context) async {
  YemenyPrefs prefs = YemenyPrefs();
  bool userRegistered = await prefs.getToken() == null ? false : true;

  if (userRegistered)
//    Navigator.push(
//      context,
//      PageRouteBuilder(
//        pageBuilder: (context, animation1, animation2) => MyOrdersController(),
//        transitionsBuilder: (context, animation1, animation2, child) =>
//            FadeTransition(opacity: animation1, child: child),
//        transitionDuration: Duration(milliseconds: 600),
//      ),
//    );

    Navigator.of(context).push(SwipeablePageRoute(
      builder: (BuildContext context) => MyOrdersController(),
    ));
  else {
    AwesomeDialog(
      context: context,
      animType: AnimType.topSlide,
      dialogType: DialogType.info,
      title: YemString.note,
      desc: YemString.register_to_navigate_to_myordes,
      btnOkText: YemString.register,
      btnOkOnPress: () {
        Navigator.of(context).push(SwipeablePageRoute(
          builder: (BuildContext context) =>  LoginController(),
        ));
      },
    ).show();
  }
}

void navigateToMyAddresses(BuildContext context) async {
  YemenyPrefs prefs = YemenyPrefs();
  bool userRegistered = await prefs.getToken() == null ? false : true;

  if (userRegistered)
//    Navigator.push(
//      context,
//      PageRouteBuilder(
//        pageBuilder: (context, animation1, animation2) =>
//            OrderAddressesController(),
//        transitionsBuilder: (context, animation1, animation2, child) =>
//            FadeTransition(opacity: animation1, child: child),
//        transitionDuration: Duration(milliseconds: 600),
//      ),
//    );
  Navigator.of(context).push(SwipeablePageRoute(
    builder: (BuildContext context) =>  OrderAddressesController(),
  ));
  else {
    AwesomeDialog(
      context: context,
      animType: AnimType.topSlide,
      dialogType: DialogType.info,
      title: YemString.note,
      desc: YemString.register_to_navigate_to_myadresses,
      btnOkText: YemString.register,
      btnOkOnPress: () {
        Navigator.pushReplacementNamed(context, LoginController.id);
      },
    ).show();
  }
}
