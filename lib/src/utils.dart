import 'dart:convert';
import 'package:add_thumbnail/src/media_info.dart';
import 'package:http/http.dart' as http;
// import  'package:cached_network_image/cached_network_image.dart';

class Utils {

  static Future<MediaInfo> getMediaInfo (String videoUrl) async {
    if(videoUrl == null || videoUrl.isEmpty){
      return null;
    }
    return await http.Client()
        .get("https://noembed.com/embed?url=" + videoUrl)
        .then((result) => result.body)
        .then(json.decode)
        .then((json) => MediaInfo(
      title: json['title'],
      thumbnailUrl: json['thumbnail_url'],
    ));
  }
}