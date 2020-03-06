import 'package:add_thumbnail/src/media_info.dart';
import 'package:add_thumbnail/src/resources/apiProvider.dart';

class Repository {
  final moviesApiProvider = ThumbnailApiProvider();
  Future<MediaInfo> fetchAllNews({String link = ''}) => moviesApiProvider.fetchMediaInfo(link);
}