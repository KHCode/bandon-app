import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const StyledButton({Key key, this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(100.0, 10.0, 100.0, 10.0),
      child: RaisedButton(
        onPressed: onPressed,
        color: Color(0xFFF58B3E),
        child: Text(text),
      ),
    );
  }
}
