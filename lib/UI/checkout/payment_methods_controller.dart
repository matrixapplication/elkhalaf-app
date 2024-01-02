import 'package:flutter/material.dart';
import 'package:alkhalafsheep/UI/checkout/payment_method_view.dart';
import 'package:alkhalafsheep/components/loading_widget.dart';
import 'package:alkhalafsheep/elements/auth_error.dart';
import 'package:alkhalafsheep/elements/server_error.dart';
import 'package:alkhalafsheep/network/requests.dart';
import 'package:alkhalafsheep/network_models/payment_options_response.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';

class PaymentOptionsController extends StatefulWidget {
  static const String id = 'payment';

  @override
  _PaymentOptionsControllerState createState() =>
      _PaymentOptionsControllerState();
}

class _PaymentOptionsControllerState extends State<PaymentOptionsController> {
  var _scaffold = new GlobalKey<ScaffoldState>();
  var _key = new GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: SafeArea(
        child: Scaffold(
          key: _scaffold,
          appBar: AppBar(
              title: Text(
                YemString.payment_options,
                style: kWhiteTextColor,
              ),
              backgroundColor: kPrimaryColor,
              centerTitle: true),
          body: FutureBuilder<PaymentMethods?>(
            key: _key,
            future: NetworkRequests().paymentOptionsRequest(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PaymentMethodView(list: snapshot.data!.data);
              } else if (snapshot.hasError) {
                if (snapshot.error == 'auth') {
                  return AuthErrorWidget(
                    refresh: () {
                      _key = new GlobalKey();
                      setState(() {});
                    },
                  );
                } else if (snapshot.error == 'server') {
                  return ServerErrorWidget(
                    refresh: () {
                      _key = new GlobalKey();
                      setState(() {});
                    },
                  );
                } else
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
      ),
    );
  }
}
