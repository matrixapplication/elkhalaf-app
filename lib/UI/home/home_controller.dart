import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:alkhalafsheep/UI/cart_provider/cart_provider_controller.dart';
import 'package:alkhalafsheep/UI/home/home_drawer.dart';
import 'package:alkhalafsheep/UI/home/home_view.dart';
import 'package:alkhalafsheep/UI/home/notification_fcm.dart';
import 'package:alkhalafsheep/UI/home/offers_home.dart';
import 'package:alkhalafsheep/UI/my_orders/my_orders_controller.dart';
import 'package:alkhalafsheep/models/profile_model.dart';
import 'package:alkhalafsheep/provider/cart_provider.dart';
import 'package:alkhalafsheep/provider/main_provider.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:provider/provider.dart';

import '../account/account_view.dart';

class HomeController extends StatefulWidget {
  static const String id = 'home';
  final int? pageNumber;

  const HomeController({this.pageNumber});

  @override
  _HomeControllerState createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  int? currentIndex = 2;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController? _controller;
  late MainDataProvider data;
  late CartProvider cartProvider;
  ProfileModel? profileData;

  @override
  void initState() {
    super.initState();
    //todo call notificationFCM method 1 time
    NotificationsFCM(context);
    Firebase.initializeApp();
    if (widget.pageNumber != null) {
      currentIndex = widget.pageNumber;
    }
    _controller = PageController(initialPage: currentIndex!, keepPage: false);
  }

  Widget callPage(int? current) {
    return PageView(
      controller: _controller,
      onPageChanged: (page) {
        setState(() {
          currentIndex = page;
        });
      },
      pageSnapping: true,
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        //todo show only offers
        ProductsListWidget(
          products: data.mainData!
              .products /*.where((element) => element.showInOffers).toList()*/,
        ),
        CartProviderController(showAppBar: false),
        HomeView(),
        AccountView(),
        MyOrdersController(),
      ],
    );
  }
  Future<bool> onBackPress() {
    if (currentIndex == 2) {
      return Future.value(true);
    } else {
      setState(() {
        currentIndex = 2;
        _controller!.jumpToPage(2);
      });
      return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    data = Provider.of<MainDataProvider>(context, listen: false);
    profileData = Provider.of<ProfileModel>(context, listen: false);
    return WillPopScope(
      onWillPop: onBackPress,
      child: Consumer<CartProvider>(
        builder: (context, cartPro, child) {
          cartProvider = cartPro;
          return Container(
            color: kPrimaryColor,
            child: SafeArea(
              child: Scaffold(
                drawer: HomeDrawer(),
                key: _scaffoldKey,
                appBar: AppBar(
                  backgroundColor: kPrimaryColor,
                  // title: Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 4),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(4.0),
                  //     child: ClipRRect(
                  //       borderRadius: BorderRadius.circular(100),
                  //       child: Image.asset(
                  //         'assets/img/logo_white_bk.png',
                  //         height: 55,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  centerTitle: true,
                  actions: [
                    // Center(
                    //   child: GestureDetector(
                    //     onTap: () {},
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 12),
                    //       child: Stack(
                    //         alignment: AlignmentDirectional(-3.0, -3.0),
                    //         children: <Widget>[
                    //           Icon(Icons.notifications_active),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                floatingActionButton: floatingWidget(),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                backgroundColor: Colors.grey[200],
                body: GestureDetector(
                    child: currentIndex == 11
                        ? ProductsListWidget(
                            products: data.mainData!
                                .products /*.where((element) => element.showInOffers).toList()*/,
                          )
                        : callPage(currentIndex)),
                bottomNavigationBar: buildBottomNavigationBar(),
              ),
            ),
          );
        },
      ),
    );
  }

  BottomAppBar buildBottomNavigationBar() {
    return BottomAppBar(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: CircularNotchedRectangle(),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex!,
        fixedColor: Colors.white,
        backgroundColor: kPrimaryColor,
        unselectedItemColor: Colors.white70,
        onTap: (value) {
          setState(() {
            currentIndex = value;
            _controller!.jumpToPage(value);
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.local_offer,size: 22,), label: YemString.offers),
          BottomNavigationBarItem(
            icon:
            Center(
              child: FittedBox(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Icon(
                        Icons.shopping_cart,
                        size: 22.0,

                      ),
                    ),
                    cartProvider.cart == null ||
                        cartProvider.cart!.length < 1
                        ? Text(
                      '',
                      style: TextStyle(
                          fontSize: 10.0, color: kPrimaryColor),
                    )
                        : CircleAvatar(
                      radius: 8.6,
                      backgroundColor: Colors.blueGrey,
                      child: Text(
                        '${cartProvider.cart!.length}',
                        style: TextStyle(
                            fontSize: 8.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            label: 'السلة',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_drop_down,
                size: 20.0,

              ), label: YemString.home),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                size: 22.0,
              ),
              label: YemString.account),
          BottomNavigationBarItem(
              icon: Icon(Icons.reorder,
                size: 22.0,

              ), label: YemString.my_orders),
        ],
      ),
    );
  }

  Widget floatingWidget() {
    return FloatingActionButton(
      onPressed: () async {
        setState(() {
          _controller!.jumpToPage(2);
          currentIndex = 2;
        });
      },
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(kLogoPath),
      ),
    );
  }
}
