import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_brand_icons/flutter_brand_icons.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'dart:io';

class TryStripe extends StatefulWidget {
  static const String routeName = "/trystripe";

  @override
  _TryStripeState createState() => _TryStripeState();
}

class _TryStripeState extends State<TryStripe> {
  Token _paymentToken;

  PaymentMethod _paymentMethod;

  String _error;

  PaymentIntentResult _paymentIntent;

  Source _source;

  final String _price = "15";

  ScrollController _controller = ScrollController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  initState() {
    super.initState();

    StripePayment.setOptions(
      StripeOptions(
          publishableKey:
              "pk_test_51IAJMCLLNnupcx6DoltDIDqYt5Ftaa16qOyQG7pE4EbgfqePRaa2zBmCka8E04O1sIoN4PTRP0ZKZGJMF3AP1oSv00gXfDibQa",
          merchantId: "Test",
          androidPayMode: 'test'),
    );
  }

  void setError(dynamic error) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _error = error.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Plugin example app'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  _source = null;
                  _paymentIntent = null;
                  _paymentMethod = null;
                  _paymentToken = null;
                });
              },
            )
          ],
        ),
        body: ListView(
          controller: _controller,
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            RaisedButton(
              child: Icon(
                Icons.credit_card,
                size: 50.0,
                color: Colors.black,
              ),
              color: Colors.white,
              onPressed: () {
                StripePayment.paymentRequestWithCardForm(
                        CardFormPaymentRequest())
                    .then((paymentMethod) {
                  _scaffoldKey.currentState.showSnackBar(
                      SnackBar(content: Text('Received ${paymentMethod.id}')));
                  setState(() {
                    _paymentMethod = paymentMethod;
                  });
                }).catchError(setError);
              },
            ),
            Divider(
              height: 3,
              color: Colors.blueGrey,
            ),
            RaisedButton(
              child: Platform.isIOS
                  ? Icon(
                      BrandIcons.applepay,
                      size: 65.0,
                    )
                  : Image(
                      image: AssetImage(
                        "assets/images/google_pay.png",
                      ),
                    ),
              color: Colors.white,
              onPressed: () {
                if (Platform.isIOS) {
                  _controller.jumpTo(450);
                }
                StripePayment.paymentRequestWithNativePay(
                  androidPayOptions: AndroidPayPaymentRequest(
                    totalPrice: _price,
                    currencyCode: "EUR",
                  ),
                  applePayOptions: ApplePayPaymentOptions(
                    countryCode: 'IT',
                    currencyCode: 'EUR',
                    items: [
                      ApplePayItem(
                        label: 'Test',
                        amount: _price,
                      )
                    ],
                  ),
                ).then((token) {
                  setState(() {
                    _scaffoldKey.currentState.showSnackBar(
                        SnackBar(content: Text('Received ${token.tokenId}')));
                    _paymentToken = token;
                  });
                }).catchError(setError);
              },
            ),
            RaisedButton(
              child: Text(
                "Completa il Pagamento",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Colors.white,
              onPressed: () {
                StripePayment.completeNativePayRequest().then((_) {
                  _scaffoldKey.currentState.showSnackBar(
                      SnackBar(content: Text('Completed successfully')));
                }).catchError(setError);
              },
            ),
            Divider(),
            Text('Current source:'),
            Text(
              JsonEncoder.withIndent('  ').convert(_source?.toJson() ?? {}),
              style: TextStyle(fontFamily: "Monospace"),
            ),
            Divider(),
            Text('Current token:'),
            Text(
              JsonEncoder.withIndent('  ')
                  .convert(_paymentToken?.toJson() ?? {}),
              style: TextStyle(fontFamily: "Monospace"),
            ),
            Divider(),
            Text('Current payment method:'),
            Text(
              JsonEncoder.withIndent('  ')
                  .convert(_paymentMethod?.toJson() ?? {}),
              style: TextStyle(fontFamily: "Monospace"),
            ),
            Divider(),
            Text('Current payment intent:'),
            Text(
              JsonEncoder.withIndent('  ')
                  .convert(_paymentIntent?.toJson() ?? {}),
              style: TextStyle(fontFamily: "Monospace"),
            ),
            Divider(),
            Text('Current error: $_error'),
          ],
        ),
      ),
    );
  }
}
