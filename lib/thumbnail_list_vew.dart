import 'package:add_thumbnail/add_thumbnail.dart';
import 'package:flutter/material.dart';
import 'src/resources/apiProvider.dart';
import 'src/widget/custom_card.dart';

class MediaListView extends StatefulWidget {
  /// Preview  media list thumbnail
  ///```dart
  /// List<MediaInfo> mediaList = [];
  /// List<String> urlList = ["https://www.youtube.com/watch?v=uv54ec8Pg1k"];
  /// Widget getMediaList(List<String> urlList) {
  ///   return MediaListView(
  ///     urls: urlList,
  ///     mediaList: mediaList,
  ///  );
  /// }
  ///```

  const MediaListView({
    Key key,
    this.urls,
    this.keepAlive = true,
    this.overlayChild,
    this.onPressed,
    this.mediaList,
    this.titleTextStyle,
    this.titleTextBackGroundColor = const Color(0xFFFFFFFF),
  }) : super(key: key);

  // when true, the widget will stay alive in ListViews
  // when it would otherwise have been recycled.
  final bool keepAlive;

  /// populate thumbnail list
  ///
  /// If this is set to null thumbnail list will create from urls
  /// 
  /// If mediaList and urls both have values then thumbnail list will create using both list.
  /// ``` dart
  /// List<MediaInfo> mediaList = [];
  /// ```
  final List<MediaInfo> mediaList;

  /// To show thumbnails list pass valid media url list.
  ///
  /// If this is set to null thumbnail list will create from media list
  /// 
  /// If mediaList and urls both have values then thumbnail list will create using both list.
  /// 
  ///  Example :-
  /// ```dart
  /// List<String> urls = ["https://www.youtube.com/watch?v=uv54ec8Pg1k", "https://www.youtube.com/watch?v=XMG8Sm4YGfM"]
  /// ```
  final List<String> urls;

  /// The callback that returned url when the thiumbnail is tapped.
  final Function(String) onPressed;
  
  /// if not provided, a PLAY icon will show
  final Widget overlayChild;
  
  /// this will set title text background Color
  ///
  /// If this is set to null, then default color value will set ` Colors.red`
  /// 
  ///  Example :-
  /// ```dart
  /// titleTextBackGroundColor: Colors.grey[850]
  /// ```
  final Color titleTextBackGroundColor;
  
  /// this will set title text style
  ///
  /// If this is set to null, then default color value will set ` Colors.white`
  /// 
  ///  Example :-
  /// ```dart
  /// titleTextStyle: TextStyle(color:Colors.white),
  /// ```
  final TextStyle titleTextStyle;

  

  @override
  _MediaListViewState createState() => _MediaListViewState();
}

class _MediaListViewState extends State<MediaListView>
    with AutomaticKeepAliveClientMixin {
  ThumbnailApiProvider apiProvider = ThumbnailApiProvider();

  // widget stays alive when you scroll it off the screen - otherwise images would load again.
  @override
  bool get wantKeepAlive => widget.keepAlive;

  Widget _videosList(List<String> urls) {
    if (urls == null || urls.length == 0) {
      return SliverToBoxAdapter(child: SizedBox());
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return buildVideoThumbnail(urls[index]);
        },
        childCount: urls.length,
      ),
    );
  }

  Widget buildVideoThumbnail(String url) {
    return FutureBuilder(
      future: apiProvider.fetchMediaInfo(url),
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          // width: 150,
          color: Color(0xFFEEEEEE),
          child: CustomCard(
            shadow: Shadow.soft,
            onPressed: () {
              if (widget.onPressed != null) {
                widget.onPressed(url);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    // loading indicator
                    Container(
                      height: 150,
                      color: Color(0xFFEEEEEE),
                    ),
                    !snapshot.hasData
                        ? Container(
                            height: 150,
                            color: Color(0xFFEEEEEE),
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              height: 2,
                              child: Opacity(
                                opacity: 0.5,
                                child: LinearProgressIndicator(),
                              ),
                            ),
                          )
                        : SizedBox(
                            child: Image.network(
                              snapshot.hasData
                                  ? snapshot.data.thumbnailUrl
                                  : "",
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: Container(
                                    height: 150,
                                    color: Color(0xFFEEEEEE),
                                  ),
                                );
                              },
                            ),
                          ),

                    // play button
                    Container(
                      child: widget.overlayChild ??
                          CustomCard(
                            borderRadiusValue: 100,
                            padding: EdgeInsets.all(8),
                            child: Icon(Icons.play_arrow,
                                color: Colors.grey[800], size: 32),
                          ),
                    ),
                  ],
                ),
                // title
                _title(snapshot)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _title(AsyncSnapshot snapshot) {
    return Container(
      width: double.infinity,
      color: widget.titleTextBackGroundColor,
      padding: EdgeInsets.all(16),
      child: snapshot.hasData
          ? Text(snapshot.data.title,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: widget.titleTextStyle != null
                  ? widget.titleTextStyle
                  : TextStyle(color: Colors.black54, fontSize: 16))
          : Container(
              height: 16,
              width: double.infinity,
              decoration: BoxDecoration(
                color: widget.titleTextBackGroundColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return CustomScrollView(
      slivers: <Widget>[
        _videosList(widget.urls),
        widget.mediaList != null && widget.mediaList.length > 0
            ? _videosList(Iterable.generate(widget.mediaList.length,
                (index) => widget.mediaList[index].url).toList())
            : SliverToBoxAdapter(child: SizedBox())
      ],
    );
  }
}
