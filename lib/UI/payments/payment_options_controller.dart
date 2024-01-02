import 'package:alkhalafsheep/elements/CircularLoadingWidget.dart';
import 'package:alkhalafsheep/elements/auth_error.dart';
import 'package:alkhalafsheep/elements/no_internet_conn.dart';
import 'package:alkhalafsheep/elements/server_error.dart';
import 'package:alkhalafsheep/models/payment_model.dart';
import 'package:alkhalafsheep/network/network_payments.dart';
import 'package:alkhalafsheep/network/apis.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PaymentOptionsController extends StatefulWidget {
  @override
  _PaymentOptionsControllerState createState() => _PaymentOptionsControllerState();
}

class _PaymentOptionsControllerState extends State<PaymentOptionsController> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<PaymentModel>>(
            future: networkPaymentOptions(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          ...snapshot.data!.map((e) {
                            return paymentOption(e);
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                if (snapshot.error == null) {
                  return ServerErrorWidget(refresh: () {
                    setState(() {
                      _scaffoldKey = new GlobalKey<ScaffoldState>();
                    });
                  });
                }
                if (snapshot.error == 'server') {
                  return ServerErrorWidget(refresh: () {
                    setState(() {
                      _scaffoldKey = new GlobalKey<ScaffoldState>();
                    });
                  });
                }
                if (snapshot.error == 'network') {
                  return NoInternetConnection(refresh: () {
                    setState(() {
                      _scaffoldKey = new GlobalKey<ScaffoldState>();
                    });
                  });
                }
                if (snapshot.error == 'auth') {
                  return AuthErrorWidget();
                }
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(' ${snapshot.error.toString()}'),
                  ),
                );
              } else
                return CircularLoadingWidget();
            },
          )),
    );
  }


  Widget paymentOption(PaymentModel e) {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(e.serviceName!, style: kTextBlackBody),
                          CachedNetworkImage(
                            imageUrl: e.logo != null
                                ? BASE_URL_IMAGE_PATH + e.logo!
                                : '',
                            fit: BoxFit.cover,
                            height: 30,
                            placeholder: (ctx, url) {
                              return Container();
                            },
                          ),
                        ],
                      ),

                      if (e.number!.length > 2)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('رقم الحساب', style: kTextBlackFooter),
                            Text('${e.number}', style: kTextBlackFooter),
                          ],
                        ),
                      if (e.ibanNumber.length > 2)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('IBAN', style: kTextBlackFooter),
                            Text('${e.ibanNumber}', style: kTextBlackFooter),
                          ],
                        ),
                      if (e.name != null)
                        Divider(),
                      if (e.name != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('اسم صاحب الحساب', style: kTextBlackFooter),
                            Text('${e.name}', style: kTextBlackFooter),
                          ],
                        ),

                    ],
                  ),
                ),
                // if (e.ibanNumber.length > 2)
                //   if (e.id == _showBankInformationId)
                //     if (_showBankInformation)
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 4),
                //         child: Center(
                //           child: Text(
                //             'عزيزي العميل عند اخيارك لطريقة الدفع عن طريق التحويل لن يتم تأكيد الطلب إلا عند إرسال صوره الحوالة عن طريق رقم الواتس المتوفر في تطبيقنا',
                //             style: TextStyle(fontSize: 12, color: Colors.grey),
                //           ),
                //         ),
                //       )
              ],
            ),
          ),
        ],
      ),
    );
  }

}
