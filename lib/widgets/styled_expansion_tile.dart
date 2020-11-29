import 'package:flutter/material.dart';

class StyledExpansionTile extends StatelessWidget {
  final String title;
  final List<String> hiddenContent;

  const StyledExpansionTile({Key key, this.hiddenContent, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        color: Color(0xFFF58B3E),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF05668d),
          ),
        ),
      ),
      child: ExpansionTile(
        title: Text(title),
        childrenPadding: EdgeInsets.all(15),
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(hiddenContent.join('\n\n')),
          ),
        ],
      ),
    );
  }
}
