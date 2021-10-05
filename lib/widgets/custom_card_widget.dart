import 'package:flutter/material.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_text.dart';

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
  dynamic? title;
  dynamic? subTitle;
  dynamic? amount;
  dynamic? amountrs;
  dynamic? price;
  dynamic? count;

  GlobalKey<_CustomCardState> _myKey = GlobalKey();

  CustomCard(
      this.elevation,
      this.child,
      {
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

      });

  @override
  _CustomCardState createState() => _CustomCardState();
}

  class _CustomCardState extends State<CustomCard> {
    @override
    Widget build(BuildContext context) {
      return Container(
        height: widget.height,
        width: widget.width,
        margin: EdgeInsets.only(left: 15,right: 15,top: 10),
        child: Card(
          elevation: widget.elevation,
        shape: widget.shape,
        shadowColor: widget.shadowColor,
          clipBehavior: widget.clipBehavior,
        child: widget.child,
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
           // Container(
           //   margin: EdgeInsets.only(left: 5,top: 8),
           //   padding: EdgeInsets.all(8),
           //   decoration: BoxDecoration(
           //     shape: BoxShape.circle,
           //     color: ColorResource.color23375A.withOpacity(0.2),
           //   ),
           //   child: Row(
           //     children: [
           //       SizedBox(
           //         height: 15,
           //         width: 15,
           //         child:
           //       Image.asset(ImageResource.vectorArrow),),
           //     ],
           //   ),
           // ),
           //
          // ],
        ),
        color: widget.color,
      );

    }


  }

