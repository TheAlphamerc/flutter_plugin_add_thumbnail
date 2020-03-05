// import 'package:cached_network_image/cached_network_image.dart';
import 'package:add_thumbnail/src/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  void initState() {
    super.initState();

    // Give TextField focus after a little delay
    Future.delayed(Duration(milliseconds: 500), () {
      FocusScope.of(context).requestFocus(_textField.focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    _textField = TextField(
      focusNode: FocusNode(),
      maxLines: 1,
      onChanged: (text) {
        setState(() {
          textFieldText = text;
        });
      },
      controller: _txtController,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintText: "Add link here..",
        border: InputBorder.none,
      ),
    );

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      children: <Widget>[
        // top padding
        SizedBox(height: 32),

        // title
        Text("Add a media link here",
            style: Theme.of(context).textTheme.title.copyWith(color:Colors.black54)),
        SizedBox(height: 16),

        // sub title
        Text("Paste URL from any website here",
            style: Theme.of(context).textTheme.subtitle.copyWith(
              fontSize: 12
            )),
        SizedBox(height: 16),

        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xFFF5F5F5),
            ),
            child: _textField),

        SizedBox(height: 16),

        Container(
          child: showPreview ? _previewSection(textFieldText) : Container(),
        ),

        ButtonBar(
          children: <Widget>[
            FlatButton(
              child: Opacity(opacity: 0.36, child: Text("CANCEL")),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text(showPreview ? "SAVE" : "NEXT",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: errorOccurred
                  ? null
                  : () {
                      if (!showPreview) {
                        setState(() {
                          showPreview = true;
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        });
                      } else {
                        Navigator.pop(context, _txtController.text);
                      }
                    },
            ),
          ],
        )
      ],
    );
  }

  Widget _previewSection(String url) {
    return FutureBuilder(
      future: Utils.getMediaInfo(url),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 8),
              color: Colors.grey[850],
              child: Center(
                child: CircularProgressIndicator(),
              ));
        }

        // error view
        if (snapshot.data.thumbnailUrl == null) {
          errorOccurred = true;
          return Container(
            padding: EdgeInsets.symmetric(vertical: 32, horizontal: 8),
            color: Colors.grey[850],
            child: Center(
                child: Text(
              "hmm, this link looks too complicated for me... Can you try another one?",
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            )),
          );
        }

        errorOccurred = false;

        return Container(
          padding: EdgeInsets.only(left: 8, right: 8, bottom: 20),
          width: double.infinity,
          child: Container(
            color: Colors.grey[850],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Opacity(
                  opacity: 0.5,
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      snapshot.hasData ? snapshot.data.thumbnailUrl : "", 
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null)
                          return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                : null,
                          ));}),
                    // CachedNetworkImage(
                    //   fit: BoxFit.cover,
                    //   imageUrl:
                    //       snapshot.hasData ? snapshot.data.thumbnailUrl : "",
                    //   placeholder: (context, string) => Container(
                    //     color: Colors.grey[700],
                    //   ),
                    // ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(16),
                    child: snapshot.hasData
                        ? Text(snapshot.data.title,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: TextStyle(color: Colors.white, fontSize: 16))
                        : Container(
                            height: 16,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ))
              ],
            ),
          ),
        );
      },
    );
  }
}
