import 'package:alkhalafsheep/UI/my_orders/my_order_model.dart';
import 'package:alkhalafsheep/UI/order_details/order_status.dart';
import 'package:alkhalafsheep/UI/order_details/order_view.dart';
import 'package:alkhalafsheep/network_models/my_orders_response.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/echo.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:flutter/material.dart';

class OrderDescriptionController extends StatefulWidget {
  static const id = 'orderDescription';
  final SingleOrder? modelMyOrders;

  OrderDescriptionController({this.modelMyOrders});

  @override
  _OrderDescriptionControllerState createState() =>
      _OrderDescriptionControllerState();
}

class _OrderDescriptionControllerState
    extends State<OrderDescriptionController> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              title: Text(
                YemString.my_orders,
                style: kWhiteTextColor,
              ),
              backgroundColor: kPrimaryColor,
              centerTitle: true,
          bottom: TabBar(tabs: <Widget>[
            Tab(child: Text('حالة الطلب'),),
            Tab(child: Text('تفاصيل الطلب'),),

          ],),),
          body: TabBarView(
            children: [
              OrderStatus(modelMyOrders: widget.modelMyOrders,),
              OrderDescriptionView(
                modelMyOrders: widget.modelMyOrders,
              ),
            ],
          ),

        ),
      ),
    );
  }
}
