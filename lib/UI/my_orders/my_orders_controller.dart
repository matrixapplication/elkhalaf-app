import 'package:alkhalafsheep/UI/home/home_controller.dart';
import 'package:alkhalafsheep/UI/my_orders/my_order_model.dart';
import 'package:alkhalafsheep/UI/my_orders/my_orders_view.dart';
import 'package:alkhalafsheep/components/loading_widget.dart';
import 'package:alkhalafsheep/elements/auth_error.dart';
import 'package:alkhalafsheep/network/myorders_request.dart';
import 'package:alkhalafsheep/network_models/my_orders_response.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/echo.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyOrdersController extends StatefulWidget {
  static const id = 'my_orders';

  @override
  _MyOrdersControllerState createState() => _MyOrdersControllerState();
}

class _MyOrdersControllerState extends State<MyOrdersController> {
  ScrollController controller = ScrollController();
  List<ModelMyOrders> myOrdersList = [];
  int selectedOldOrders = 0;
  bool doseUserRegister = true;

  @override
  void initState() {
    super.initState();
    controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (controller.offset == controller.position.maxScrollExtent && !controller.position.outOfRange) {
      Echo('scroll ${controller.offset}');
      Echo('scroll ${controller.position.maxScrollExtent}');
      Echo('scroll ${controller.position.outOfRange}');
      Echo('scroll');
    }
  }

  Future<bool> onBackPress() {
    if (Navigator.of(context).canPop()) {
      return Future.value(true);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, HomeController.id, (Route<dynamic> route) => false);
      return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: SafeArea(
        child: Scaffold(
          body: doseUserRegister
              ? Column(
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
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selectedOldOrders == 0 ? kPrimaryColor : Colors.grey,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Center(
                                      child: AutoSizeText(
                                    YemString.currentOrders,
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selectedOldOrders == 0 ? Colors.grey : kPrimaryColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Center(
                                      child: AutoSizeText(
                                    YemString.oldOrders,
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
                        builder: (BuildContext context, AsyncSnapshot<List<SingleOrder>?> snapshot) {
                          if (snapshot.hasData) {
                            //show orders
                            if (snapshot.data!.length > 0)
                              return MyOrdersView(myOrdersList: snapshot.data, controller: controller);
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
                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.5, color: Colors.black26.withOpacity(0.2)),
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
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[AuthErrorWidget()],
                  ),
                ),
        ),
      ),
    );
  }
}
