import 'package:alkhalafsheep/UI/about_policy/about_bolicy_controller.dart';
import 'package:alkhalafsheep/UI/account/contact_us_controller.dart';
import 'package:alkhalafsheep/UI/login/login_controller.dart';
import 'package:alkhalafsheep/UI/profile/profile_screen.dart';
import 'package:alkhalafsheep/_helpers/shared_pref.dart';
import 'package:alkhalafsheep/const/_const.dart';
import 'package:alkhalafsheep/const/themes.dart';
import 'package:alkhalafsheep/models/profile_model.dart';
import 'package:alkhalafsheep/provider/main_provider.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_buttons/social_media_buttons.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:url_launcher/url_launcher.dart';

import '../splash/splash_controller.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    ProfileModel profileModel =
        Provider.of<ProfileModel>(context, listen: false);
    MainDataProvider mainDataProvider =
        Provider.of<MainDataProvider>(context, listen: false);

    List<DrawerItem> list = [];
    if (profileModel.name != null)
      list.add(DrawerItem(
          title: profileModel.name,
          iconData: Icons.person,
          routeName: ProfileScreen()));
    if (profileModel.name == null)
      list.add(DrawerItem(
          title: 'حسابي', iconData: Icons.person, routeName: 'auth'));

//    list.add(DrawerItem(title: YemString.my_orders, iconData: Icons.history, routeName: MyOrdersController()));
//    list.add(
//        DrawerItem(title: YemString.my_addresses, iconData: Icons.gps_fixed, routeName: OrderAddressesController()));
//
    list.add(DrawerItem(
        title: YemString.about,
        iconData: Icons.info,
        routeName: AboutPolicyController(
          pageId: 'about',
        )));
    list.add(DrawerItem(
        title: YemString.contact_us,
        iconData: Icons.contact_mail,
        routeName: ContactUs()));
    list.add(DrawerItem(
        title: YemString.policy_terms,
        iconData: Icons.security,
        routeName: AboutPolicyController(
          pageId: 'policy',
        )));
    if (profileModel.name != null)
      list.add(DrawerItem(
          title: YemString.logout,
          iconData: Icons.exit_to_app,
          routeName: null));

    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
              color: Colors.white,
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  ImagePath.IC_LOGO_FULL,
                  height: 120,
                ),
              ))),
          ...list.map((singleItem) {
            return GestureDetector(
              onTap: () async {
                if (singleItem.routeName == null) {
                  YemenyPrefs pref = YemenyPrefs();
                   pref.logout();
                  await Provider.of<ProfileModel>(context, listen: false).clear;
                  Provider.of<ProfileModel>(context, listen: false).id = null;
                  Provider.of<ProfileModel>(context, listen: false).tokenId =
                      null;
                  Provider.of<ProfileModel>(context, listen: false).name = null;
                  Provider.of<ProfileModel>(context, listen: false).phone =
                      null;
                  Navigator.pushNamed(context, SplashScreen.id);
                } else if (singleItem.routeName == 'auth') {
                  Navigator.of(context).push(SwipeablePageRoute(
                    builder: (BuildContext context) => LoginController(),
                  ));
                } else {
                  Navigator.of(context).push(SwipeablePageRoute(
                    builder: (BuildContext context) => singleItem.routeName,
                  ));
                }
              },
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(singleItem.title!),
                    leading: Icon(
                      singleItem.iconData,
                      color: LightThemeColors.primaryColor,
                    ),
                  ),
                  Divider(),
                ],
              ),
            );
          }).toList(),
// Social links
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              if (mainDataProvider.mainData != null &&
                  mainDataProvider.mainData!.snapchat != null &&
                  mainDataProvider.mainData!.snapchat!.isNotEmpty)
                Flexible(
                  flex: 1,
                  child: AvatarGlow(
                    glowColor: Colors.yellow,
                    // endRadius: 40.0,
                    child: Material(
                      elevation: 8.0,
                      shape: CircleBorder(),
                        child: SocialMediaButton.snapchat(
                        url: '${mainDataProvider.mainData!.snapchat}',
                        size: 35,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                ),
              if (mainDataProvider.mainData != null &&
                  mainDataProvider.mainData!.twitter != null &&
                  mainDataProvider.mainData!.twitter!.isNotEmpty)
                Flexible(
                  flex: 1,
                  child: AvatarGlow(
                    glowColor: Colors.blue,
                    child: Material(
                      elevation: 8.0,
                      shape: CircleBorder(),
                      child: SocialMediaButton.twitter(
                        url: '${mainDataProvider.mainData!.twitter}',
                        size: 35,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              if (mainDataProvider.mainData != null &&
                  mainDataProvider.mainData!.instagram != null &&
                  mainDataProvider.mainData!.instagram!.isNotEmpty)
                Flexible(
                  flex: 1,
                  child: AvatarGlow(
                    glowColor: Colors.orange,
                    child: Material(
                      elevation: 8.0,
                      shape: CircleBorder(),
                      child: SocialMediaButton.instagram(
                        url: '${mainDataProvider.mainData!.instagram}',
                        size: 35,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
              Flexible(
                flex: 1,
                child: AvatarGlow(
                  glowColor: Colors.black,
                  
                  child: GestureDetector(
                    onTap: (){
                      launch('${mainDataProvider.mainData!.tiktok}');
                    },
                    child: Material(
                      elevation: 8.0,
                      shape: CircleBorder(),
                      child: Image.asset(
                        'assets/img/ic_tiktok.png',
                        width: 45,
                      ),
                    ),
                  ),
                ),
              ),
              if (mainDataProvider.mainData != null &&
                  mainDataProvider.mainData!.whatsapp != null &&
                  mainDataProvider.mainData!.whatsapp!.isNotEmpty)
                Flexible(
                  flex: 1,
                  child: AvatarGlow(
                    glowColor: Colors.green,
                    child: Material(
                      elevation: 8.0,
                      shape: CircleBorder(),
                      child: SocialMediaButton.whatsapp(
                        url: '${mainDataProvider.mainData!.whatsapp}',
                        size: 35,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}

class DrawerItem {
  String? title;
  var routeName;
  IconData? iconData;

  DrawerItem({this.title, this.iconData, this.routeName});
}
