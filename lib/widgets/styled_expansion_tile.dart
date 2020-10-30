import 'package:flutter/material.dart';

class StyledExpansionTile extends StatelessWidget {
  final String title;
  final List<String> hiddenContent;

  StyledExpansionTile({Key key, this.hiddenContent, this.title})
      : super(key: key);

  List<Widget> bodyBuilder(hiddenContent) {
    List<Widget> paragraphs = [];
    for (var i = 0; i < hiddenContent.length; i++) {
      paragraphs.add(Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Text(hiddenContent[i]),
      ));
    }
    return paragraphs;
  }

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
        backgroundColor: Colors.white,
        children: bodyBuilder(hiddenContent),
      ),
    );
  }
}
