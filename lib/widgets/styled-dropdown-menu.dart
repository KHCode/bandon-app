import 'package:flutter/material.dart';

class StyledDropdownMenu extends StatefulWidget {
  final List<String> optionsDisplays;
  final List<String> optionsValues;

  StyledDropdownMenu({Key key, this.optionsDisplays, this.optionsValues})
      : super(key: key);

  List<DropdownMenuItem<String>> menuBuilder() {
    List<DropdownMenuItem<String>> optionsList = [];
    for (var i = 0; i < optionsDisplays.length; i++) {
      optionsList.add(
        DropdownMenuItem(
          child: Text(optionsDisplays[i]),
          value: optionsValues[i],
        ),
      );
    }
    return optionsList;
  }

  @override
  _StyledDropdownMenuState createState() => _StyledDropdownMenuState();
}

class _StyledDropdownMenuState extends State<StyledDropdownMenu> {
  String _value = "start";

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 100, vertical: 30),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            value: _value,
            items: widget.menuBuilder(),
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            }),
      ),
    );
  }
}
