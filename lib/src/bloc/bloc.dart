import 'dart:async';

import 'package:add_thumbnail/src/bloc/thumbnail_event.dart';
import 'package:add_thumbnail/src/bloc/thumbnail_state.dart';
import 'package:add_thumbnail/src/resources/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThumbnailBloc extends Bloc<ThumbnailEvent, ThumbnailState> {
  final Repository repo = Repository();

  
  @override
  ThumbnailState get initialState => DialogOpened();

  @override
  Stream<ThumbnailState> mapEventToState(ThumbnailEvent event) async* {
    if (event is AddUrl) {
      try {
        yield LoadingMedia();
        var media = await repo.fetchAllNews(link: event.url);
       
        yield LoadedMedia(mediaInfo: media);
      } catch (_) {
        yield FailureDetail();
      }
    }
    if (event is UrlChange) {
      yield UrlChanged();
    }
  }
}
