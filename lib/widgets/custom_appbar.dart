import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:origa/listener/item_selected_listener.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/widget_utils.dart';

import 'custom_text.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  final bool? showSettings;
  final bool? showNotification;
  final bool? showFilter;
  final bool? showClose;
  final bool? showDownload;
  final bool? isAuthentication;
  final bool? showSearch;
  final bool? showTextButton;
  final String? textButtonString;
  final Color? backgroundColor;
  final OnItemSelected? onItemSelected;
  final OnChange? onChanged;
  final String? titleString;
  final String? subTitle;
  final String? clear;
  final int? actionIndex;
  final int? notificationCount;
  final IconEnum? iconEnumValues;
  TextEditingController? controller = TextEditingController();
  final TextStyle? style;
  final double? titleSpacing;
  GlobalKey<_CustomAppbarState> _myKey = GlobalKey();

  CustomAppbar(
      {Key? key,
      this.titleString,
      this.subTitle,
      this.actionIndex = 0,
      this.iconEnumValues = IconEnum.empty,
      this.showNotification = false,
      this.showDownload = false,
      this.clear,
      this.showFilter = false,
      this.showClose = false,
      this.showSettings = false,
      this.showTextButton = false,
      this.textButtonString = '',
      this.isAuthentication = false,
      this.showSearch = false,
      this.onItemSelected,
      this.onChanged,
      this.notificationCount = 0,
      this.backgroundColor = Colors.transparent,
      this.style,
      this.titleSpacing,
      this.controller})
      : super(key: key);

  @override
  _CustomAppbarState createState() => _CustomAppbarState();

  @override
  Size get preferredSize => throw UnimplementedError();
}

class _CustomAppbarState extends State<CustomAppbar> {
  bool showCancel = false;
  bool showSearch = false;
  String titleString = '';
  IconEnum icons = IconEnum.empty;

