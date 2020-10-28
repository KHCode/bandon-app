import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class StyledButton extends StatelessWidget {
  final String text;

  StyledButton({Key key, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
      child: RaisedButton(
        onPressed: () {},
        color: Color(0xFFF58B3E),
        textColor: Color(0xFF05668D),
        child: Text(text),
      ),
    );
  }
}
