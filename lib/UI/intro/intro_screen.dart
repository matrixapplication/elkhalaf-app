library flutter_walkthrough;

import 'package:alkhalafsheep/UI/address/address_controller.dart';
import 'package:alkhalafsheep/_helpers/shared_pref.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  static const id = 'IntroScreen';

  void skipPage(BuildContext context) async {
    YemenyPrefs prefs = YemenyPrefs();
    prefs.setFirstTimeVisit(false);

    Navigator.pushReplacementNamed(context, AddressController.id);
  }

  @override
  IntroScreenState createState() {
    return IntroScreenState();
  }
}

class IntroScreenState extends State<IntroScreen> {
  final List<WalkThrough> walkThroughList = [
    WalkThrough(
      title: YemString.walkThroughTitle1,
      content: YemString.walkThroughBody1,
      imageUrl: YemString.iWalkThrough1,
    ),
    WalkThrough(
      title: YemString.walkThroughTitle2,
      content: YemString.walkThroughBody2,
      imageUrl: YemString.iWalkThrough2,
    ),
    WalkThrough(
      title: YemString.walkThroughTitle3,
      content: YemString.walkThroughBody3,
      imageUrl: YemString.iWalkThrough3,
    ),
    WalkThrough(
      title: YemString.walkThroughTitle4,
      content: YemString.walkThroughBody4,
      imageUrl: YemString.iWalkThrough4,
    ),
  ];

  final PageController controller = PageController();
  int currentPage = 0;
  bool lastPage = false;

  void _onPageChanged(int page) {
    setState(() {
      currentPage = page;
      if (currentPage == walkThroughList.length - 1) {
        lastPage = true;
      } else {
        lastPage = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFEEEEEE),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 4,
            child: PageView(
              children: walkThroughList,
              controller: controller,
              onPageChanged: _onPageChanged,
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                /***************  NEXT ***********/
                ElevatedButton(
                  child: Text(lastPage ? "" : YemString.skip,
                      style: kTextBlackBoldHeader),
                  onPressed: () => lastPage ? null : widget.skipPage(context),
                ),
                /***************  Indicators ***********/
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ...this.walkThroughList.map((singleString) {
                      var index = this.walkThroughList.indexOf(singleString);
                      return Container(
                          width: this.currentPage == index ? 16 : 8,
                          height: this.currentPage == index ? 16 : 8,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: this.currentPage == index
                                  ? kPrimaryColor
                                  : Colors.grey));
                    }),
                  ],
                ),
                /***************  Next or GOT IT ***********/
                ElevatedButton(
                  child: Text(lastPage ? YemString.gotIt : YemString.next,
                      style: kTextBlackBoldHeader),
                  onPressed: () => lastPage
                      ? widget.skipPage(context)
                      : controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class WalkThrough extends StatefulWidget {
  final title;
  final content;
  final imageUrl;

  WalkThrough({
    this.title,
    this.content,
    this.imageUrl,
  });

  @override
  WalkThroughState createState() {
    return WalkThroughState();
  }
}

class WalkThroughState extends State<WalkThrough> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Material(
        elevation: 2.0,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            image(),
            title(),
            descriptions(),
          ],
        ),
      ),
    );
  }

  Widget image() {
    return Image.asset(
      widget.imageUrl,
      width: 200,
    );
  }

  Widget title() {
    return Text(
      widget.title,
      style: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  Widget descriptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(widget.content,
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15.0,
              color: Colors.black)),
    );
  }
}
