import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    // Listen to connectivity changes with List<ConnectivityResult> type
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((results) {
          // Handle the list of results here
          if (results.isNotEmpty) {
            _updateConnectionStatus(results.first);
          }
        });
  }

  Future<void> initConnectivity() async {
    List<ConnectivityResult> results;
    try {
      results = await _connectivity.checkConnectivity();
      if (results.isNotEmpty) {
        _updateConnectionStatus(results.first);  // Pass the first result
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      if (Get.isDialogOpen == false) {
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
      }
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
