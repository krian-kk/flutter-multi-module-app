import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final double? elevation;
  Color? color;
  ShapeBorder? shape;
  bool? semanticContainer;
  Clip? clipBehavior;
  BorderRadius? borderRadius;
  Widget? child;
  BoxShadow? shadow;
  Color? shadowColor;
  double? height;
  double? width;
  dynamic title;
  dynamic subTitle;
  dynamic amount;
  dynamic amountrs;
  dynamic price;
  dynamic count;

  CustomCard({
    Key? key,
    this.semanticContainer = true,
    this.shadowColor,
    this.borderRadius,
    this.shape,
    this.color,
    this.clipBehavior,
    this.width,
    this.height,
    this.title,
    this.subTitle,
    this.amount,
    this.amountrs,
    this.count,
    this.price,
    this.elevation,
    this.child,
  }) : super(key: key);

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: Container(
        height: widget.height,
        width: widget.width,
        child: Card(
          elevation: widget.elevation,
          shape: widget.shape,
          shadowColor: widget.shadowColor,
          clipBehavior: widget.clipBehavior,
          child: widget.child,
        ),
        color: widget.color,
      ),
    );
  }
}
