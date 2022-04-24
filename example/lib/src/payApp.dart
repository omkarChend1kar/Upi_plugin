import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upi_plugin/upi_plugin.dart';

import 'components/upiapps.dart';



class PayApp extends StatefulWidget {
  const PayApp({Key? key}) : super(key: key);

  @override
  State<PayApp> createState() => _PayAppState();
}

class _PayAppState extends State<PayApp> {
  final String _pa = "8879369452@ybl";
  final String _pn = 'Omkar';
  final String _am = '10.00';
  final String _tn = 'Payment from Omkar';
  static const String _cu = 'INR';
  static const String _mode = '04';
  static const String _orgId = '000000';
  static const String? _url = null; /*'omkar.chend1kar@gmail.com';*/
  static const String? _mc =null; /*'110100';*/
  static const String? _tr = null; /*'110100ejt';*/

  String responseText = 'No response yet';

  Future<String> initiateTransaction(String appName) async {
    String response = await UpiTransaction.initiateTransaction(
      app: appName,
      pa: _pa,
      pn: _pn,
      mc: _mc,
      tr: _tr,
      tn: _tn,
      am: _am,
      cu: _cu,
      url: _url,
      mode: _mode,
      orgid: _orgId,
    );
    setState(() {
      responseText = response;
    });
    print(response);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(responseText),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoButton(
                    color: Colors.black87,
                    child: Text('Gpay'),
                    onPressed: () {
                      initiateTransaction(UpiApps.GooglePay);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoButton(
                    color: Colors.black87,
                    child: Text('PhonePe'),
                    onPressed: () {
                      initiateTransaction(UpiApps.PhonePe);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoButton(
                    color: Colors.black87,
                    child: Text('PayTM'),
                    onPressed: () {
                      initiateTransaction(UpiApps.PayTM);
                    },
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
