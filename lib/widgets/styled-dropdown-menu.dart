import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
          style: TextStyle(fontSize: 12, color: Colors.red),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 100, vertical: 0),
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

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import '../widgets/padded_map.dart';

// const LatLng BANDON_LOCATION = LatLng(43.1190, -124.4084);

// class StyledDropdownMenu extends StatefulWidget {
//   final List<String> optionsDisplays;
//   final List<LatLng> optionsValues;

//   StyledDropdownMenu({Key key, this.optionsDisplays, this.optionsValues})
//       : super(key: key);

//   List<DropdownMenuItem<LatLng>> menuBuilder() {
//     List<DropdownMenuItem<LatLng>> optionsList = [];
//     for (var i = 0; i < optionsDisplays.length; i++) {
//       optionsList.add(
//         DropdownMenuItem(
//           child: Text(optionsDisplays[i]),
//           value: optionsValues[i],
//         ),
//       );
//     }
//     return optionsList;
//   }

//   @override
//   _StyledDropdownMenuState createState() => _StyledDropdownMenuState();
// }

// class _StyledDropdownMenuState extends State<StyledDropdownMenu> {
//   LatLng selectedValue = BANDON_LOCATION;
//   LatLng halfwayPoint = BANDON_LOCATION;
//   var inBetweenLat;
//   var inBetweenLong;
//   @override
//   Widget build(BuildContext context) {
//     var screenSize = MediaQuery.of(context).size;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Container(
//           alignment: Alignment.center,
//           margin: EdgeInsets.symmetric(horizontal: 100, vertical: 30),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton(
//                 value: selectedValue,
//                 items: widget.menuBuilder(),
//                 onChanged: (value) {
//                   setState(() {
//                     selectedValue = value;
//                     inBetweenLat =
//                         (selectedValue.latitude + BANDON_LOCATION.latitude) / 2;
//                     inBetweenLong =
//                         (selectedValue.longitude + BANDON_LOCATION.longitude) /
//                             2;
//                     halfwayPoint = LatLng(inBetweenLat, inBetweenLong);
//                   });
//                 }),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(bottom: 60.0),
//           child: ConstrainedBox(
//               constraints: BoxConstraints(
//                   maxWidth: (screenSize.width * .8),
//                   maxHeight: (screenSize.width *
//                       .8)), //use width so as to make a square
//               child: PaddedMap(
//                 sourceLocation: selectedValue,
//                 halfwayPoint: halfwayPoint,
//               )),
//         ),
//       ],
//     );
//   }
// }
