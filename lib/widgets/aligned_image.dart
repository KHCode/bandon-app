import 'package:flutter/material.dart';

class AlignedImage extends StatelessWidget {
  final String fileName;
  final double size;
  final Alignment alignment;

  const AlignedImage({Key key, this.fileName, this.size, this.alignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Image.asset('assets/images/$fileName', width: size),
      alignment: alignment,
    );
  }
}
