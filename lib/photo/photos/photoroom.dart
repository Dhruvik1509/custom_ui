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
  List<AssetEntity> selectedAssets = [];

  final List<String> _categories = ['Recents', 'Favourites', 'Photos', 'Videos'];

  @override
  void initState() {
    super.initState();
    _loadAssets();
  }

  Future<void> _loadAssets() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) {
      print("❌ Permission denied");
      return;
    }

    setState(() {
      _isLoading = true;
      _assets.clear();
      selectedAssets.clear(); // Clear selection when refreshing
    });

    List<AssetPathEntity> paths;

    switch (_selectedCategory) {
      case 'Favourites':
        paths = await PhotoManager.getAssetPathList(type: RequestType.all, onlyAll: true);
        break;
      case 'Photos':
        paths = await PhotoManager.getAssetPathList(type: RequestType.image, onlyAll: true);
        break;
      case 'Videos':
        paths = await PhotoManager.getAssetPathList(type: RequestType.video, onlyAll: true);
        break;
      case 'Recents':
      default:
        paths = await PhotoManager.getAssetPathList(type: RequestType.image, onlyAll: true);
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
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
                    final asset = _assets[index];
                    final isSelected = selectedAssets.contains(asset);

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selectedAssets.contains(asset)) {
                            selectedAssets.remove(asset);
                          } else {
                            selectedAssets.add(asset);
                          }
                        });
                      },
                      onLongPress: () {
                        if (index == 0 && !selectedAssets.contains(asset)) {
                          setState(() {
                            selectedAssets.add(asset);
                          });
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: AssetThumbnail(
                          asset: asset,
                          isSelected: isSelected,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: selectedAssets.isNotEmpty
          ? FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectedImagesScreen(assets: selectedAssets),
            ),
          );
        },
        icon: Icon(Icons.arrow_forward),
        label: Text("Next (${selectedAssets.length})"),
      )
          : null,
    );
  }
}

class AssetThumbnail extends StatelessWidget {
  final AssetEntity asset;
  final bool isSelected;

  const AssetThumbnail({required this.asset, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: asset.thumbnailDataWithSize(ThumbnailSize(114, 300)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return Stack(
            children: [
              Container(
                height: 143,
                width: 114,
                child: Image.memory(snapshot.data!, fit: BoxFit.cover),
              ),
              if (isSelected)
                Positioned(
                  right: 5,
                  top: 5,
                  child: CircleAvatar(
                    radius: 11,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 9,
                      backgroundColor: Colors.blue,
                      child: Icon(HugeIcons.strokeRoundedTick01, size: 12, color: Colors.white),
                    ),
                  ),
                ),
            ],
          );
        } else {
          return Container(height: 143, width: 114, color: Colors.grey[300]);
        }
      },
    );
  }
}

class SelectedImagesScreen extends StatelessWidget {
  final List<AssetEntity> assets;

  const SelectedImagesScreen({Key? key, required this.assets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selected Images')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: assets.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return FutureBuilder<Uint8List?>(
            future: assets[index].thumbnailDataWithSize(ThumbnailSize(200, 200)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(snapshot.data!, fit: BoxFit.cover),
                );
              } else {
                return Container(color: Colors.grey[300]);
              }
            },
          );
        },
      ),
    );
  }
}
