import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  final count = 20;
  final bool isItProgressIndicator;
  final bool isItVerticalList;

  LoadingWidget(
      {this.isItProgressIndicator = false, this.isItVerticalList = false});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return isItProgressIndicator
        ? progressIndicator()
        : isItVerticalList ? verticalList(width) : Container();
  }

  Widget progressIndicator() {
    return Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget verticalList(double width) {
    List<Widget> widgetList = [];
    for (int i = 0; i < count; i++) {
      widgetList.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: 50,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    height: 15, width: (width - 82) * 0.8, color: Colors.grey),
                SizedBox(
                  height: 8,
                ),
                Container(height: 15, width: width / 3, color: Colors.grey),
              ],
            ),
          )
        ],
      ));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.blueGrey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ...widgetList.map((singleList) {
                return singleList;
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
