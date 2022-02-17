import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:origa/listener/item_selected_listener.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
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
  final TextStyle? style;
  final double? titleSpacing;

  const CustomAppbar({
    Key? key,
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
  }) : super(key: key);

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
      // backwardsCompatibility: false,
      titleSpacing: widget.titleSpacing ?? 0,
      title:
          //  showSearch
          //     ? searchBar()
          //     :
          titleString != ''
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
                      margin: const EdgeInsets.only(left: 10),
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
        child: SvgPicture.asset(ImageResource.close),
        onTap: () {
          setState(() {
            widget.onItemSelected!('close');
          });
        },
      ),
    );
  }

  Widget? leadingIcon(BuildContext context) {
    Widget? leadingView;
    if (widget.iconEnumValues!.iconsString != IconEnum.empty.toString()) {
      leadingView = GestureDetector(
        child: widget.iconEnumValues!.icons,
        onTap: () {
          widget.onItemSelected!(widget.iconEnumValues!.iconsString);
        },
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
