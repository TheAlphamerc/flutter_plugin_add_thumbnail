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

  void addLink() async {
    // Open add thumbnail dialog
    await Thumbnail.addLink(
      context: context,
      // callback that return thumbnail info
      onLinkAdded: (mediaInfo) {
        if (mediaInfo != null && mediaInfo.thumbnailUrl.isNotEmpty) {
          setState(() {
            mediaList.add(mediaInfo);
          });
        }
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
      body: MediaListView(
        urls: ["https://www.youtube.com/watch?v=uv54ec8Pg1k"],
        mediaList: mediaList,
        // titleTextStyle: TextStyle(color:Colors.red),
        // titleTextBackGroundColor: Colors.grey[850]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addLink,
        tooltip: 'Add link',
        child: Icon(Icons.add),
      ),
    );
  }
}
