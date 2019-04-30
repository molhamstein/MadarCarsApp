import 'package:flutter/material.dart';
import 'package:madar_booking/models/media.dart';
import 'package:photo_view/photo_view_gallery.dart';

class Gallery extends StatelessWidget {
  final List<Media> images;
  final int initialIndex;

  const Gallery({Key key, this.images, this.initialIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(initialPage: initialIndex);

    return Scaffold(
      appBar: AppBar(),
      body: PhotoViewGallery(
        gaplessPlayback: true,
        pageController: pageController,
        transitionOnUserGestures: true,
        pageOptions: images
            .map((image) => PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(image.url),
                heroTag: image.id,
                maxScale: 1.5))
            .toList(),
        backgroundDecoration: BoxDecoration(color: Colors.black87),
      ),
    );
  }
}
