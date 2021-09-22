import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:origa/utils/font.dart';
import 'package:url_launcher/url_launcher.dart';

import 'custom_text.dart';

class HyperlinkWidget extends StatefulWidget {
  String title;
  String link;
  HyperlinkWidget(this.title, this.link);
  @override
  _HyperlinkWidgetState createState() => _HyperlinkWidgetState();
}

class _HyperlinkWidgetState extends State<HyperlinkWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launch(widget.link),
      child: CustomText(
        widget.title,
        isUnderLine: true,
        fontSize: FontSize.sixteen,
      ),
    );
  }
}
