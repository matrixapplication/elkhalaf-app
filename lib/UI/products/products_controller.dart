import 'package:flutter/material.dart';
import 'package:alkhalafsheep/UI/cart_provider/cart_provider_controller.dart';
import 'package:alkhalafsheep/UI/home/home_controller.dart';
import 'package:alkhalafsheep/elements/empty_error.dart';
import 'package:alkhalafsheep/elements/product_vertical.dart';
import 'package:alkhalafsheep/network_models/main_response.dart';
import 'package:alkhalafsheep/provider/cart_provider.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:provider/provider.dart';

class ProductsController extends StatelessWidget {
  static const String id = 'products';
  final List<Product>? products;

  ProductsController({this.products});

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: true);
    return Container(
      color: kPrimaryColor,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(CartProviderController.id, arguments: true);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    child: Center(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          cartProvider.cart == null ||
                                  cartProvider.cart!.length < 1
                              ? Text(
                                  '',
                                  style: TextStyle(
                                      fontSize: 13.0, color: kPrimaryColor),
                                )
                              : CircleAvatar(
                                  radius: 8.6,
                                  backgroundColor: Colors.blueGrey,
                                  child: Text(
                                    '${cartProvider.cart!.length}',
                                    style: TextStyle(
                                        fontSize: 10.0, color: Colors.white),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: floatingWidget(context),
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: buildBottomNavigationBar(context),
            body: products == null || products!.length < 1
                ? EmptyErrorWidget()
                : GridView.count(
                    shrinkWrap: true,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                    crossAxisCount: 2,
                    primary: false,
                    children: [
                      ...products!.map((product) {
                        return SingleProductVertical(
                          product: product,
                        );
                      }).toList(),
                    ],
                  )),
      ),
    );
  }
  BottomAppBar buildBottomNavigationBar(BuildContext context) {
    return BottomAppBar(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: CircularNotchedRectangle(),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
        fixedColor: Colors.white70,
        backgroundColor: kPrimaryColor,
        unselectedItemColor: Colors.white70,
        onTap: (value) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => HomeController(pageNumber: value),
              ),
                  (route) => false);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.local_offer), label: YemString.offers),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'راسلنا',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_drop_down), label: YemString.home),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                size: 24.0,
              ),
              label: YemString.account),
          BottomNavigationBarItem(
              icon: Icon(Icons.reorder), label: YemString.my_orders),
        ],
      ),
    );
  }

  Widget floatingWidget(BuildContext context) {
    return FloatingActionButton(
      onPressed: ()  {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => HomeController(pageNumber: 2),
            ),
                (route) => false);
      },
      backgroundColor: Colors.white,
      child: Image.asset(kLogoPath),
    );
  }

}
