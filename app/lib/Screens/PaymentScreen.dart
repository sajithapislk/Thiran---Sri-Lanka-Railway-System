import 'dart:async';

import 'package:app/Services/my_api.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen();

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late String selectedUrl;
  double value = 0.0;
  bool _canRedirect = true;
  bool _isLoading = true;
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  late WebViewController controllerGlobal;

  @override
  void initState() {
    super.initState();
    selectedUrl = '${CallApi().url}payment-mobile?customer_id=&order_id=';
    //selectedUrl="https://mvs.bslmeiyu.com";
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Payment"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed:()=> _exitApp(context),
          ),
        ),
        body: Center(
          child: Container(
            child: Stack(
              children: [
                // WebView(
                //   javascriptMode: JavascriptMode.unrestricted,
                //   initialUrl: selectedUrl,
                //   gestureNavigationEnabled: true,
                //
                //   userAgent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E233 Safari/601.1',
                //   onWebViewCreated: (WebViewController webViewController) {
                //     _controller.future.then((value) => controllerGlobal = value);
                //     _controller.complete(webViewController);
                //     //_controller.future.catchError(onError)
                //   },
                //   onProgress: (int progress) {
                //     print("WebView is loading (progress : $progress%)");
                //   },
                //   onPageStarted: (String url) {
                //     print('Page started loading: $url');
                //     setState(() {
                //       _isLoading = true;
                //     });
                //     print("printing urls "+url.toString());
                //     _redirect(url);
                //
                //   },
                //   onPageFinished: (String url) {
                //     print('Page finished loading: $url');
                //     setState(() {
                //       _isLoading = false;
                //     });
                //     _redirect(url);
                //
                //   },
                // ),
                _isLoading ? Center(
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
                ) : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _redirect(String url) {
    print("redirect");
    if(_canRedirect) {
      bool _isSuccess = url.contains('success') && url.contains(CallApi().url);
      bool _isFailed = url.contains('fail') && url.contains(CallApi().url);
      bool _isCancel = url.contains('cancel') && url.contains(CallApi().url);
      if (_isSuccess || _isFailed || _isCancel) {
        _canRedirect = false;
      }
      if (_isSuccess) {
        print("success");
      } else if (_isFailed || _isCancel) {
        print("cancel");
      }else{
        print("Encountered problem");
      }
    }
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (await controllerGlobal.canGoBack()) {
      controllerGlobal.goBack();
      return Future.value(false);
    } else {
      print("app exited");
      return true;
      // return Get.dialog(PaymentFailedDialog(orderID: widget.orderModel.id.toString()));
    }
  }

}