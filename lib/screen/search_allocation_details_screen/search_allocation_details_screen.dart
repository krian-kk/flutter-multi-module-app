import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/screen/search_allocation_details_screen/bloc/search_allocation_details_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

class SearchAllocationDetailsScreen extends StatefulWidget {
  SearchAllocationDetailsScreen({Key? key}) : super(key: key);

  @override
  _SearchAllocationDetailsScreenState createState() =>
      _SearchAllocationDetailsScreenState();
}

class _SearchAllocationDetailsScreenState
    extends State<SearchAllocationDetailsScreen> {
  late SearchAllocationDetailsBloc bloc;

  late TextEditingController accountNoController = TextEditingController();
  late TextEditingController customerNameController = TextEditingController();
  late TextEditingController bucketController = TextEditingController();
  late TextEditingController statusController = TextEditingController();
  late TextEditingController pincodeController = TextEditingController();
  late TextEditingController customerIDController = TextEditingController();

  bool value1 = false;
  bool value2 = false;

  @override
  void initState() {
    super.initState();
    bloc = SearchAllocationDetailsBloc()
      ..add(SearchAllocationDetailsInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        // appBar: CustomAppbar(
        //   titleString: StringResource.searchAllocationDetails,
        // ),
        // appBar: AppBar(
        //   backgroundColor: ColorResource.colorC5C8CE,
        //   automaticallyImplyLeading: false,
        //   title: Text(StringResource.searchAllocationDetails),
        //   centerTitle: false,
        //   leadingWidth: 0.0,
        //   titleTextStyle: TextStyle(
        //       color: ColorResource.color101010,
        //       fontWeight: FontWeight.w700,
        //       fontSize: FontSize.sixteen),
        //   elevation: 0.0,
        //   actions: [
        //     GestureDetector(
        //         onTap: () {
        //           Navigator.pop(context);
        //         },
        //         child: Image.asset(ImageResource.close))
        //   ],
        // ),
        backgroundColor: ColorResource.colorC5C8CE,
        body: BlocListener<SearchAllocationDetailsBloc,
            SearchAllocationDetailsState>(
          bloc: bloc,
          listener: (context, state) {
            // TODO: implement listener
          },
          child: BlocBuilder<SearchAllocationDetailsBloc,
              SearchAllocationDetailsState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is SearchAllocationDetailsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  CustomAppbar(
                    titleString: StringResource.searchAllocationDetails,
                    titleSpacing: 21,
                    showClose: true,
                    onItemSelected: (value) {
                      if (value == 'close') {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  CustomTextField(
                                    StringResource.accountNo + '.',
                                    accountNoController,
                                  ),
                                  const SizedBox(height: 21),
                                  CustomTextField(
                                    StringResource.customerName,
                                    customerNameController,
                                  ),
                                  const SizedBox(height: 21),
                                  CustomTextField(
                                    StringResource.dpdBucket,
                                    bucketController,
                                  ),
                                  const SizedBox(height: 21),
                                  CustomTextField(
                                    StringResource.status,
                                    statusController,
                                  ),
                                  const SizedBox(height: 21),
                                  CustomTextField(
                                    StringResource.pincode,
                                    pincodeController,
                                  ),
                                  const SizedBox(height: 21),
                                  CustomTextField(
                                    StringResource.myRecentActivity,
                                    customerIDController,
                                  ),
                                  const SizedBox(height: 21),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        value1 = !value1;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(value1
                                            ? ImageResource.checkOn
                                            : ImageResource.checkOff),
                                        const SizedBox(width: 13),
                                        CustomText(
                                            StringResource.myRecentActivity)
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        value2 = !value2;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(value2
                                            ? ImageResource.checkOn
                                            : ImageResource.checkOff),
                                        const SizedBox(width: 13),
                                        CustomText(
                                            StringResource.showOnlyTopResults)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          color: ColorResource.colorFFFFFF,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 85, vertical: 11.0),
            child: Container(
              child: CustomButton(
                StringResource.sEARCH,
                cardShape: 5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Color? colour;
  final Color? hintTextColour;
  final bool obsecureText;
  final Color? hoverColor;
  final Color? fillColor;
  final double? height;
  final double borderRadius;
  final Widget? suffixWidget;
  final bool isEnable;
  final bool isReadOnly;
  final Function? onTapped;
  final Widget? prefixWidget;
  final TextInputType keyBoardType;
  final int? maximumWordCount;
  final BorderStyle borderStyle;
  final Color borderColour;
  final double borderWidth;
  final Color cursorColor;

  CustomTextField(this.hintText, this.controller,
      {this.colour = ColorResource.colorFFFFFF,
      this.hintTextColour,
      this.obsecureText = false,
      this.hoverColor = ColorResource.color000000,
      this.fillColor = ColorResource.color000000,
      this.height = 50,
      this.borderRadius = 5.0,
      this.suffixWidget,
      this.isEnable = true,
      this.isReadOnly = false,
      this.onTapped,
      this.prefixWidget,
      this.keyBoardType = TextInputType.name,
      this.maximumWordCount = 1,
      this.borderColour = ColorResource.colorDADADA,
      this.borderWidth = 1.0,
      this.cursorColor = ColorResource.colorDADADA,
      this.borderStyle = BorderStyle.solid});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
          color: widget.colour,
          border: Border.all(
              width: widget.borderWidth,
              color: widget.borderColour,
              style: widget.borderStyle)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: TextField(
          obscureText: widget.obsecureText,
          cursorColor: widget.cursorColor,
          decoration: InputDecoration(
              fillColor: widget.fillColor,
              hoverColor: widget.hoverColor,
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle:
                  TextStyle(color: ColorResource.color101010.withOpacity(0.3))),
        ),
      ),
    );
  }
}

// class CustomAppBar1 extends StatefulWidget implements PreferredSizeWidget {
//   final Widget child;
//   final double height;

//   CustomAppBar1({
//     required this.child,
//     this.height = kToolbarHeight,
//   });
//   @override
//   Size get preferredSize => Size.fromHeight(height);

//   @override
//   State<CustomAppBar1> createState() => _CustomAppBar1State();
// }

// class _CustomAppBar1State extends State<CustomAppBar1> {
//   @override
//   Size get preferredSize => Size.fromHeight(widget.height);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: preferredSize.height,
//       color: Colors.orange,
//       alignment: Alignment.center,
//       child: widget.child,
//     );
//   }
// }
