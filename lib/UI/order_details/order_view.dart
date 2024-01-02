import 'package:alkhalafsheep/_helpers/shared_pref.dart';
import 'package:alkhalafsheep/components/loading_widget.dart';
import 'package:alkhalafsheep/models/profile_model.dart';
import 'package:alkhalafsheep/network/apis.dart';
import 'package:alkhalafsheep/network_models/my_orders_response.dart';
import 'package:alkhalafsheep/network_models/response_status.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:provider/provider.dart';

class OrderDescriptionView extends StatefulWidget {
  final SingleOrder? modelMyOrders;

  OrderDescriptionView({this.modelMyOrders});

  @override
  _OrderDescriptionViewState createState() => _OrderDescriptionViewState();
}

class _OrderDescriptionViewState extends State<OrderDescriptionView> {
  bool loading = false;
  double? _rating = 0;
  TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.modelMyOrders!.rating != null ||
        widget.modelMyOrders!.rating != 0) {
      _rating = widget.modelMyOrders!.rating;
    }
    if (widget.modelMyOrders!.ratingNote != null ||
        widget.modelMyOrders!.ratingNote != '') {
      _noteController.text = widget.modelMyOrders!.ratingNote;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return loading
        ? LoadingWidget(isItProgressIndicator: true)
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  //Order details
                  Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: Text(
                          '${YemString.the_order}  ${widget.modelMyOrders!.orderCode}')),
                  singleRowText(YemString.vat, '${widget.modelMyOrders!.vat}',
                      null, width),
                  singleRowText(YemString.shipping,
                      '${widget.modelMyOrders!.shipping}', null, width),
                  singleRowText(YemString.total,
                      '${widget.modelMyOrders!.totla}', null, width),
                  singleRowText(YemString.note, '${widget.modelMyOrders!.note}',
                      null, width),

                  //Payment Details
                  if (widget.modelMyOrders!.payOption is PayOptionClass)
                    Column(
                      children: [
                        Container(
                            color: Colors.grey.shade200,
                            padding: EdgeInsets.all(8.0),
                            width: double.infinity,
                            child: Text('${YemString.payment}')),
                        singleRowText(
                            YemString.name,
                            '${widget.modelMyOrders!.payOption.name}',
                            null,
                            width),
                        singleRowText(
                            YemString.bank_name,
                            '${widget.modelMyOrders!.payOption.serviceName}',
                            null,
                            width),
                        singleRowText(
                            YemString.number,
                            '${widget.modelMyOrders!.payOption.number}',
                            null,
                            width),
                        singleRowText(
                            'IBAN',
                            '${widget.modelMyOrders!.payOption.ibanNumber}',
                            null,
                            width),
                      ],
                    ),

                  if (widget.modelMyOrders!.payOption is String)
                    singleRowText(YemString.payment,
                        widget.modelMyOrders!.payOption, null, width),

                  //Item details
                  Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: Text('${YemString.products}')),

                  if (widget.modelMyOrders!.items != null && widget.modelMyOrders!.items!.length > 0)
                    ...widget.modelMyOrders!.items!.map((singleProduct) {
                      return Container(
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(color: Colors.grey, width: 0.4),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: Row(children: <Widget>[
//                          Flexible(
//                            flex: 1,
//                            child: CachedNetworkImage(
//                              imageUrl: singleProduct.photo != null ? BASE_URL_IMAGE_PATH + singleProduct.photo : '',
//                              fit: BoxFit.fitHeight,
//                              placeholder: (ctx, url) {
//                                return Image.asset(
//                                  'assets/img/logo_white_bk.png',
//                                  fit: BoxFit.fitHeight,
//                                );
//                              },
//                            ),
//                          ),
                          Flexible(
                            flex: 3,
                            child: Column(
                              children: <Widget>[
                                singleRowText(YemString.name,
                                    singleProduct.name!, null, width),
                                //Weight
                                if (singleProduct.weight != '' &&
                                    singleProduct.weight != '0' &&
                                    singleProduct.weight != null)
                                  singleRowText(YemString.weight,
                                      '${singleProduct.weight}', null, width),
                                //Original price
                                singleRowText(YemString.price,
                                    '${singleProduct.price}', null, width),

//                                //discount
//                                if (singleProduct.discount != null && singleProduct.discount != 0)
//                                  singleRowText(YemString.discount, '${singleProduct.discount}%'),

//                                //price after discount
//                                if (singleProduct.discount != null && singleProduct.discount != 0)
//                                  singleRowText(YemString.price_after_discount, '${(singleProduct.price - (singleProduct.price * singleProduct.discount) / 100)}'),

                                //chopping
                                if (singleProduct.chopping != '' &&
                                    singleProduct.chopping != '0' &&
                                    singleProduct.chopping != null)
                                  singleRowText(YemString.choppingType,
                                      '${singleProduct.chopping}', null, width),

                                //Note
                                if (singleProduct.note != '' &&
                                    singleProduct.note != null)
                                  singleRowText(YemString.note,
                                      '${singleProduct.note}', null, width),
                                //quantity
                                singleRowText(YemString.quantity,
                                    '${singleProduct.quantity}', null, width),

                                //Weight
                                if (singleProduct.weight != null)
                                  singleRowText(YemString.weight,
                                      '${singleProduct.weight}', null, width),

//                                //Packages
//                                if (singleProduct.selectedPackage != null)
//                                  singleRowText('التغليف', '${singleProduct.selectedPackage.title}',
//                                      singleProduct.selectedPackage.price, width),

                                //Meat
                                if (singleProduct.minced != null)
                                  singleRowText(
                                      'اللحم المفروم',
                                      '${singleProduct.minced}',
                                      singleProduct.mincedPrice,
                                      width),

                                //Cuts
                                if (singleProduct.chopping != null)
                                  singleRowText('التقطيع',
                                      '${singleProduct.chopping}', null, width),

                                //Cuts
                                if (singleProduct.cooking != null)
                                  singleRowText('الطبخ',
                                      '${singleProduct.cooking}', null, width),

                                //Cuts
                                if (singleProduct.rice != null)
                                  singleRowText('الأرز',
                                      '${singleProduct.rice}', null, width),

                                //Note
                                if (singleProduct.note != null &&
                                    singleProduct.note != '')
                                  singleRowText(YemString.note,
                                      '${singleProduct.note}', null, width),
                              ],
                            ),
                          )
                        ]),
                      );
                    }).toList(),
