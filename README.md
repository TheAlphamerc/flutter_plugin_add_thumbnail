
## add_thumbnail Plugin 
[![pub package](https://img.shields.io/pub/v/add_thumbnail?color=green)](https://pub.dev/packages/add_thumbnail) [![Codemagic build status](https://api.codemagic.io/apps/5e6394d79399a2000f6d459a/5e6394d79399a2000f6d4599/status_badge.svg)](https://codemagic.io/apps/5e6394d79399a2000f6d459a/5e6394d79399a2000f6d4599/latest_build) ![GitHub last commit](https://img.shields.io/github/last-commit/Thealphamerc/flutter_plugin_add_thumbnail) [![Open Source Love](https://badges.frapsoft.com/os/v2/open-source.svg?v=103)](https://github.com/Thealphamerc/flutter_plugin_add_thumbnail) ![GitHub](https://img.shields.io/github/license/TheAlphamerc/flutter_plugin_add_thumbnail) [![GitHub stars](https://img.shields.io/github/stars/Thealphamerc/flutter_plugin_add_thumbnail?style=social)](https://github.com/login?return_to=%2FTheAlphamerc%flutter_plugin_add_thumbnail) ![GitHub forks](https://img.shields.io/github/forks/TheAlphamerc/flutter_plugin_add_thumbnail?style=social)


A new Flutter package. It is build for fetching media thumbnail associate to url. On adding urls it creates thumbnail wigdet.

## Download App ![GitHub All Releases](https://img.shields.io/github/downloads/Thealphamerc/flutter_plugin_add_thumbnail/total?color=green)
<a href="https://github.com/TheAlphamerc/flutter_plugin_add_thumbnail/releases/download/v0.0.1/app-release.apk"><img src="https://playerzon.com/asset/download.png" width="200"></img></a>

## Video Url
Youtube Link:- https://www.youtube.com/watch?v=1MAuErvBtKA


## Screenshots

Initial Screen |  Add Thumbnail dialog       | Image thumbnail          
:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_plugin_add_thumbnail/blob/master/screenshots/screenshot_1.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_add_thumbnail/blob/master/screenshots/screenshot_2.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_add_thumbnail/blob/master/screenshots/screenshot_3.jpg?raw=true)|![]

MediaListView widget   |  MediaListView with multiple children     |  Error on invaild link 
:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_plugin_add_thumbnail/blob/master/screenshots/screenshot_4.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_add_thumbnail/blob/master/screenshots/screenshot_5.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_add_thumbnail/blob/master/screenshots/screenshot_6.jpg?raw=true)|![]



## Add Link Data flow 
``` dart
await Thumbnail.addLink(
  context: context,
  /// callback that return thumbnail information in `MediaInfo` object
   onLinkAdded: (mediaInfo) {
      print("Thumbnail title:- ${mediaInfo.title}");
      print("Thumbnail url:- ${mediaInfo.thumbnailUrl}");
  },
);
```
* Invoke method `Thumbnail.addLink()` to display add link dialog.
* Add valid link in text field.
* Click `Next` button.
* On `Next` button clicked it it fetch meta accoicated with link.
* If fetched data contain valid image url it will shows image thumbnail.
* Else it will show some error text.
* `Save` button will visible only if thumbnail image is fetched.
* On `Save` button clicked it return `MediaInfo` object that contains thumbnail information like title, imageUrl etc.
* On `Cancel` button clicked it will close dialog and return nothing.

## MediaListView Widget
``` dart
List<MediaInfo> mediaList = [];
List<String> urlList = ["https://www.youtube.com/watch?v=uv54ec8Pg1k"];
 
 MediaListView(
   titleTextStyle: TextStyle(color:Colors.white),
   titleTextBackGroundColor: Colors.grey,
   overlayChild:Icon(Icons.save),
   urls: urlList,
   mediaList: mediaList,
    onPressed: (url) {
     print(url);
   },
 );
```
* To show thumbnails list pass valid media url list.
* If this is set to null thumbnail list will create from media list
* If mediaList and urls both have values then thumbnail list will create using both list.

## Getting Started
### 1. Add library to your pubspec.yaml


```yaml

dependencies:
  add_thumbnail: ^0.0.1

```

### 2. Import library in dart file

```dart
import 'package:add_thumbnail/add_thumbnail.dart';
```


### 3. How to use FilterList


#### Create of list of  MediaInfo object
```dart
  List<MediaInfo> mediaList = [];
```

### Create List of String
```dart
List<String> urlList = ["https://www.youtube.com/watch?v=uv54ec8Pg1k"];
```

#### Create `async` function and call `Thumbnail.addLink()`
```dart
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
```

### Create MediaList widget to show thumbnail list
```dart
Widget getMediaList() {
    return MediaListView(
      onPressed: (url) {
        print(url);
      },
      urls: urlList,
      mediaList: mediaList,
    );
  }
```

#### Call `openAddLinkDialog` function on `floatingActionButton` pressed

```dart
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:(mediaList == null || mediaList.isEmpty) && (urlList == null || urlList.isEmpty)
          ? Center(
              child: Text(
                "Press add button to add thumbnail.",
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
            )
          : getMediaList(),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddLinkDialog,
        tooltip: 'Add link',
        child: Icon(Icons.add),
      ),
    );
  }
```


## Pull Requests

I welcome and encourage all pull requests. It usually will take me within 24-48 hours to respond to any issue or request.

## Created & Maintained By

[Sonu Sharma](https://github.com/TheAlphamerc) ([Twitter](https://www.twitter.com/TheAlphamerc)) ([Youtube](https://www.youtube.com/user/sonusharma045sonu/))
([Insta](https://www.instagram.com/_sonu_sharma__))  ![Twitter Follow](https://img.shields.io/twitter/follow/thealphamerc?style=social)

> If you found this project helpful or you learned something from the source code and want to thank me, consider buying me a cup of :coffee:
>
> * [PayPal](https://www.paypal.me/TheAlphamerc/)


## Visitors Count

<img align="left" src = "https://profile-counter.glitch.me/flutter_plugin_add_thumbnail/count.svg" alt ="Loading">

