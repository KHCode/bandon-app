import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledSectionBanner extends StatelessWidget {
  final String leftText;
  final String rightText;
  final double fontSize;
  final int leftColor;
  final int rightColor;

  const StyledSectionBanner(
      {Key key,
      this.leftText,
      this.rightText,
      this.fontSize = 36,
      this.leftColor = 0xFF00A896,
      this.rightColor = 0xFFF58B3E})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF05668d),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 30.0, 15.0, 30.0),
              child: Text(
                leftText,
                style: GoogleFonts.roboto(
                  fontSize: fontSize,
                  color: Color(leftColor),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Text(
                rightText,
                style: GoogleFonts.roboto(
                  fontSize: fontSize,
                  color: Color(rightColor),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