  @override
  void initState() {
    super.initState();
    titleString = widget.titleString!;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 40,
      elevation: 0.0,
      centerTitle: false,
      backgroundColor: widget.backgroundColor,
      automaticallyImplyLeading: false,
      backwardsCompatibility: false,
      titleSpacing: widget.titleSpacing ?? 0,
      title:
          //  showSearch
          //     ? searchBar()
          //     :
          titleString != null || titleString != ''
              ? widget.subTitle == null || widget.subTitle == ''
                  ? CustomText(
                      titleString,
                      style: TextStyle(
                          color: ColorResource.color101010,
                          fontFamily: Font.latoRegular.toString(),
                          fontWeight: FontWeight.w700,
                          fontSize: FontSize.sixteen),
                    )
                  : Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            titleString,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    color: ColorResource.colorffffff,
                                    fontFamily: Font.latoRegular.toString(),
                                    fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          CustomText(
                            widget.subTitle!,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                    color: ColorResource.colorffffff,
                                    fontFamily: Font.latoRegular.toString(),
                                    fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    )
              : const SizedBox(),
      actions: <Widget>[
        // searchButton(context),
        // notificationButton(context),
        // textButton(context),
        // filterIconButton(context),
        // downloadIconButton(context),
        // if (widget.clear != null) clearButton(context),
        // settingsButton(context),
        closeButton(context),
      ],
      leading: leadingIcon(context),
    );
  }

  void setUpdateState() {
    setState(() {});
  }

  Widget closeButton(BuildContext context) {
    return Visibility(
      visible: widget.showClose!,
      child: GestureDetector(
        child: Image.asset(ImageResource.close),
        onTap: () {
          setState(() {
            widget.onItemSelected!('close');
          });
        },
      ),
    );
  }

  //   Widget actionView(BuildContext context, int? actionIndex) {
  //   return Visibility(
  //     child: WidgetUtils.actionViewWidget(actionIndex!),
  //     visible: true,
  //   );
  // }

  // Widget searchBar() {
  //   showCancel = widget.controller?.text.isNotEmpty == true;
  //   return Container(
  //     height: 40,
  //     margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
  //     padding: const EdgeInsets.only(left: 5.0),
  //     alignment: Alignment.centerLeft,
  //     decoration: const BoxDecoration(
  //       borderRadius: BorderRadius.all(Radius.circular(5.0)),
  //     ),
  //     child: TextFormField(
  //       autofocus: true,
  //       controller: widget.controller,
  //       cursorColor: Colors.white,
  //       decoration: InputDecoration(
  //         hintMaxLines: 1,
  //         hintText: StringResource.search,
  //         border: InputBorder.none,
  //         fillColor: Colors.grey,
  //         suffixIcon: GestureDetector(
  //           child: const Icon(Icons.clear, size: 28, color: Colors.white),
  //           onTap: () {
  //             setState(() {
  //               widget.onItemSelected!('');
  //               widget.controller?.clear();
  //               showSearch = false;
  //               if (widget.onChanged != null) widget.onChanged!('');
  //             });
  //           },
  //         ),
  //         hintStyle: Theme.of(context).textTheme.headline5!.copyWith(
  //             color: ColorResource.color,
  //             fontFamily: Font.sourceSansProRegular.toString(),
  //             fontWeight: FontWeight.w400),
  //       ),
  //       keyboardType: TextInputType.text,
  //       style: Theme.of(context).textTheme.bodyText1!.copyWith(
  //           color: ColorResource.colorFAFAFA,
  //           fontFamily: Font.sourceSansProRegular.toString(),
  //           fontWeight: FontWeight.w600),
  //       onFieldSubmitted: (String stringValues) {
  //         widget.onItemSelected!(stringValues);
  //         FocusScope.of(context).requestFocus(FocusNode());
  //       },
  //       onChanged: (String stringValues) {
  //         if (widget.onChanged != null && stringValues.isNotEmpty) {
  //           widget.onChanged!(stringValues);
  //         }
  //         if (stringValues.isNotEmpty == true && showCancel == false) {
  //           widget.onItemSelected!(stringValues);
  //           setState(() {
  //             showCancel = true;
  //           });
  //         } else if (stringValues.isEmpty) {
  //           widget.onItemSelected!('');
  //         } else if (stringValues.isEmpty == true && showCancel == true) {
  //           widget.onItemSelected!('');
  //           setState(() {
  //             showCancel = false;
  //           });
  //         }
  //       },
  //     ),
  //   );
  // }

  // Widget searchButton(BuildContext context) {
  //   return Visibility(
  //     visible: showSearch == true
  //         ? false
  //         : widget.showSearch == true
  //             ? true
  //             : false,
  //     child: GestureDetector(
  //       child: Container(
  //         margin: EdgeInsets.only(right: 8),
  //         // padding: const EdgeInsets.symmetric(horizontal: 5),
  //         child: Image.asset(
  //           ImageResource.search,
  //         ),
  //       ),
  //       onTap: () {
  //         setState(() {
  //           showSearch = true;
  //           // widget.onItemSelected!('searchTriggering');
  //         });
  //       },
  //     ),
  //   );
  // }

  // Widget settingsButton(BuildContext context) {
  //   return Visibility(
  //     visible: showSearch == true ? false : widget.showSettings!,
  //     child: GestureDetector(
  //       child: const Image(image: AssetImage(ImageResource.settings_icon)),
  //       onTap: () {
  //         setState(() {
  //           widget.onItemSelected!('settingTriggering');
  //         });
  //       },
  //     ),
  //   );
  // }

  // Widget notificationButton(BuildContext context) {
  //   return Visibility(
  //     visible: showSearch == true ? false : widget.showNotification!,
  //     child: GestureDetector(
  //       child: Container(
  //         alignment: Alignment.center,
  //         child: Stack(
  //           alignment: Alignment.topRight,
  //           children: [
  //             Container(
  //               margin: const EdgeInsets.only(top: 5),
  //               child: const Image(
  //                   image: AssetImage(
  //                       ImageResource.dashboardAppbariconsnotifications)),
  //             ),
  //             if (widget.notificationCount != 0)
  //               Container(
  //                 alignment: Alignment.center,
  //                 child: CustomText(
  //                   widget.notificationCount! > 10
  //                       ? '10+'
  //                       : widget.notificationCount.toString(),
  //                   style: Theme.of(context).textTheme.caption!.copyWith(
  //                       color: ColorResource.colorFFFFFF,
  //                       fontSize: 8,
  //                       fontWeight: FontWeight.w700),
  //                   textAlign: TextAlign.center,
  //                 ),
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(10),
  //                   color: ColorResource.colorFF781F,
  //                 ),
  //                 height: 19,
  //                 width: 19,
  //               ),
  //           ],
  //         ),
  //       ),
  //       onTap: () {
  //         setState(() {
  //           widget.onItemSelected!('notificationTriggering');
  //         });
  //       },
  //     ),
  //   );
  // }

  // Widget textButton(BuildContext context) {
  //   return Visibility(
  //       visible: showSearch == true ? false : widget.showTextButton!,
  //       child: GestureDetector(
  //         child: Container(
  //           padding: EdgeInsets.fromLTRB(0, 20, 10, 0),
  //           child: CustomText(
  //             widget.textButtonString!,
  //             style: Theme.of(context).textTheme.subtitle1!.copyWith(
  //                 color: ColorResource.colorFF781F,
  //                 fontFamily: Font.sourceSansProRegular.toString(),
  //                 fontWeight: FontWeight.w600),
  //           ),
  //         ),
  //         onTap: () {
  //           setState(() {
  //             widget.onItemSelected!('textButtonTriggering');
  //           });
  //         },
  //       ));
  // }

  // Widget filterIconButton(BuildContext context) {
  //   return Visibility(
  //     visible: widget.showFilter!,
  //     child: GestureDetector(
  //       child: Container(
  //         height: 40,
  //         width: 40,
  //         margin: EdgeInsets.only(right: 10),
  //         decoration: BoxDecoration(
  //           shape: BoxShape.circle,
  //           color: ColorResource.color530141,
  //         ),
  //         alignment: Alignment.center,
  //         child: Container(
  //           child: const Image(image: AssetImage(ImageResource.filter)),
  //         ),
  //       ),
  //       onTap: () {
  //         setState(() {
  //           widget.onItemSelected!('filter');
  //         });
  //       },
  //     ),
  //   );
  // }

  // Widget downloadIconButton(BuildContext context) {
  //   return Visibility(
  //     visible: widget.showFilter! || widget.showDownload!,
  //     child: GestureDetector(
  //       child: Container(
  //         margin: const EdgeInsets.only(right: 8),
  //         height: 40,
  //         width: 40,
  //         decoration: const BoxDecoration(
  //           shape: BoxShape.circle,
  //           color: ColorResource.color530141,
  //         ),
  //         alignment: Alignment.center,
  //         child: const SizedBox(
  //           child: Image(image: AssetImage(ImageResource.download_icon)),
  //         ),
  //       ),
  //       onTap: () {
  //         setState(() {
  //           widget.onItemSelected!('download');
  //         });
  //       },
  //     ),
  //   );
  // }

  // Widget clearButton(BuildContext context) {
  //   return GestureDetector(
  //     child: Container(
  //       margin: const EdgeInsets.only(right: 10),
  //       alignment: Alignment.center,
  //       child: CustomText(
  //         widget.clear!,
  //         style: Theme.of(context).textTheme.subtitle1!.copyWith(
  //             color: ColorResource.colorFF781F,
  //             fontFamily: Font.sourceSansProRegular.toString(),
  //             fontWeight: FontWeight.w600),
  //       ),
  //     ),
  //     onTap: () {
  //       setState(() {
  //         widget.onItemSelected!(Constants.clearAll);
  //       });
  //     },
  //   );
  // }

  Widget? leadingIcon(BuildContext context) {
    Widget? leadingView;
    if (widget.iconEnumValues!.iconsString != IconEnum.empty.toString()) {
      leadingView = Container(
        child: GestureDetector(
          child: widget.iconEnumValues!.icons,
          onTap: () {
            widget.onItemSelected!(widget.iconEnumValues!.iconsString);
          },
        ),
      );
    }
    return leadingView;
  }
}

enum IconEnum { close, back, menu, empty }

extension IconExtension on IconEnum {
  Widget get icons {
    switch (this) {
      case IconEnum.close:
        return const Icon(
          Icons.close,
          color: Colors.black,
          size: 25,
        );
      case IconEnum.back:
        return const Icon(
          Icons.arrow_back,
          color: Colors.black,
        );
      case IconEnum.menu:
        return const Icon(Icons.menu);
      case IconEnum.empty:
        return Container();
      default:
        return Container();
    }
  }

  String get iconsString {
    switch (this) {
      case IconEnum.close:
        return IconEnum.close.toString();
      case IconEnum.back:
        return IconEnum.back.toString();
      case IconEnum.menu:
        return IconEnum.menu.toString();
      case IconEnum.empty:
        return IconEnum.empty.toString();
      default:
        return IconEnum.empty.toString();
    }
  }
}
