import 'package:alkhalafsheep/network_models/my_orders_response.dart';
import 'package:flutter/material.dart';
import 'package:alkhalafsheep/UI/order_details/order_controller.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';


class MyOrdersView extends StatefulWidget {
  final List<SingleOrder>? myOrdersList;
  final ScrollController? controller;

  MyOrdersView({this.myOrdersList, this.controller});

  @override
  _MyOrdersViewState createState() => _MyOrdersViewState();
}

class _MyOrdersViewState extends State<MyOrdersView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: widget.myOrdersList!.length > 0
          ? ListView.builder(
              controller: widget.controller,
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) => buildItem(
                index: index,
                context: context,
                data: widget.myOrdersList![index],
              ),
              itemCount: widget.myOrdersList!.length,
              reverse: false,
//              controller: listScrollController,
            )
          : Center(child: Text('')),
    );
  }

  Widget singleRowText(String title, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(flex: 4, child: Text(title, style: kTextGreyBody)),
          Flexible(flex: 6, child: Text(text, style: kTextGreyBody)),
        ],
      ),
    );
  }

  buildItem({int? index, BuildContext? context, required SingleOrder data}) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 0.2)),
      child: Column(
        children: <Widget>[
          Container(
              color: Colors.grey.shade200,
              padding: EdgeInsets.all(8.0),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${YemString.the_order.toString()}  ${data.orderCode.toString()}'),
                  InkWell(
                      onTap: () {
                        Navigator.of(context!).push(SwipeablePageRoute(
                          builder: (BuildContext context) => OrderDescriptionController(
                            modelMyOrders: widget.myOrdersList![index!],
                          ),
                        ));
//                        Navigator.push(
//                          context,
//                          PageRouteBuilder(
//                            pageBuilder: (context, animation1, animation2) =>
//                                OrderDescriptionController(
//                              modelMyOrders: widget.myOrdersList[index],
//                            ),
//                            transitionsBuilder:
//                                (context, animation1, animation2, child) =>
//                                    FadeTransition(
//                                        opacity: animation1, child: child),
//                            transitionDuration: Duration(milliseconds: 600),
//                          ),
//                        );
                      },
                      child: Text('${YemString.details}',
                          style: TextStyle(color: Colors.blueAccent))),
                ],
              )),
          if(data.items != null)
          singleRowText(YemString.products_count, '${data.items!.length}'),
//        singleRowText(YemString.vat, '${data.vat}'),
//        singleRowText(YemString.shipping, '${data.shipping}'),
//        singleRowText(YemString.total, '${data.totla}'),
//        singleRowText(YemString.payment, '${data.payOption.name}'),
          singleRowText(YemString.status, '${data.status}'),
          if (data.rating != null && data.rating != 0)
            singleRowText(YemString.rate, '${data.rating}'),
          if (data.ratingNote != null)
            singleRowText(YemString.rateNote, '${data.ratingNote}'),
        ],
      ),
    );
  }
}
