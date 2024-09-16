import 'dart:async';
import 'package:get/get.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class ShareReceiveController extends GetxController {
  RxString sharedText = "".obs;  // Holds the shared text or URL
  StreamSubscription? _dataStreamSubscription;

  @override
  void onInit() {
    super.onInit();

    // Listen for shared content while the app is running
    _dataStreamSubscription = ReceiveSharingIntent.getMediaStream().listen((List<SharedMediaFile> media) {
      if (media.isNotEmpty) {
        String link = media[0].path;  // Assuming it's a URL or file path
        sharedText.value = link;
        checkLinkisYoutube(sharedText.value);  // Check if it's a YouTube link
      }
    }, onError: (err) {
      print("Error receiving shared media: $err");
    });

    // Handle shared content when the app is opened via sharing
    ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> media) {
      if (media.isNotEmpty) {
        String link = media[0].path;  // Assuming it's a URL or file path
        sharedText.value = link;
        checkLinkisYoutube(sharedText.value);  // Check if it's a YouTube link
      }
    });
  }

  @override
  void dispose() {
    _dataStreamSubscription?.cancel();  // Cancel the subscription when the controller is disposed
    super.dispose();
  }

  // Check if the link is a YouTube URL
  void checkLinkisYoutube(String link) {
    if (link.contains("youtube.com") || link.contains("youtu.be")) {
      print("It's a YouTube link: $link");
      // Additional logic for handling YouTube links can go here
    } else {
      print("It's not a YouTube link: $link");
    }
  }
}
