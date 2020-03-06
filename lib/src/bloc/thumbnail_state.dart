import 'package:add_thumbnail/src/media_info.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThumbnailState extends Equatable{
  const ThumbnailState();

  @override
  List<Object> get props => [];
}

class LoadingMedia extends ThumbnailState {}

class FailureDetail extends ThumbnailState {}

class LoadedMedia extends ThumbnailState {
  final MediaInfo mediaInfo;

  LoadedMedia({this.mediaInfo});
  
  @override
  List<Object> get props => [mediaInfo];

  @override
  String toString() => 'LoadedMedia { items: ${mediaInfo.title} }';
}
