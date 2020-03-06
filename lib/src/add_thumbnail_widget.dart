// import 'package:cached_network_image/cached_network_image.dart';
import 'package:add_thumbnail/src/bloc/bloc.dart';
import 'package:add_thumbnail/src/media_info.dart';
import 'package:add_thumbnail/src/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/thumbnail_event.dart';
import 'bloc/thumbnail_state.dart';

class AddMediaDialogContent extends StatefulWidget {
  @override
  _AddMediaDialogContentState createState() => _AddMediaDialogContentState();
}

class _AddMediaDialogContentState extends State<AddMediaDialogContent> {
  TextEditingController _txtController = TextEditingController();
  bool showPreview = false;
  bool errorOccurred = false;
  String textFieldText = "";
  TextField _textField;
  // final bloc = Bloc();

  @override
  void initState() {
    super.initState();

    // Give TextField focus after a little delay
    Future.delayed(Duration(milliseconds: 500), () {
      FocusScope.of(context).requestFocus(_textField.focusNode);
    });
  }

  @override
  void dispose() {
    // bloc.dispose();
    super.dispose();
  }

  initTextField() {
    _textField = TextField(
      focusNode: FocusNode(),
      maxLines: 1,
      onChanged: (text) {
        textFieldText = text;
        BlocProvider.of<ThumbnailBloc>(context).add(UrlChanged());
      },
      controller: _txtController,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintText: "Add link here..",
        border: InputBorder.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    initTextField();

    return BlocBuilder<ThumbnailBloc, ThumbnailState>(
        // bloc: ThumbnailBloc,
        builder: (context, state) {
      MediaInfo media;
      if (state is LoadedMedia) {
        media = state.mediaInfo;
      }
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        shrinkWrap: true,
        children: <Widget>[
          // top padding
          SizedBox(height: 32),

          // title
          Text("Add a media link here",
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: Colors.black54)),
          SizedBox(height: 16),

          // sub title
          Text("Paste URL from any website here",
              style:
                  Theme.of(context).textTheme.subtitle.copyWith(fontSize: 12)),
          SizedBox(height: 16),

          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xFFF5F5F5),
              ),
              child: _textField),

          SizedBox(height: 16),

          Container(child: _previewSection(state)),

          _footer(state)
        ],
      );
    });
  }

  Widget _footer(ThumbnailState state) {
    MediaInfo media;
    if (state is LoadedMedia) {
      media = state.mediaInfo;
    }

    return ButtonBar(
      children: <Widget>[
        FlatButton(
          child: Opacity(opacity: 0.36, child: Text("CANCEL")),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text(
              media != null && media.thumbnailUrl != null ? "SAVE" : "NEXT",
              style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () {
            if (media == null) {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              BlocProvider.of<ThumbnailBloc>(context)
                  .add(UrlAdded(url: _txtController.text));
            } else {
              Navigator.pop(context, _txtController.text);
            }
          },
        ),
      ],
    );
  }

  String link;
  Widget _previewSection(ThumbnailState state) {
    if (state is LoadingMedia) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 8),
        color: Colors.grey[850],
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state is LoadedMedia) {
      var media = state.mediaInfo;
      if (state.mediaInfo == null ||
          state.mediaInfo.thumbnailUrl == null ||
          state.mediaInfo.thumbnailUrl.isEmpty) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              "hmm, this link looks too complicated for me... Can you try another one?",
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        return Container(
          padding: EdgeInsets.only(left: 8, right: 8, bottom: 20),
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Opacity(
                    opacity: 0.5,
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        media.thumbnailUrl != null ? media.thumbnailUrl : "",
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: media.title != null
                        ? Text(
                            media.title,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )
                        : Container(
                            height: 16,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    }
  }
}
