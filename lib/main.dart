import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:isw_mobile_sdk/isw_mobile_sdk.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _amountString = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      String merchantId = "IKIAB23A4E2756605C1ABC33CE3C287E27267F660D61";
      String merchantCode = "MX6072";
      String merchantKey = "secret";

      var config = new IswSdkConfig(merchantId, merchantKey, merchantCode, "566");

      // initialize the sdk
      await IswMobileSdk.initialize(config,Environment.TEST);
      // intialize with environment, default is Environment.TEST
      // IswMobileSdk.initialize(config, Environment.SANDBOX);

    } on PlatformException {}
  }

  Future<void> pay(BuildContext context) async {
    // save form
    // this._formKey.currentState.save();

    String customerId = "your+customer+id",
        customerName = "James Emmanuel",
        customerEmail = "kenneth.ngedo@gmail.com",
        customerMobile = "08031149929",
        reference = "pay" + DateTime.now().millisecond.toString();

    int amount;
    // initialize amount
    if (this._amountString.length == 0)
      amount = 2500 * 100;
    else
      amount = int.parse(this._amountString) * 100;

    // create payment info
    IswPaymentInfo iswPaymentInfo = new IswPaymentInfo(customerId, customerName,
        customerEmail, customerMobile, reference, amount);

    print(iswPaymentInfo);

    // trigger payment
    var result = await IswMobileSdk.pay(iswPaymentInfo);

    var message;
    if (result.hasValue) {
      message = "You completed txn using: " + result.value.channel.toString();
    } else {
      message = "You cancelled the transaction pls try again";
    }
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(message),
      duration: Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Charity Fortune'),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: new Form(
              key: this._formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    keyboardType: TextInputType.number,
                    onChanged: (String val) {
                      this._amountString = val;
                    },
                  ),
                  Builder(
                    builder: (ctx) => new Container(
                      width: MediaQuery.of(ctx).size.width,
                      child: RaisedButton(
                        child: Text(
                          "Pay",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () => pay(ctx),
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
