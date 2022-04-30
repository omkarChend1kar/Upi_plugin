import 'package:flutter/services.dart';

class UpiTransaction {
  static const MethodChannel _channel = MethodChannel('upi_plugin');
  static Future<String> initiateTransaction(
      {required String? app,
      required String? pa,
      required String? pn,
      required String? mc,
      required String? tr,
      required String? tn,
      required String? am,
      required String? cu,
      required String? url,
      required String? mode,
      required String? orgid,
      }) async {
    final String response = await _channel.invokeMethod('initiateTransaction', {
      "app": app,
      'pa': pa,
      'pn': pn,
      'mc': mc,
      'tr': tr,
      'tn': tn,
      'am': am,
      'cu': cu,
      'url': url,
      'mode':mode,
      'orgid': orgid,
    });
    return response;
  }
}