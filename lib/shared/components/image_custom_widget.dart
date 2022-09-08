import 'package:flutter/material.dart';

class ImageCustomWidget extends StatelessWidget {
  final String urlImage;
  final BoxFit boxFit;

  const ImageCustomWidget(
      {Key? key, required this.urlImage, this.boxFit = BoxFit.fitWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(urlImage, fit: boxFit, loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child;
      }
      return Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
              : null,
        ),
      );
    });
  }
}
