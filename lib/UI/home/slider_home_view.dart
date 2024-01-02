import 'package:alkhalafsheep/components/loading_widget.dart';
import 'package:alkhalafsheep/provider/main_provider.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SliderWidget extends StatefulWidget {
  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  var _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    MainDataProvider data =
        Provider.of<MainDataProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: CarouselSlider(
              items: data.mainData!.sliders!.map((singleSlider) {
                return Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: CachedNetworkImage(
                          imageUrl: singleSlider.image != null &&
                                  singleSlider.image!.isNotEmpty
                              ? singleSlider.image!
                              : '',
                          errorWidget: (vtx, url, obj) {
                            return LoadingWidget();
                          },
                          placeholder: (ctx, url) {
                            return LoadingWidget();
                          },
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 0,
                      left:0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  singleSlider.text!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )),
                      ),
                    )
                  ],
                );
              }).toList(),
              options: CarouselOptions(
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1,
                initialPage: _currentPage,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                height: 190,
                onPageChanged: (pageNo, reason) {
                  setState(() {
                    _currentPage = pageNo;
                  });
                },
              ),
            ),
          ),
          Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ...data.mainData!.sliders!.map((singleString) {
                    var index = data.mainData!.sliders!.indexOf(singleString);
                    return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index
                                ? kPrimaryColor
                                : Colors.white));
                  }),
                ],
              )),
        ],
      ),
    );
  }
}
