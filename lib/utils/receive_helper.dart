import 'package:downloader/utils/playlist_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../pages/playlist_downloader.dart';
import '../pages/video_downloader.dart';
import 'download_helper.dart';

void checkLinkisYoutube(String link) {
  if (link.contains("youtube") || link.contains("youtu.be")) {
    if (link.contains("playlist")) {
      if (link.trim() != "") {
        plylistUrlController.text = link;
        controller.loading.value = true;
        controller.newPlayList.clear();
        downloadPlaylist(link.trim());
        Get.to(() => const PlaylistPage());
      }
    } else {
      if (link.trim() != "") {
        videoUrlController.text = link;
        contr.loading.value = true;
        download(videoUrlController.text.trim());
        Get.to(() => const VideoPage());
      }
    }
  } else {
    debugPrint("It is not a youtube link");
  }
}
