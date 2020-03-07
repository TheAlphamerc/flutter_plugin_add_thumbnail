library add_thumbnail;

export 'thumbnail_list_vew.dart';
export 'package:add_thumbnail/src/model/media_info.dart';
import 'package:add_thumbnail/src/bloc/bloc.dart';
import 'package:add_thumbnail/src/model/media_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/widget/add_thumbnail_widget.dart';

/// A Calculator.
class Thumbnail {
  ///  Invoke `addLink` function to show add_thumbnail dialog.
  ///
  /// Callback `onLinkAdded` returns `MediaInfo` object on `save` button pressed
  ///
  /// ```dart
  /// List<MediaInfo> mediaList = [];
  /// 
  /// void openAddLinkDialog() async {
  //  // Open add thumbnail dialog
  //   await Thumbnail.addLink(
  ///    context: context,
  ///    /// callback that return thumbnail information in `MediaInfo` object
  ///    onLinkAdded: (mediaInfo) {
  ///    if (mediaInfo != null && mediaInfo.thumbnailUrl.isNotEmpty) {
  ///      setState(() {
  ///        mediaList.add(mediaInfo);
  ///      });
  ///     }
  ///    },
  ///  );
  ///}
  ///```
  ///
  static Future<void> addLink({
    BuildContext context,
    ValueChanged<MediaInfo> onLinkAdded,
  }) async {
    var media = await showDialog(
        context: context,
        child: Builder(
          builder: (context) {
            return Dialog(
                child: MultiBlocProvider(
              providers: [
                BlocProvider<ThumbnailBloc>(
                  create: (BuildContext context) => ThumbnailBloc(),
                ),
              ],
              child: AddMediaDialogContent(),
            ));
          },
        ));
    if (media != null) {
      onLinkAdded(media);
    }
  }
}
