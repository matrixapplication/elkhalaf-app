//import 'package:mhaki/const/_const.dart';
//import 'package:flutter/material.dart';
//import 'package:mhaki/models/route_argument.dart';
//import 'package:photo_view/photo_view.dart';
//
//class PhotoViewWidget extends StatelessWidget {
//  static const String id = '/photo_view';
//  final RouteArgument argument;
//
//  PhotoViewWidget({Key key, @required this.argument}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    String brand = argument.heroTag;
//    String url = argument.param;
//    return new Scaffold(
//      appBar: new AppBar(
//        backgroundColor: PRIMARY_COLOR,
//        centerTitle: true,
//        title: Text(
//          brand,
//          style: TextStyle(color: Colors.white),
//        ),
//      ),
//      body: Container(child: PhotoView(imageProvider: NetworkImage(url))),
//    );
//  }
//}
