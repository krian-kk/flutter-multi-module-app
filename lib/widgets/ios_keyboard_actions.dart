import 'dart:io';

import 'package:flutter/material.dart';

enum FocusActionType { done, next, previous }

class IOSKeyboardActionWidget extends StatefulWidget {
  const IOSKeyboardActionWidget(
      {Key? key,
      required this.focusNode,
      this.backgroundColor = const Color(0xffeeeeed),
      this.child,
      this.focusActionType = FocusActionType.done,
      this.onTap,
      this.textColor = Colors.black,
      this.label})
      : super(key: key);

  final Color backgroundColor;
  final Color textColor;
  final FocusNode focusNode;
  final FocusActionType focusActionType;
  final Widget? child;
  final VoidCallback? onTap;
  final String? label;

  @override
  _IOSKeyboardActionWidgetState createState() =>
      _IOSKeyboardActionWidgetState();
}

class _IOSKeyboardActionWidgetState extends State<IOSKeyboardActionWidget> {
  OverlayEntry? _overlayEntry;

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 50,
              width: double.infinity,
              color: widget.backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: VerticalDivider(
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Controller.getFunctionAction(
                          action: widget.focusActionType,
                          focusNode: widget.focusNode);
                      if (widget.onTap != null) {
                        widget.onTap!();
                      }
                    },
                    child: Text(
                      widget.label ??
                          Controller.getActionTypeLabel(widget.focusActionType),
                      style: TextStyle(color: widget.textColor),
                    ),
                  )
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: MediaQuery.of(context).viewInsets.bottom,
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    widget.focusNode.addListener(() {
      if (Platform.isIOS) {
        if (widget.focusNode.hasFocus == true) {
          _overlayEntry = _createOverlayEntry();
          Overlay.of(context)!.insert(_overlayEntry!);
        } else {
          _overlayEntry?.remove();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }
}

class Controller {
  static const _stringsMapper = {
    FocusActionType.done: 'Done',
    FocusActionType.next: 'Next',
    FocusActionType.previous: 'Previous',
  };

  static String getActionTypeLabel(FocusActionType action) =>
      _stringsMapper[action]!;

  static getFunctionAction(
      {required FocusActionType action, required FocusNode focusNode}) {
    switch (action) {
      case FocusActionType.done:
        return focusNode.unfocus();
      case FocusActionType.next:
        return focusNode.nextFocus();
      case FocusActionType.previous:
        return focusNode.previousFocus();
      default:
        return focusNode.unfocus();
    }
  }
}
