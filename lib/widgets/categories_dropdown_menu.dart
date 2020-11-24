import 'package:flutter/material.dart';

class CategoriesDropdownMenu extends StatefulWidget {
  final List<String> values;
  final String start;
  final String hint;
  final void Function(String value) onChanged;

  const CategoriesDropdownMenu(
      {Key key, this.values, this.start, this.hint, this.onChanged})
      : super(key: key);

  @override
  _CategoriesDropdownMenuState createState() => _CategoriesDropdownMenuState();
}

class _CategoriesDropdownMenuState extends State<CategoriesDropdownMenu> {
  String _value;

  @override
  void initState() {
    super.initState();
    _value = (widget?.start?.isNotEmpty ?? false) ? widget.start : null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            hint: Text(widget.hint),
            value: _value,
            items: widget.values.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            isExpanded: true,
            onChanged: (value) {
              setState(() {
                _value = value;
                widget.onChanged(value);
              });
            }),
      ),
    );
  }
}
