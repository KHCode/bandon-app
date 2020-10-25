import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledTopBanner extends StatelessWidget {
  final String topText;
  final String bottomText;
  final double fontSize;
  final int topColor;
  final int bottomColor;
  final int bgColor;

  StyledTopBanner(
      {Key key,
      this.topText,
      this.bottomText = 'in Bandon',
      this.fontSize = 48,
      this.topColor = 0xFF00A896,
      this.bottomColor = 0xFFF58B3E,
      this.bgColor = 0xFF05668d});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(bgColor),
      ),
      padding: const EdgeInsets.fromLTRB(50, 30, 50, 30),
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              topText,
              style: GoogleFonts.roboto(
                fontSize: fontSize,
                color: Color(topColor),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            child: Text(
              bottomText,
              style: GoogleFonts.roboto(
                fontSize: fontSize,
                color: Color(bottomColor),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
