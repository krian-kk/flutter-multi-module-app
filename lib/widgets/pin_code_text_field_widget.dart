import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const bool kIsWeb = identical(0, 0.0);

class PinCodeTextFieldWidget extends StatefulWidget {
  PinCodeTextFieldWidget({
    Key? key,
    required this.appContext,
    required this.length,
    this.controller,
    this.obscureText = false,
    this.obscuringCharacter = '●',
    this.obscuringWidget,
    this.blinkWhenObscuring = false,
    this.blinkDuration = const Duration(milliseconds: 500),
    required this.onChanged,
    this.onCompleted,
    this.backgroundColor,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.animationDuration = const Duration(milliseconds: 150),
    this.animationCurve = Curves.easeInOut,
    this.animationType = AnimationType.slide,
    this.keyboardType = TextInputType.visiblePassword,
    this.autoFocus = false,
    this.focusNode,
    this.onTap,
    this.enabled = true,
    this.inputFormatters = const <TextInputFormatter>[],
    this.textStyle,
    this.useHapticFeedback = false,
    this.hapticFeedbackTypes = HapticFeedbackTypes.light,
    this.pastedTextStyle,
    this.enableActiveFill = false,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.done,
    this.autoDismissKeyboard = true,
    this.autoDisposeControllers = true,
    this.onSubmitted,
    this.errorAnimationController,
    this.beforeTextPaste,
    this.dialogConfig,
    this.pinTheme = const PinTheme.defaults(),
    this.keyboardAppearance,
    this.validator,
    this.onSaved,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.errorTextSpace = 16,
    this.enablePinAutofill = true,
    this.errorAnimationDuration = 500,
    this.boxShadows,
    this.showCursor = true,
    this.cursorColor,
    this.cursorWidth = 2,
    this.cursorHeight,
    this.hintCharacter,
    this.hintStyle,
    this.textGradient,
    this.readOnly = false,
    this.onAutoFillDisposeAction = AutofillContextAction.commit,
    this.useExternalAutoFillGroup = false,
    this.scrollPadding = const EdgeInsets.all(20),
  })  : assert(obscuringCharacter.isNotEmpty),
        super(key: key);
  final BuildContext appContext;
  final List<BoxShadow>? boxShadows;
  final int length;
  final bool obscureText;
  final String obscuringCharacter;
  final Widget? obscuringWidget;
  final bool useHapticFeedback;
  final HapticFeedbackTypes hapticFeedbackTypes;
  final bool blinkWhenObscuring;
  final Duration blinkDuration;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onSubmitted;
  final TextStyle? textStyle;
  final TextStyle? pastedTextStyle;
  final Color? backgroundColor;
  final MainAxisAlignment mainAxisAlignment;
  final AnimationType animationType;
  final Duration animationDuration;
  final Curve animationCurve;
  final TextInputType keyboardType;
  final bool autoFocus;
  final FocusNode? focusNode;
  final List<TextInputFormatter> inputFormatters;
  final bool enabled;
  final TextEditingController? controller;
  final bool enableActiveFill;
  final bool autoDismissKeyboard;
  final bool autoDisposeControllers;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final StreamController<ErrorAnimationType>? errorAnimationController;
  final bool Function(String? text)? beforeTextPaste;
  final Function? onTap;
  final DialogConfig? dialogConfig;
  final PinTheme pinTheme;
  final Brightness? keyboardAppearance;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final AutovalidateMode autovalidateMode;
  final double errorTextSpace;
  final bool enablePinAutofill;
  final int errorAnimationDuration;
  final bool showCursor;
  final Color? cursorColor;
  final double cursorWidth;
  final double? cursorHeight;
  final AutofillContextAction onAutoFillDisposeAction;
  final bool useExternalAutoFillGroup;
  final String? hintCharacter;
  final TextStyle? hintStyle;
  final EdgeInsets scrollPadding;
  final Gradient? textGradient;
  final bool readOnly;

  @override
  _PinCodeTextFieldWidgetState createState() => _PinCodeTextFieldWidgetState();
}

