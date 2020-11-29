import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StyledDropdownMenu extends StatefulWidget {
  final List<String> optionsDisplays;
  final List<String> optionsValues;

  const StyledDropdownMenu({Key key, this.optionsDisplays, this.optionsValues})
      : super(key: key);

  List<DropdownMenuItem<String>> menuBuilder() {
    final optionsList = <DropdownMenuItem<String>>[];
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
  String selectedValue = 'start';
  Uri launchUri;

  void launchMap(selectedValue) async {
    launchUri = Uri.https('google.com', '/maps/dir/', {
      'api': '1',
      'origin': '$selectedValue',
      'destination': 'Bandon, OR',
      'travelnode': 'driving'
    });
    if (await canLaunch(launchUri.toString())) {
      await launch(launchUri.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '*Making a selection will launch Google Maps, if available',
          style: const TextStyle(fontSize: 12.0, color: Colors.red),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 0.0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
                value: selectedValue,
                items: widget.menuBuilder(),
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                    if (selectedValue != 'start') {
                      launchMap(selectedValue);
                    }
                  });
                }),
          ),
        ),
      ],
    );
  }
}