//            if(widget.modelMyOrders.rate != null)
//              singleRowText(YemString.rate, '${widget.modelMyOrders.rate}'),
//            if(widget.modelMyOrders.rate != null)
//              singleRowText(YemString.rateNote, '${widget.modelMyOrders.rateNote}'),
//            if(widget.modelMyOrders.rate == null)
                  if (!Provider.of<ProfileModel>(context, listen: false)
                      .isAdmin!)
                    Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: Text('${YemString.rateOrder}')),
//            if(widget.modelMyOrders.rate == null)

                  if (!Provider.of<ProfileModel>(context, listen: false)
                      .isAdmin!)
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            GFRating(
                              allowHalfRating: false,
                              value: _rating!,
                              onChanged: (value) {
                                setState(() {
                                  _rating = value;
                                });
                              },
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 0.4),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: YemString.rateNote),
                                minLines: 3,
                                maxLines: 6,
                                controller: _noteController,
                              ),
                            ),
                            GFButton(
                                color: kPrimaryColor,
                                onPressed: () {
                                  networkAddRate(widget.modelMyOrders!.id,
                                      _rating, _noteController.text.trim());
                                },
                                text: YemString.send),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          );
  }

  void networkAddRate(int? orderId, double? rate, String comment) async {
    setState(() {
      loading = true;
    });
    YemenyPrefs prefs = YemenyPrefs();
    String? lang = await prefs.getLang();
    String? token = await prefs.getToken();

    try {
      Dio dio = Dio();
      dio.interceptors.add(LogInterceptor(responseBody: true));
      dio.options.headers['Content-Language'] = lang;
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["authorization"] = "Bearer $token";

      Map<String, dynamic> queryParameters = Map();
      queryParameters['rating'] = rate;
      queryParameters['rating_note'] = comment;

      Response response = await dio
          .post('$kRateOrder/$orderId', queryParameters: queryParameters)
          .whenComplete(() {});

      final basicJsonResponse = JsonBasicResponse.fromJson(response.data);
      if (basicJsonResponse.status == YemString.successNoTranslate) {
        widget.modelMyOrders!.rating = rate;
        widget.modelMyOrders!.ratingNote = comment;

        Flushbar(
          titleText: Text(''),
          message: 'تم التقييم بنجاح',
          duration: Duration(seconds: 2),
          flushbarPosition: FlushbarPosition.BOTTOM,
          backgroundColor: kPrimaryColor,
        )..show(context);

        setState(() {});
      } else {}
      setState(() {
        loading = false;
      });
    } on DioError catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  Widget singleRowText(String title, String text, int? price, double width) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
                flex: 2,
                child: Text(title,
                    style: TextStyle(color: Colors.black54, fontSize: 13))),
            Flexible(
              flex: 3,
              child: Container(
//                width: width / 2.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      text,
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                    ),
                    if (price != null && price != 0) SizedBox(width: 2),
                    if (price != null && price != 0)
                      Text(
                        '($price ر.س )',
                        style: TextStyle(color: Colors.black54, fontSize: 12),
                        textAlign: TextAlign.end,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