class _PinCodeTextFieldWidgetState extends State<PinCodeTextFieldWidget>
    with TickerProviderStateMixin {
  TextEditingController? _textEditingController;
  FocusNode? _focusNode;
  late List<String> _inputList;
  int _selectedIndex = 0;
  BorderRadius? borderRadius;

  bool _hasBlinked = false;

  late AnimationController _controller;

  late AnimationController _cursorController;

  StreamSubscription<ErrorAnimationType>? _errorAnimationSubscription;
  bool isInErrorMode = false;

  late Animation<Offset> _offsetAnimation;

  late Animation<double> _cursorAnimation;
  DialogConfig get _dialogConfig => widget.dialogConfig == null
      ? DialogConfig()
      : DialogConfig(
          affirmativeText: widget.dialogConfig!.affirmativeText,
          dialogContent: widget.dialogConfig!.dialogContent,
          dialogTitle: widget.dialogConfig!.dialogTitle,
          negativeText: widget.dialogConfig!.negativeText);
  PinTheme get _pinTheme => widget.pinTheme;

  Timer? _blinkDebounce;

  TextStyle get _textStyle => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ).merge(widget.textStyle);

  TextStyle get _hintStyle => _textStyle
      .copyWith(
        color: _pinTheme.disabledColor,
      )
      .merge(widget.hintStyle);

  bool get _hintAvailable => widget.hintCharacter != null;

  @override
  void initState() {
    _checkForInvalidValues();
    _assignController();
    if (_pinTheme.shape != PinCodeFieldShape.circle &&
        _pinTheme.shape != PinCodeFieldShape.underline) {
      borderRadius = _pinTheme.borderRadius;
    }
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode!.addListener(() {
      setState(() {});
    });
    _inputList = List<String>.filled(widget.length, '');

    _hasBlinked = true;

    _cursorController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _cursorAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _cursorController,
      curve: Curves.easeIn,
    ));
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.errorAnimationDuration),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(.1, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));
    if (widget.showCursor) {
      _cursorController.repeat();
    }

    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });

    if (widget.errorAnimationController != null) {
      _errorAnimationSubscription = widget.errorAnimationController!.stream
          .listen((ErrorAnimationType errorAnimation) {
        if (errorAnimation == ErrorAnimationType.shake) {
          _controller.forward();
          setState(() => isInErrorMode = true);
        }
      });
    }

    if (_textEditingController!.text.isNotEmpty) {
      _setTextToInput(_textEditingController!.text);
    }
    super.initState();
  }

  void _checkForInvalidValues() {
    assert(widget.length > 0);
    assert(_pinTheme.fieldHeight > 0);
    assert(_pinTheme.fieldWidth > 0);
    assert(_pinTheme.borderWidth >= 0);
    assert(_dialogConfig.affirmativeText != null &&
        _dialogConfig.affirmativeText!.isNotEmpty);
    assert(_dialogConfig.negativeText != null &&
        _dialogConfig.negativeText!.isNotEmpty);
    assert(_dialogConfig.dialogTitle != null &&
        _dialogConfig.dialogTitle!.isNotEmpty);
    assert(_dialogConfig.dialogContent != null &&
        _dialogConfig.dialogContent!.isNotEmpty);
  }

  runHapticFeedback() {
    switch (widget.hapticFeedbackTypes) {
      case HapticFeedbackTypes.heavy:
        HapticFeedback.heavyImpact();
        break;

      case HapticFeedbackTypes.medium:
        HapticFeedback.mediumImpact();
        break;

      case HapticFeedbackTypes.light:
        HapticFeedback.lightImpact();
        break;

      case HapticFeedbackTypes.selection:
        HapticFeedback.selectionClick();
        break;

      case HapticFeedbackTypes.vibrate:
        HapticFeedback.vibrate();
        break;

      default:
        break;
    }
  }

  void _assignController() {
    if (widget.controller == null) {
      _textEditingController = TextEditingController();
    } else {
      _textEditingController = widget.controller;
    }

    _textEditingController?.addListener(() {
      if (widget.useHapticFeedback) {
        runHapticFeedback();
      }

      if (isInErrorMode) {
        setState(() => isInErrorMode = false);
      }

      _debounceBlink();

      String currentText = _textEditingController!.text;

      if (widget.enabled && _inputList.join() != currentText) {
        if (currentText.length >= widget.length) {
          if (widget.onCompleted != null) {
            if (currentText.length > widget.length) {
              currentText = currentText.substring(0, widget.length);
            }

            Future<dynamic>.delayed(const Duration(milliseconds: 300),
                () => widget.onCompleted!(currentText));
          }

          if (widget.autoDismissKeyboard) {
            _focusNode!.unfocus();
          }
        }
        widget.onChanged(currentText);
      }

      _setTextToInput(currentText);
    });
  }

  void _debounceBlink() {
    if (widget.blinkWhenObscuring &&
        _textEditingController!.text.length >
            _inputList.where((String x) => x.isNotEmpty).length) {
      setState(() {
        _hasBlinked = false;
      });

      if (_blinkDebounce?.isActive ?? false) {
        _blinkDebounce!.cancel();
      }

      _blinkDebounce = Timer(widget.blinkDuration, () {
        setState(() {
          _hasBlinked = true;
        });
      });
    }
  }

  @override
  void dispose() {
    if (widget.autoDisposeControllers) {
      _textEditingController!.dispose();
      _focusNode!.dispose();
    }

    _errorAnimationSubscription?.cancel();

    _cursorController.dispose();

    _controller.dispose();
    super.dispose();
  }

  Color _getColorFromIndex(int index) {
    if (!widget.enabled) {
      return _pinTheme.disabledColor;
    }
    if (((_selectedIndex == index) ||
            (_selectedIndex == index + 1 && index + 1 == widget.length)) &&
        _focusNode!.hasFocus) {
      return _pinTheme.selectedColor;
    } else if (_selectedIndex > index) {
      Color relevantActiveColor = _pinTheme.activeColor;
      if (isInErrorMode) {
        relevantActiveColor = _pinTheme.errorBorderColor;
      }
      return relevantActiveColor;
    }

    Color relevantInActiveColor = _pinTheme.inactiveColor;
    if (isInErrorMode) {
      relevantInActiveColor = _pinTheme.errorBorderColor;
    }
    return relevantInActiveColor;
  }

  Widget _renderPinField({
    @required int? index,
  }) {
    assert(index != null);

    final bool showObscured = !widget.blinkWhenObscuring ||
        (widget.blinkWhenObscuring && _hasBlinked) ||
        index != _inputList.where((String x) => x.isNotEmpty).length - 1;

    if (widget.obscuringWidget != null) {
      if (showObscured) {
        if (_inputList[index!].isNotEmpty) {
          return widget.obscuringWidget!;
        }
      }
    }

    if (_inputList[index!].isEmpty && _hintAvailable) {
      return Text(
        widget.hintCharacter!,
        key: ValueKey<String>(_inputList[index]),
        style: _hintStyle,
      );
    }

    final String text =
        widget.obscureText && _inputList[index].isNotEmpty && showObscured
            ? widget.obscuringCharacter
            : _inputList[index];
    return widget.textGradient != null
        ? Gradiented(
            gradient: widget.textGradient!,
            child: Text(
              text,
              key: ValueKey<String>(_inputList[index]),
              style: _textStyle.copyWith(color: Colors.white),
            ),
          )
        : Text(
            text,
            key: ValueKey<String>(_inputList[index]),
            style: _textStyle,
          );
  }

  Color _getFillColorFromIndex(int index) {
    if (!widget.enabled) {
      return _pinTheme.disabledColor;
    }
    if (((_selectedIndex == index) ||
            (_selectedIndex == index + 1 && index + 1 == widget.length)) &&
        _focusNode!.hasFocus) {
      return _pinTheme.selectedFillColor;
    } else if (_selectedIndex > index) {
      return _pinTheme.activeFillColor;
    }
    return _pinTheme.inactiveFillColor;
  }

  Widget buildChild(int index) {
    if (((_selectedIndex == index) ||
            (_selectedIndex == index + 1 && index + 1 == widget.length)) &&
        _focusNode!.hasFocus &&
        widget.showCursor) {
      final Color cursorColor = widget.cursorColor ??
          Theme.of(widget.appContext).textSelectionTheme.cursorColor ??
          Theme.of(context).colorScheme.secondary;
      final double cursorHeight =
          widget.cursorHeight ?? _textStyle.fontSize! + 8;

      if ((_selectedIndex == index + 1 && index + 1 == widget.length)) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.only(left: _textStyle.fontSize! / 1.5),
                child: FadeTransition(
                  opacity: _cursorAnimation,
                  child: CustomPaint(
                    size: Size(0, cursorHeight),
                    painter: CursorPainter(
                      cursorColor: cursorColor,
                      cursorWidth: widget.cursorWidth,
                    ),
                  ),
                ),
              ),
            ),
            _renderPinField(
              index: index,
            ),
          ],
        );
      } else {
        return Center(
          child: FadeTransition(
            opacity: _cursorAnimation,
            child: CustomPaint(
              size: Size(0, cursorHeight),
              painter: CursorPainter(
                cursorColor: cursorColor,
                cursorWidth: widget.cursorWidth,
              ),
            ),
          ),
        );
      }
    }
    return _renderPinField(
      index: index,
    );
  }

  Future<void> _showPasteDialog(String pastedText) {
    final String formattedPastedText = pastedText
        .trim()
        .substring(0, min(pastedText.trim().length, widget.length));

    final TextStyle defaultPastedTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.secondary,
    );

    return showDialog(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) => _dialogConfig.platform.toString() ==
              Platform.isIOS.toString()
          ? CupertinoAlertDialog(
              title: Text(_dialogConfig.dialogTitle!),
              content: RichText(
                text: TextSpan(
                  text: _dialogConfig.dialogContent,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.button!.color,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: formattedPastedText,
                      style: widget.pastedTextStyle ?? defaultPastedTextStyle,
                    ),
                    TextSpan(
                      text: '?',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.button!.color,
                      ),
                    )
                  ],
                ),
              ),
              actions: _getActionButtons(formattedPastedText),
            )
          : AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(_dialogConfig.dialogTitle!),
              content: RichText(
                text: TextSpan(
                  text: _dialogConfig.dialogContent,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.button!.color),
                  children: <InlineSpan>[
                    TextSpan(
                      text: formattedPastedText,
                      style: widget.pastedTextStyle ?? defaultPastedTextStyle,
                    ),
                    TextSpan(
                      text: ' ?',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.button!.color,
                      ),
                    )
                  ],
                ),
              ),
              actions: _getActionButtons(formattedPastedText),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextFormField textField = TextFormField(
      textInputAction: widget.textInputAction,
      controller: _textEditingController,
      focusNode: _focusNode,
      enabled: widget.enabled,
      autofillHints: widget.enablePinAutofill && widget.enabled
          ? <String>[AutofillHints.oneTimeCode]
          : null,
      autofocus: widget.autoFocus,
      autocorrect: false,
      keyboardType: widget.keyboardType,
      keyboardAppearance: widget.keyboardAppearance,
      textCapitalization: widget.textCapitalization,
      validator: widget.validator,
      onSaved: widget.onSaved,
      autovalidateMode: widget.autovalidateMode,
      inputFormatters: <TextInputFormatter>[
        ...widget.inputFormatters,
        LengthLimitingTextInputFormatter(
          widget.length,
        ),
      ],
      onFieldSubmitted: widget.onSubmitted,
      enableInteractiveSelection: false,
      showCursor: false,
      cursorWidth: 0.01,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        border: InputBorder.none,
        fillColor: widget.backgroundColor,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
      style: const TextStyle(
        color: Colors.transparent,
        height: .01,
        fontSize: kIsWeb ? 1 : 0.01,
      ),
      scrollPadding: widget.scrollPadding,
      readOnly: widget.readOnly,
    );

    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        height: widget.autovalidateMode == AutovalidateMode.disabled
            ? widget.pinTheme.fieldHeight
            : widget.pinTheme.fieldHeight + widget.errorTextSpace,
        color: widget.backgroundColor,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            AbsorbPointer(
              child: widget.useExternalAutoFillGroup
                  ? textField
                  : AutofillGroup(
                      onDisposeAction: widget.onAutoFillDisposeAction,
                      child: textField,
                    ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  if (widget.onTap != null) {
                    widget.onTap!();
                  }
                  _onFocus();
                },
                onLongPress: widget.enabled
                    ? () async {
                        final ClipboardData? data =
                            await Clipboard.getData('text/plain');
                        if (data?.text?.isNotEmpty ?? false) {
                          if (widget.beforeTextPaste != null) {
                            if (widget.beforeTextPaste!(data!.text)) {
                              await _showPasteDialog(data.text!);
                            }
                          } else {
                            await _showPasteDialog(data!.text!);
                          }
                        }
                      }
                    : null,
                child: Row(
                  mainAxisAlignment: widget.mainAxisAlignment,
                  children: _generateFields(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _generateFields() {
    final List<Widget> result = <Widget>[];
    for (int i = 0; i < widget.length; i++) {
      result.add(
        Container(
            padding: _pinTheme.fieldOuterPadding,
            child: AnimatedContainer(
              curve: widget.animationCurve,
              duration: widget.animationDuration,
              width: _pinTheme.fieldWidth,
              height: _pinTheme.fieldHeight,
              decoration: BoxDecoration(
                color: widget.enableActiveFill
                    ? _getFillColorFromIndex(i)
                    : Colors.transparent,
                boxShadow: widget.boxShadows,
                shape: _pinTheme.shape == PinCodeFieldShape.circle
                    ? BoxShape.circle
                    : BoxShape.rectangle,
                borderRadius: borderRadius,
                border: _pinTheme.shape == PinCodeFieldShape.underline
                    ? Border(
                        bottom: BorderSide(
                          color: _getColorFromIndex(i),
                          width: _pinTheme.borderWidth,
                        ),
                      )
                    : Border.all(
                        color: _getColorFromIndex(i),
                        width: _pinTheme.borderWidth,
                      ),
              ),
              child: Center(
                child: AnimatedSwitcher(
                  switchInCurve: widget.animationCurve,
                  switchOutCurve: widget.animationCurve,
                  duration: widget.animationDuration,
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    if (widget.animationType == AnimationType.scale) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    } else if (widget.animationType == AnimationType.fade) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    } else if (widget.animationType == AnimationType.none) {
                      return child;
                    } else {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, .5),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    }
                  },
                  child: buildChild(i),
                ),
              ),
            )),
      );
    }
    return result;
  }

  void _onFocus() {
    if (_focusNode!.hasFocus &&
        MediaQuery.of(widget.appContext).viewInsets.bottom == 0) {
      _focusNode!.unfocus();
      Future<dynamic>.delayed(
          const Duration(microseconds: 1), () => _focusNode!.requestFocus());
    } else {
      _focusNode!.requestFocus();
    }
  }

  _setTextToInput(String data) async {
    final List<String> replaceInputList =
        List<String>.filled(widget.length, '');

    for (int i = 0; i < widget.length; i++) {
      replaceInputList[i] = data.length > i ? data[i] : '';
    }

    if (mounted) {
      setState(() {
        _selectedIndex = data.length;
        _inputList = replaceInputList;
      });
    }
  }

  List<Widget> _getActionButtons(String pastedText) {
    final List<Widget> resultList = <Widget>[];
    if (_dialogConfig.platform.toString() == Platform.isIOS.toString()) {
      resultList.addAll(<CupertinoDialogAction>[
        CupertinoDialogAction(
          child: Text(_dialogConfig.negativeText!),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        CupertinoDialogAction(
          child: Text(_dialogConfig.affirmativeText!),
          onPressed: () {
            _textEditingController!.text = pastedText;
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ]);
    } else {
      resultList.addAll(<Widget>[
        TextButton(
          child: Text(_dialogConfig.negativeText!),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        TextButton(
          child: Text(_dialogConfig.affirmativeText!),
          onPressed: () {
            _textEditingController!.text = pastedText;
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ]);
    }
    return resultList;
  }
}

class Gradiented extends StatelessWidget {
  const Gradiented({Key? key, required this.child, required this.gradient})
      : super(key: key);
  final Gradient gradient;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(shaderCallback: gradient.createShader, child: child);
  }
}

class CursorPainter extends CustomPainter {
  CursorPainter({this.cursorColor = Colors.black, this.cursorWidth = 2});
  final Color cursorColor;
  final double cursorWidth;

  @override
  void paint(Canvas canvas, Size size) {
    const Offset p1 = Offset(0, 0);
    final Offset p2 = Offset(0, size.height);
    final Paint paint = Paint()
      ..color = cursorColor
      ..strokeWidth = cursorWidth;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  // ignore: avoid_renaming_method_parameters
  bool shouldRepaint(CustomPainter oldDelecate) {
    return false;
  }
}

class PinTheme {
  const PinTheme.defaults({
    this.borderRadius = BorderRadius.zero,
    this.fieldHeight = 50,
    this.fieldWidth = 40,
    this.borderWidth = 2,
    this.fieldOuterPadding = EdgeInsets.zero,
    this.shape = PinCodeFieldShape.underline,
    this.activeColor = Colors.green,
    this.selectedColor = Colors.blue,
    this.inactiveColor = Colors.red,
    this.disabledColor = Colors.grey,
    this.activeFillColor = Colors.green,
    this.selectedFillColor = Colors.blue,
    this.inactiveFillColor = Colors.red,
    this.errorBorderColor = Colors.redAccent,
  });

  factory PinTheme(
      {Color? activeColor,
      Color? selectedColor,
      Color? inactiveColor,
      Color? disabledColor,
      Color? activeFillColor,
      Color? selectedFillColor,
      Color? inactiveFillColor,
      Color? errorBorderColor,
      BorderRadius? borderRadius,
      double? fieldHeight,
      double? fieldWidth,
      double? borderWidth,
      PinCodeFieldShape? shape,
      EdgeInsetsGeometry? fieldOuterPadding}) {
    const PinTheme defaultValues = PinTheme.defaults();
    return PinTheme.defaults(
      activeColor: activeColor ?? defaultValues.activeColor,
      activeFillColor: activeFillColor ?? defaultValues.activeFillColor,
      borderRadius: borderRadius ?? defaultValues.borderRadius,
      borderWidth: borderWidth ?? defaultValues.borderWidth,
      disabledColor: disabledColor ?? defaultValues.disabledColor,
      fieldHeight: fieldHeight ?? defaultValues.fieldHeight,
      fieldWidth: fieldWidth ?? defaultValues.fieldWidth,
      inactiveColor: inactiveColor ?? defaultValues.inactiveColor,
      inactiveFillColor: inactiveFillColor ?? defaultValues.inactiveFillColor,
      errorBorderColor: errorBorderColor ?? defaultValues.errorBorderColor,
      selectedColor: selectedColor ?? defaultValues.selectedColor,
      selectedFillColor: selectedFillColor ?? defaultValues.selectedFillColor,
      shape: shape ?? defaultValues.shape,
      fieldOuterPadding: fieldOuterPadding ?? defaultValues.fieldOuterPadding,
    );
  }
  final Color activeColor;
  final Color selectedColor;
  final Color inactiveColor;
  final Color disabledColor;
  final Color activeFillColor;
  final Color selectedFillColor;
  final Color inactiveFillColor;
  final Color errorBorderColor;
  final BorderRadius borderRadius;
  final double fieldHeight;
  final double fieldWidth;
  final double borderWidth;
  final PinCodeFieldShape shape;
  final EdgeInsetsGeometry fieldOuterPadding;
}

class DialogConfig {
  DialogConfig._internal({
    this.dialogContent,
    this.dialogTitle,
    this.affirmativeText,
    this.negativeText,
    this.platform,
  });

  factory DialogConfig(
      {String? affirmativeText,
      String? dialogContent,
      String? dialogTitle,
      String? negativeText,
      Platform? platform}) {
    return DialogConfig._internal(
      affirmativeText: affirmativeText ?? 'Paste',
      dialogContent: dialogContent ?? 'Do you want to paste this code ',
      dialogTitle: dialogTitle ?? 'Paste Code',
      negativeText: negativeText ?? 'Cancel',
      platform: platform,
    );
  }
  final String? dialogTitle;
  final String? dialogContent;
  final String? affirmativeText;
  final String? negativeText;
  final Platform? platform;
}

enum PinCodeFieldShape { box, underline, circle }

enum ErrorAnimationType { shake }

enum AnimationType { scale, slide, fade, none }

enum HapticFeedbackTypes {
  heavy,
  light,
  medium,
  selection,
  vibrate,
}
