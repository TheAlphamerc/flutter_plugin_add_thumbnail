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
