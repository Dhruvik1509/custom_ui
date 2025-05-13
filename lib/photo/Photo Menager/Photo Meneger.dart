import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Manager Example',
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

  @override
  void initState() {
    super.initState();
    _loadAssets();
  }

  Future<void> _loadAssets() async {
    // Request permission to access the photo library
    final PermissionState permission =
        await PhotoManager.requestPermissionExtend();
    if (permission.isAuth) {
      // Fetch the list of assets (photos)
      List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
        type: RequestType.image,
      );
      if (paths.isNotEmpty) {
        List<AssetEntity> assets = await paths[0].getAssetListRange(
          start: 0,
          end: 100000/*1000*/,
        );
        setState(() {
          _assets = assets;
        });
      } else {
        print("No paths found");
      }
    } else {
      // Handle permission denied
      print("Permission denied");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Photo Gallery")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            _assets.isEmpty
                ? Center(child: CircularProgressIndicator())
                : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: _assets.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 142,
                      width: 114,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //color: Colors.amber,
                      ),
                      child: AssetThumbnail(asset: _assets[index]),
                    );
                  },
                ),
      ),
    );
  }
}

class AssetThumbnail extends StatelessWidget {

  final AssetEntity asset;

  AssetThumbnail({required this.asset});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: asset.thumbnailData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Image.memory(snapshot.data!, fit: BoxFit.cover);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading image',
                style: TextStyle(color: Colors.red),
              ),
            );
          }
        }
        return Container(color: Colors.black);
      },
    );
  }
}
