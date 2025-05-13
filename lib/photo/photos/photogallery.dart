// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class NativeGallery {
//   static const MethodChannel _channel = MethodChannel('native_gallery');
//
//   static Future<List<String>> getAllPhotos() async {
//     final List<dynamic> result = await _channel.invokeMethod('getAllPhotos');
//     return result.cast<String>();
//   }
// }
//
//
// class GalleryPage extends StatefulWidget {
//   const GalleryPage({super.key});
//
//   @override
//   State<GalleryPage> createState() => _GalleryPageState();
// }
//
// class _GalleryPageState extends State<GalleryPage> {
//   List<String> _photos = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchPhotos();
//   }
//
//   Future<void> fetchPhotos() async {
//     final photos = await NativeGallery.getAllPhotos();
//     setState(() => _photos = photos);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Native Gallery")),
//       body: _photos.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : GridView.builder(
//         itemCount: _photos.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//         ),
//         itemBuilder: (context, index) {
//           return Image.network(_photos[index], fit: BoxFit.cover);
//         },
//       ),
//     );
//   }
// }
//
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Native Gallery',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const GalleryPage(),
//     );
//   }
// }


import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:photo_manager/photo_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallery in Card',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PhotoGallery(),
    );
  }
}

class PhotoGallery extends StatefulWidget {
  @override
  _PhotoGalleryState createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  List<AssetEntity> _assets = [];
  String _selectedCategory = 'Recents';
  bool _isLoading = true;

  final List<String> _categories = ['Recents', 'Favourites', 'Photos', 'Videos'];

  @override
  void initState() {
    super.initState();
    _loadAssets();
  }

  Future<void> _loadAssets() async {
    setState(() {
      _isLoading = true;
      _assets.clear();
    });

    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) {
      print("❌ Permission denied");
      return;
    }

    List<AssetPathEntity> paths;

    switch (_selectedCategory) {
      case 'Favourites':
        paths = await PhotoManager.getAssetPathList(
          type: RequestType.all,
          onlyAll: true,
        );
        break;
      case 'Photos':
        paths = await PhotoManager.getAssetPathList(
          type: RequestType.image,
          onlyAll: true,
        );
        break;
      case 'Videos':
        paths = await PhotoManager.getAssetPathList(
          type: RequestType.video,
          onlyAll: true,
        );
        break;
      case 'Recents':
      default:
        paths = await PhotoManager.getAssetPathList(
          type: RequestType.image,
          onlyAll: true,
        );
        break;
    }

    if (paths.isNotEmpty) {
      List<AssetEntity> assets = await paths[0].getAssetListRange(start: 0, end: 100000);
      if (_selectedCategory == 'Favourites') {
        assets = assets.where((asset) => asset.isFavorite == true).toList();
      }

      setState(() {
        _assets = assets;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gallery in Card")),
      body: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // Dropdown Button aligned to left
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 105,
                  height: 35,
                  child: DropdownButton<String>(
                    borderRadius: BorderRadius.circular(10),
                    value: _selectedCategory,
                    isExpanded: true,

                    underline: SizedBox.shrink(),
                    icon: Icon(HugeIcons.strokeRoundedArrowDown01, color: Colors.black),
                    //underline: Container(height: 1, color: Colors.grey),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() => _selectedCategory = newValue);
                        _loadAssets();
                      }
                    },
                    items: _categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category, style: TextStyle(fontSize: 20)),

                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Image Grid
              Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : _assets.isEmpty
                    ? Center(child: Text("No media found"))
                    : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 0.8,
                  ),
                  itemCount: _assets.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: AssetThumbnail(asset: _assets[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AssetThumbnail extends StatelessWidget {
  final AssetEntity asset;

  const AssetThumbnail({required this.asset});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: asset.thumbnailDataWithSize(ThumbnailSize(114, 300)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return Container(height: 143,width: 114,child: Image.memory(snapshot.data!, fit: BoxFit.cover));
        } else {
          return Container(color: Colors.grey[300]);
        }
      },
    );
  }
}
