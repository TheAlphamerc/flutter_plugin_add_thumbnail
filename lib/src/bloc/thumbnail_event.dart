import 'package:equatable/equatable.dart';

abstract class ThumbnailEvent extends Equatable {
  const ThumbnailEvent();

  @override
  List<Object> get props => [];
}

class AddUrl extends ThumbnailEvent {
  final String url;
  const AddUrl({this.url});

  @override
  String toString() => 'New url added { Url: $url }';
}

class UrlChange extends ThumbnailEvent {}