import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/add_new_contact_model.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_drop_down_button.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';

class AddNewContactBottomSheet extends StatefulWidget {
  const AddNewContactBottomSheet(
      {Key? key, required this.customerLoanUserWidget})
      : super(key: key);
  final Widget customerLoanUserWidget;

  @override
  State<AddNewContactBottomSheet> createState() =>
      _AddNewContactBottomSheetState();
}

class _AddNewContactBottomSheetState extends State<AddNewContactBottomSheet> {
  TextEditingController nextActionDateControlller = TextEditingController();
  List<AddNewContactFieldModel> listOfContact = [
    AddNewContactFieldModel(TextEditingController(), 'select'),
  ];

  @override
  Widget build(BuildContext context) {
    List<String> dropDownList = [
      'select',
      'Residence Address',
      'Mobile',
      'Office Address',
      'Office Contact No.',
      'Email Id',
      'Residence Contact No.'
    ];
    return WillPopScope(
      onWillPop: () async => false,
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.89,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BottomSheetAppbar(
                  title: Languages.of(context)!.addNewContact.toUpperCase(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15)
                          .copyWith(bottom: 5),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          widget.customerLoanUserWidget,
                          const SizedBox(height: 11),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: listOfContact.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                          child: CustomDropDownButton(
                                        Languages.of(context)!
                                            .customerContactNo,
                                        dropDownList,
                                        selectedValue:
                                            listOfContact[index].formValue,
                                        onChanged: (newValue) => setState(
                                          () => listOfContact[index].formValue =
                                              newValue.toString(),
                                        ),
                                        icon: SvgPicture.asset(
                                            ImageResource.downShape),
                                      )),
                                      CustomReadOnlyTextField(
                                        'Phone Number 01',
                                        listOfContact[index].controller,
                                        isLabel: true,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                          const SizedBox(height: 20),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  listOfContact.add(AddNewContactFieldModel(
                                    TextEditingController(),
                                    'select',
                                  ));
                                });
                              },
                              child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                    color: ColorResource.colorFFFFFF,
                                    border: Border.all(
                                        color: ColorResource.color23375A,
                                        width: 0.5),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0))),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 11),
                                  child: CustomText(
                                    'ADD MORE CONTACT',
                                    fontWeight: FontWeight.w700,
                                    fontSize: FontSize.thirteen,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
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
                        onTap: () async {},
                        cardShape: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
