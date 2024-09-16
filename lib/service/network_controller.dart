import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    // Corrected StreamSubscription to use ConnectivityResult, not List<ConnectivityResult>
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);  // Corrected result type
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      Get.dialog(
        barrierDismissible: false,
        CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text(
            'Please check your internet connectivity!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            CupertinoButton.filled(
              onPressed: () {
                Navigator.of(Get.overlayContext!).pop();
                initConnectivity();
              },
              child: const Text("Retry"),
            )
          ],
        ),
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
