import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';


class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final List<File> _images = [];
  final ImagePicker _picker = ImagePicker();
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    _prefs = await SharedPreferences.getInstance();
    List<String> paths = _prefs.getStringList('images') ?? [];
    List<File> existingFiles = [];

    for (String pathStr in paths) {
      File file = File(pathStr);
      if (await file.exists()) {
        existingFiles.add(file);
      }
    }

    setState(() {
      _images.clear();
      _images.addAll(existingFiles);
    });
  }

  Future<void> _saveImages() async {
    List<String> paths = _images.map((e) => e.path).toList();
    await _prefs.setStringList('images', paths);
  }


  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString() +
          path.extension(pickedFile.path);
      final File newImage =
          await File(pickedFile.path).copy('${appDir.path}/$fileName');

      setState(() {
        _images.add(newImage);
      });
      _saveImages();
    }
  }

  void _openImageViewer(int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ImageViewer(
          images: _images,
          initialIndex: initialIndex,
          onDelete: (index) {
            setState(() {
              _images[index].deleteSync(); // delete file from storage
              _images.removeAt(index);
              _saveImages();
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xffee4176),
        elevation: 0,
        toolbarHeight: 70,
        leading: IconButton(
          icon: const Icon(TablerIcons.caret_left_filled),
          color: const Color(0xfffef4f5),
          iconSize: 24,
          onPressed: () {
            // Go back logic
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'GALLERY',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xfffef4f5),
              fontSize: 24,
              fontFamily: 'Open_Sans'),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _openImageViewer(index),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      _images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            color:const Color(0xffee4176),
            child: TextButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.upload, color: Color(0xfffef4f5)),
              label: const Text(
                'UPLOAD IMAGE',
                style: TextStyle(
                  color: Color(0xfffef4f5),
                  fontSize: 12,
                  fontFamily: 'Open_Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageViewer extends StatefulWidget {
  final List<File> images;
  final int initialIndex;
  final Function(int) onDelete;

  const ImageViewer({
    super.key,
    required this.images,
    required this.initialIndex,
    required this.onDelete,
  });

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  void _deleteImage() {
    widget.onDelete(_currentIndex);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'GALLERY',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.images.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Center(
                  child: Image.file(
                    widget.images[index],
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),
          ),
          IconButton(
            onPressed: _deleteImage,
            icon: const Icon(TablerIcons.trash_filled),
            color: const Color(0xffffffff),
            iconSize: 30,
          )
        ],
      ),
    );
  }
}
