import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/imagecaptured_post_model.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';

class CustomCaptureImageBottomSheet extends StatefulWidget {
  const CustomCaptureImageBottomSheet(this.cardTitle,
      {Key? key,
      required this.customerLoanUserDetailsWidget,
      required this.bloc})
      : super(key: key);
  final String cardTitle;
  final Widget customerLoanUserDetailsWidget;
  final CaseDetailsBloc bloc;

  @override
  State<CustomCaptureImageBottomSheet> createState() =>
      _CustomCaptureImageBottomSheetState();
}

class _CustomCaptureImageBottomSheetState
    extends State<CustomCaptureImageBottomSheet> {
  TextEditingController remarksControlller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  List uploadFileLists = [];

  @override
  void initState() {
    super.initState();
  }

  getFiles() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);
    if (result != null) {
      uploadFileLists =
          result.files.map((path) => path.path.toString()).toList();
      // print(uploadFileLists);
    } else {
      // User canceled the picker
      AppUtils.showToast('Canceled', gravity: ToastGravity.CENTER);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.89,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomSheetAppbar(
                title: widget.cardTitle,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15)
                        .copyWith(bottom: 5),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        widget.customerLoanUserDetailsWidget,
                        const SizedBox(height: 11),
                        CustomButton(
                          Languages.of(context)!.customUpload,
                          fontWeight: FontWeight.w700,
                          trailingWidget:
                              SvgPicture.asset(ImageResource.upload),
                          fontSize: FontSize.sixteen,
                          buttonBackgroundColor: ColorResource.color23375A,
                          borderColor: ColorResource.colorDADADA,
                          cardShape: 50,
                          cardElevation: 1,
                          isLeading: true,
                          onTap: () async {
                            getFiles();
                          },
                        ),
                        const SizedBox(height: 15),
                        Flexible(
                            child: CustomReadOnlyTextField(
                          Languages.of(context)!.remarks,
                          remarksControlller,
                          validationRules: const ['required'],
                          isLabel: true,
                          // validationRules: ['required'],
                        )),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
            color: ColorResource.colorFFFFFF,
            boxShadow: [
              BoxShadow(
                color: ColorResource.color000000.withOpacity(.25),
                blurRadius: 2.0,
                offset: const Offset(1.0, 1.0),
              ),
            ],
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: SizedBox(
                      width: 95,
                      child: Center(
                          child: CustomText(
                        Languages.of(context)!.cancel.toUpperCase(),
                        color: ColorResource.colorEA6D48,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        fontSize: FontSize.sixteen,
                      ))),
                ),
                const SizedBox(width: 25),
                SizedBox(
                  width: 191,
                  child: CustomButton(
                    Languages.of(context)!.submit.toUpperCase(),
                    fontSize: FontSize.sixteen,
                    fontWeight: FontWeight.w600,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (uploadFileLists.isNotEmpty) {
                          var requestBodyData = PostImageCapturedModel(
                              caseId: widget.bloc.caseId.toString(),
                              eventAttr: EventAttr(
                                remarks: remarksControlller.text,
                                imageLocation: uploadFileLists as List<String>,
                              ));
                          widget.bloc.add(PostImageCapturedEvent(
                              postData: requestBodyData));
                        } else {
                          AppUtils.showToast(
                            Languages.of(context)!.customUpload.toLowerCase(),
                            gravity: ToastGravity.CENTER,
                          );
                        }
                      }
                    },
                    cardShape: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
