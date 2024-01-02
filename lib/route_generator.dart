import 'package:alkhalafsheep/network_models/checkout_response.dart';
import 'package:alkhalafsheep/network_models/main_response.dart';
import 'package:flutter/material.dart';
import 'package:alkhalafsheep/UI/cart_provider/cart_provider_controller.dart';
import 'package:alkhalafsheep/UI/checkout/checkout_controller.dart';
import 'package:alkhalafsheep/UI/checkout/payment_methods_controller.dart';
import 'package:alkhalafsheep/UI/checkout/shipping_address.dart';
import 'package:alkhalafsheep/UI/checkout/success_create_order_view.dart';
import 'package:alkhalafsheep/UI/home/home_controller.dart';
import 'package:alkhalafsheep/UI/login/login_controller.dart';
import 'package:alkhalafsheep/UI/product/product_controller.dart';
import 'package:alkhalafsheep/UI/products/products_controller.dart';
import 'package:alkhalafsheep/UI/register/register_controller.dart';

import 'UI/intro/intro_screen.dart';
import 'UI/splash/splash_controller.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case SplashScreen.id:
        return MaterialPageRoute(builder: (_) => SplashScreen());
        break;
      case IntroScreen.id:
        return MaterialPageRoute(builder: (_) => IntroScreen());
        break;
      case HomeController.id:
        return MaterialPageRoute(builder: (_) => HomeController());
        break;

    case RegisterController.id:
        return MaterialPageRoute(builder: (_) => RegisterController());
        break;

      case LoginController.id:
        return MaterialPageRoute(builder: (_) => LoginController());
        break;
      case ProductController.id:
        return MaterialPageRoute(builder: (_) => ProductController(product: args as Product?,));
        break;
      case CartProviderController.id:
        return MaterialPageRoute(builder: (_) => CartProviderController(showAppBar: args as bool?,));
        break;
      case ProductsController.id:
        return MaterialPageRoute(builder: (_) => ProductsController(products: args as List<Product>?,));
        break;
      case PaymentOptionsController.id:
        return MaterialPageRoute(builder: (_) => PaymentOptionsController());
        break;
      case ShippingAddress.id:
        return MaterialPageRoute(builder: (_) => ShippingAddress());
        break;
      case CheckoutController.id:
        return MaterialPageRoute(builder: (_) => CheckoutController(checkoutResponse: args as CheckoutResponse?,));
        break;
      case SuccessCreateOrderView.id:
        return MaterialPageRoute(builder: (_) => SuccessCreateOrderView());
        break;
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(body: SafeArea(child: Center(child: Text('Route Error ${settings.name}')))));
    }
  }
}
