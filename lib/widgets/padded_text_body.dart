import 'package:flutter/material.dart';

class PaddedTextBody extends StatelessWidget {
  final List<String> textBody;
  final double left;
  final double top;
  final double right;
  final double bottom;

  const PaddedTextBody(
      {Key key,
      this.textBody,
      this.left = 50,
      this.top = 0,
      this.right = 50,
      this.bottom = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(left, top, right, bottom),
          child: Text(
            textBody.join('\n\n'),
          ),
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
