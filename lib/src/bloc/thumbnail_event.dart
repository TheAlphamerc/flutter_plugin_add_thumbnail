import 'package:add_thumbnail/src/media_info.dart';
import 'package:equatable/equatable.dart';

abstract class ThumbnailEvent extends Equatable {
  const ThumbnailEvent();

  @override
  List<Object> get props => [];
}

class UrlAdded extends ThumbnailEvent {
  final String url;
  const UrlAdded({this.url});

  @override
  String toString() => 'New url added { Url: $url }';
}

class UrlChanged extends ThumbnailEvent {}