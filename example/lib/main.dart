import 'package:add_thumbnail/add_thumbnail.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Thumbnail',
      home: MyHomePage(title: 'Add thumbnail plugin example'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MediaInfo> mediaList = [];

  void openAddLinkDialog() async {
    // Open  thumbnail dialog to add link
    await Thumbnail.addLink(
      context: context,
      /// callback that return thumbnail information in `MediaInfo` object
       onLinkAdded: (mediaInfo) {
        if (mediaInfo != null && mediaInfo.thumbnailUrl.isNotEmpty) {
          setState(() {
            mediaList.add(mediaInfo);
          });
        }
      },
    );
  }

  Widget getMediaList(List<String> urlList) {
    return MediaListView(
      urls: urlList,
      mediaList: mediaList,
      onPressed: (){
        
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: getMediaList(["https://www.youtube.com/watch?v=uv54ec8Pg1k"]),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddLinkDialog,
        tooltip: 'Add link',
        child: Icon(Icons.add),
      ),
    );
  }
}
