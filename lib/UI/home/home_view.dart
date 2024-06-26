import 'package:alkhalafsheep/UI/home/slider_home_view.dart';
import 'package:alkhalafsheep/UI/home/special_products_home.dart';
import 'package:alkhalafsheep/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _loading = false;

  @override
  deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MainDataProvider data = Provider.of<MainDataProvider>(context, listen: false);

    return Scaffold(
      body: _loading
          ? Container()
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  if (data.mainData!.sliders != null && data.mainData!.sliders!.length > 0) SliderWidget(),

                  // if(data.mainData.video != null && data.mainData.video.isNotEmpty)
                  // YoutubeView(url: data.mainData.video),

                  // if(data.mainData.categories != null && data.mainData.categories.length>0)
                  //   CategoriesHome(),

                  // Special products offers
                  if (data.mainData!.products != null && data.mainData!.products!.where((element) => element.showInSpecialOffer!).length > 0)
                    SpecialProductsOffer(),

                  SizedBox(height: 20)
                ],
              ),
            ),
    );
  }
}
