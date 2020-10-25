import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class PaddedTextBody extends StatelessWidget {
  final List<String> textBody;
  final double left;
  final double top;
  final double right;
  final double bottom;

  PaddedTextBody(
      {Key key,
      this.textBody,
      this.left = 50,
      this.top = 0,
      this.right = 50,
      this.bottom = 30})
      : super(key: key);

  List<Widget> bodyBuilder(textBody) {
    List<Widget> paddedParagraphs = [];
    for (var i = 0; i < textBody.length; i++) {
      paddedParagraphs.add(Padding(
        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
        child: Text(textBody[i]),
      ));
    }
    return paddedParagraphs;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: bodyBuilder(textBody),
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
