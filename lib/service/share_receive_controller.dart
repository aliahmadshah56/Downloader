// import 'dart:async';
// import 'package:get/get.dart';
// import 'package:receive_sharing_intent/receive_sharing_intent.dart';
//
// class ShareReceiveController extends GetxController {
//   RxString sharedText = "".obs;
//   StreamSubscription<List<SharedMediaFile>>? _dataStreamSubscription;
//
//   @override
//   void onInit() {
//     super.onInit();
//
//     // Listen for shared media while the app is running
//     _dataStreamSubscription = ReceiveSharingIntent.getMediaStream().listen(
//           (List<SharedMediaFile> mediaFiles) {
//         if (mediaFiles.isNotEmpty) {
//           final file = mediaFiles.first;
//           if (file.type == 'text/plain') {
//             sharedText.value = file.uri.toString(); // Use `uri` if available
//             checkLinkisYoutube(sharedText.value);
//           }
//         }
//       },
//       onError: (err) {
//         print("Error receiving shared media: $err");
//       },
//     );
//
//     // Handle shared media when the app is opened via sharing
//     ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile>? mediaFiles) {
//       if (mediaFiles != null && mediaFiles.isNotEmpty) {
//         final file = mediaFiles.first;
//         if (file.type == 'text/plain') {
//           sharedText.value = file.uri.toString(); // Use `uri` if available
//           checkLinkisYoutube(sharedText.value);
//         }
//       }
//     }).catchError((err) {
//       print("Error getting initial media: $err");
//     });
//   }
//
//   @override
//   void dispose() {
//     _dataStreamSubscription?.cancel(); // Cancel the subscription when the controller is disposed
//     super.dispose();
//   }
//
//   // Check if the link is a YouTube URL
//   void checkLinkisYoutube(String link) {
//     if (link.contains("youtube.com") || link.contains("youtu.be")) {
//       print("It's a YouTube link: $link");
//     } else {
//       print("It's not a YouTube link: $link");
//     }
//   }
// }
