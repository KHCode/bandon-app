import 'package:flutter/material.dart';

class CategoriesDropdownMenu extends StatefulWidget {
  final List<String> values;
  final String start;
  final String hint;
  final void Function(String value) onChanged;
  final bool Function() clearValue;

  const CategoriesDropdownMenu(
      {Key key,
      this.values,
      this.start,
      this.hint,
      this.onChanged,
      this.clearValue})
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
    if (widget.clearValue()) {
      setState(
        () => _value = null,
      );
    }

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 5.0),
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
