import 'package:alkhalafsheep/UI/my_orders/my_order_model.dart';
import 'package:alkhalafsheep/UI/my_orders/my_orders_view.dart';
import 'package:alkhalafsheep/_helpers/shared_pref.dart';
import 'package:alkhalafsheep/components/loading_widget.dart';
import 'package:alkhalafsheep/elements/auth_error.dart';
import 'package:alkhalafsheep/models/profile_model.dart';
import 'package:alkhalafsheep/network/myorders_request.dart';
import 'package:alkhalafsheep/network_models/my_orders_response.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../splash/splash_controller.dart';

class AdminOrdersController extends StatefulWidget {
  final SingleOrder? modelMyOrders;

  AdminOrdersController({this.modelMyOrders});

  @override
  _AdminOrdersControllerState createState() => _AdminOrdersControllerState();
}

class _AdminOrdersControllerState extends State<AdminOrdersController> {
  ScrollController controller = ScrollController();
  List<ModelMyOrders> myOrdersList = [];
  int selectedOldOrders = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(
        child: Scaffold(
      key: new GlobalKey(),
      appBar: AppBar(
        title: Text(
          'الطلبات',
          style: kWhiteTextColor,
        ),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        actions: [
          Center(
            child: GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('تحديث'),
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                YemenyPrefs pref = YemenyPrefs();
                 pref.logout();
                await Provider.of<ProfileModel>(context, listen: false).clear;
                Provider.of<ProfileModel>(context, listen: false).id = null;
                Provider.of<ProfileModel>(context, listen: false).tokenId =
                    null;
                Provider.of<ProfileModel>(context, listen: false).name = null;
                Provider.of<ProfileModel>(context, listen: false).phone = null;
                Navigator.pushNamed(context, SplashScreen.id);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'تسجيل خروج',
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        myOrdersList.clear();
                        selectedOldOrders = 0;
                        setState(() {});
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedOldOrders == 0
                              ? kPrimaryColor
                              : Colors.grey,
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(4))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Center(
                            child: Text(
                          YemString.currentOrders,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        myOrdersList.clear();
                        selectedOldOrders = 1;
                        setState(() {});
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedOldOrders == 0
                              ? Colors.grey
                              : kPrimaryColor,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(4))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Center(
                            child: Text(
                          YemString.oldOrders,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 14,
            key: new GlobalKey(),
            child: FutureBuilder<List<SingleOrder>?>(
              future: networkMyOrders(1, selectedOldOrders),
              builder: (BuildContext context,
                  AsyncSnapshot<List<SingleOrder>?> snapshot) {
                if (snapshot.hasData) {
                  snapshot.data!.map((e) {
                    e.items!.map((e) {}).toList();
                  }).toList();
                  //show orders
                  if (snapshot.data!.length > 0)
                    return MyOrdersView(
                        myOrdersList: snapshot.data, controller: controller);
                  else
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: Image.asset(
                              'assets/img/ic_empty.png',
                              height: 150,
                              width: 150,
                            ),
                          ),
                        ),
                        Text(
                          YemString.empty,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18.5,
                              color: Colors.black26.withOpacity(0.2)),
                        ),
                      ],
                    );

                  //Center(child: Text(YemString.no_orders_history));
                } else if (snapshot.hasError) {
                  if (snapshot.error == 'auth') {
                    return AuthErrorWidget();
                  } else
                    //show error
                    return Container(
                      child: Center(child: Text('${snapshot.error}')),
                    );
                } else {
                  //show Loading
                  return LoadingWidget(
                    isItProgressIndicator: true,
                    isItVerticalList: true,
                  );
                }
              },
            ),
          ),
        ],
      ),
    ));
  }
}
