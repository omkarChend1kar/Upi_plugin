class UpiResponse {
  String? txnId;
  String? responseCode;
  String? ApprovalRefNo;
  String? Status;
  String? txnRef;

  UpiResponse(String responseString) {
    List<String> _parts = responseString.split('&');

    for (int i = 0; i < _parts.length; ++i) {
      String key = _parts[i].split('=')[0];
      String value = _parts[i].split('=')[1];
      if (key == "txnId") {
        txnId = value;
      } else if (key == "responseCode") {
        responseCode = value;
      } else if (key == "ApprovalRefNo") {
        ApprovalRefNo = value;
      } else if (key.toLowerCase() == "status") {
        Status = value;
      } else if (key == "txnRef") {
        txnRef = value;
      }
    }
  }
}