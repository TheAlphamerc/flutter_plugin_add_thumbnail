import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:add_thumbnail/src/model/media_info.dart';

class ThumbnailApiProvider {

  Future<MediaInfo> fetchMediaInfo (String videoUrl) async {
    if(videoUrl == null || videoUrl.isEmpty){
      return null;
    }
    return await http.Client()
        .get("https://noembed.com/embed?url=" + videoUrl)
        .then((result) => result.body)
        .then(json.decode)
        .then((json) =>MediaInfo.fromJson(json));
  }
}