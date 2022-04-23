import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:upi_plugin/upi_plugin.dart';
import 'package:upi_plugin_example/src/validators.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with validationMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController vpaController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static String? appPackageName;

  static String? _pa = "cloudyml@icici";
  static String? _pn = 'Omkar';
  static String? _am = '10.00';
  static String? _tn = 'Payment from Omkar';
  static String? _cu = 'INR';
  static String? _mode = '04';
  static String? _orgId = '000000';

  static String _url = 'omkar.chend1kar@gmail.com';

  static String _mc = '110100';

  static String _tr = '110100ejt';

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
    print(response);
    return response;
  }

  void setPackageNameforGpay() {
    setState(() {
      appPackageName = 'com.google.android.apps.nbu.paisa.user';
    });
  }

  void setPackageNameforPhonePe() {
    setState(() {
      appPackageName = 'com.phonepe.app';
    });
  }

  bool isPackageNameGpay = true;

  void collectLinkSpecifications() {
    setState(() {
      _pn = nameController.text;
      _pa = vpaController.text;
      _am = amountController.text;
      _tn = noteController.text;
    });
  }

  static const _methodChannel = MethodChannel('pay_with_upi');

  void initState() {
    super.initState();
    amountController.text;
    vpaController.text;
    nameController.text;
    noteController.text;
    setPackageNameforGpay();
    setPackageNameforPhonePe();
  }

  void dispose() {
    noteController.dispose();
    amountController.dispose();
    nameController.dispose();
    vpaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pay with UPI'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // TextFormField(
                    //   keyboardType: TextInputType.name,
                    //   controller: nameController,
                    //   validator: validateName,
                    //   decoration: const InputDecoration(
                    //     labelText: 'Name',
                    //   ),
                    // ),
                    // TextFormField(
                    //   controller: vpaController,
                    //   keyboardType: TextInputType.emailAddress,
                    //   validator: validateVPA,
                    //   decoration: const InputDecoration(
                    //     labelText: 'UPI address',
                    //   ),
                    // ),
                    // TextFormField(
                    //   controller: amountController,
                    //   keyboardType: TextInputType.number,
                    //   validator: validateAmt,
                    //   decoration: const InputDecoration(
                    //     labelText: 'Amount',
                    //   ),
                    // ),
                    // TextFormField(
                    //   controller: noteController,
                    //   decoration: const InputDecoration(
                    //     labelText: 'Description',
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            initiateTransaction(UpiApps.GooglePay);
                          }
                        },
                        child: Container(
                          width: 200,
                          height: 50,
                          color: Colors.blue,
                          child: const Center(
                            child: Text(
                              'Pay with Gpay',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            if (_formKey.currentState!.validate()) {
                              initiateTransaction(UpiApps.PhonePe);
                            }
                          }
                        },
                        child: Container(
                          width: 200,
                          height: 50,
                          color: Colors.blue,
                          child: const Center(
                            child: Text(
                              'Pay with PhonePe',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
