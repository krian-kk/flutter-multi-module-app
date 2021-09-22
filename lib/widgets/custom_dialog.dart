import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/primary_button.dart';
import 'package:origa/widgets/secondary_button.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions;
  final Image? img;

  const CustomDialogBox(
      {Key? key, required this.title, required this.descriptions, this.img})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(),
    );
  }

  Widget contentBox() {
    return Stack(
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
          margin: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                const BoxShadow(offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 16,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    child: Icon(CupertinoIcons.home)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 22,
              ),
              Center(
                child: PrimaryButton(
                  StringResource.okay,
                  onClick: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Center(
                child: SecondaryButton(
                  StringResource.cancel,
                  onClick: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
        // Positioned(
        //   left: 16,
        //   right: 16,
        //   child: CircleAvatar(
        //     backgroundColor: Colors.transparent,
        //     radius: 16,
        //     child: ClipRRect(
        //         borderRadius: BorderRadius.all(Radius.circular(16)),
        //         child: Icon(CupertinoIcons.home)),
        //   ),
        // ),
      ],
    );
  }
}
