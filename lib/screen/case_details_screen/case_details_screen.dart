import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/base/base_state.dart';
//import 'package:origa/base/base_state.dart';
import 'package:origa/models/customer_met_model.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/screen/search_allocation_details_screen/search_allocation_details_screen.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/custom_text_form_field.dart';
import 'package:url_launcher/url_launcher.dart';

class CaseDetailsScreen extends StatefulWidget {
  CaseDetailsScreen({Key? key}) : super(key: key);

  @override
  _CaseDetailsScreenState createState() => _CaseDetailsScreenState();
}

class _CaseDetailsScreenState extends State<CaseDetailsScreen> {
  late TextEditingController bankNameController = TextEditingController();
  late CaseDetailsBloc bloc;
  late TextEditingController emiStartStateController = TextEditingController();
  late TextEditingController loanAmountController = TextEditingController();
  late TextEditingController loanDurationController = TextEditingController();
  late TextEditingController posController = TextEditingController();
  late TextEditingController schemeCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc = CaseDetailsBloc()..add(CaseDetailsInitialEvent());
  }

  Widget CustomDraggableScrollableSheet(ScrollController scrollController) {
    return Container(
        decoration: new BoxDecoration(
            color: ColorResource.colorFFFFFF,
            borderRadius: new BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0))),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    trailing: Wrap(
                      spacing: 12, // space between two icons
                      children: <Widget>[
                        Icon(Icons.call), // icon-1
                        Image.asset(ImageResource.close) // icon-2
                      ],
                    ),
                    title: CustomText(
                        '2/345, 6th Main Road Gomathipuram, Madurai - 625032'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Image.asset(ImageResource.checkOn),
                        SizedBox(width: 21),
                        Image.asset(ImageResource.checkOff),
                        Spacer(),
                        Row(
                          children: [
                            CustomText(StringResource.vIEW),
                            SizedBox(width: 10),
                            Image.asset(ImageResource.viewShape)
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            // ignore: prefer_const_constructors
            DefaultTabController(
              length: 3,
              // ignore: prefer_const_constructors
              child: Column(children: [
                TabBar(
                  isScrollable: true,
                  indicatorColor: ColorResource.colorD5344C,
                  indicatorWeight: 5.0,
                  labelColor: ColorResource.color23375A,
                  unselectedLabelColor: ColorResource.colorC4C4C4,
                  // ignore: prefer_const_literals_to_create_immutables
                  tabs: [
                    // ignore: prefer_const_constructors
                    Tab(text: StringResource.customerMet),
                    // ignore: prefer_const_constructors
                    Tab(text: StringResource.customerNotMet),
                    // ignore: prefer_const_constructors
                    Tab(text: StringResource.invalid)
                  ],
                ),
                SizedBox(
                  height: 300,
                  child: TabBarView(
                    children: [
                      firstTabView(),
                      secondTabView(),
                      firstTabView(),
                    ],
                  ),
                ),
              ]),
            )
          ],
        ));
  }

  Widget firstTabView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 21.0),
        child: Column(
          children: [
            GridView.builder(
              itemCount: bloc.customerMetList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (BuildContext context, int innerIndex) {
                return Padding(
                  padding: const EdgeInsets.all(4.5),
                  child: Container(
                    decoration: new BoxDecoration(
                        color: ColorResource.colorF8F9FB,
                        boxShadow: [
                          BoxShadow(
                            color: ColorResource.color000000.withOpacity(0.2),
                            blurRadius: 2.0,
                            offset: Offset(
                                1.0, 1.0), // shadow direction: bottom right
                          )
                        ],
                        borderRadius:
                            new BorderRadius.all(Radius.circular(10.0))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(bloc.customerMetList[innerIndex].icon),
                        SizedBox(height: 8),
                        CustomText(
                          bloc.customerMetList[innerIndex].title,
                          color: ColorResource.color000000,
                          fontSize: FontSize.twelve,
                          fontWeight: FontWeight.w700,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 30),
            Container(
              decoration: new BoxDecoration(
                  color: ColorResource.colorF7F8FA,
                  borderRadius: new BorderRadius.all(Radius.circular(10.0))),
              width: double.infinity,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 19.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: 150,
                            height: 50,
                            child: CustomButton(
                              'REPO',
                            )),
                        Container(
                            width: 150,
                            height: 50,
                            child: CustomButton(
                              'Add Contact',
                            )),
                      ],
                    ),
                    Container(
                      height: 110,
                      width: 150,
                      decoration: new BoxDecoration(
                          color: ColorResource.color23375A,
                          borderRadius:
                              new BorderRadius.all(Radius.circular(5.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(ImageResource.captureImage),
                          SizedBox(height: 5),
                          CustomText(
                            'CAPTURE \nIMAGE',
                            textAlign: TextAlign.center,
                            color: ColorResource.colorFFFFFF,
                            fontSize: FontSize.sixteen,
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget secondTabView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                  child: Container(
                    width: 139,
                    height: 40,
                    child: CustomButton(
                      'LEFT MESSAGE',
                      textColor: ColorResource.color000000,
                      buttonBackgroundColor:
                          ColorResource.colorFFB800.withOpacity(0.67),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                  child: Container(
                    width: 162,
                    height: 40,
                    child: CustomButton(
                      'DOOR LOCKED',
                      buttonBackgroundColor: ColorResource.colorE7E7E7,
                      textColor: ColorResource.color000000,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                  child: Container(
                    width: 171,
                    height: 40,
                    child: CustomButton(
                      'ENTRY RESTRICTED',
                      textColor: ColorResource.color000000,
                      buttonBackgroundColor: ColorResource.colorE7E7E7,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Align(
                alignment: Alignment.centerLeft,
                child: CustomText('NEXT ACTION DATE*')),
            Container(
              width: (MediaQuery.of(context).size.width - 62) / 2,
              child: TextField(
                controller: loanDurationController,
                decoration: new InputDecoration(
                    suffixIcon: GestureDetector(
                        onTap: () {}, child: const Icon(Icons.calendar_today)),
                    labelText: StringResource.loanDuration,
                    focusColor: ColorResource.colorE5EAF6,
                    labelStyle: new TextStyle(color: const Color(0xFF424242))),
              ),
            ),
            Container(
              decoration: new BoxDecoration(
                  color: ColorResource.colorF7F8FA,
                  borderRadius: new BorderRadius.all(Radius.circular(10.0))),
              width: double.infinity,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 19.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: 150,
                            height: 50,
                            child: CustomButton(
                              'REPO',
                            )),
                        Container(
                            width: 150,
                            height: 50,
                            child: CustomButton(
                              'Add Contact',
                            )),
                      ],
                    ),
                    Container(
                      height: 110,
                      width: 150,
                      decoration: new BoxDecoration(
                          color: ColorResource.color23375A,
                          borderRadius:
                              new BorderRadius.all(Radius.circular(5.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(ImageResource.captureImage),
                          SizedBox(height: 5),
                          CustomText(
                            'CAPTURE \nIMAGE',
                            textAlign: TextAlign.center,
                            color: ColorResource.colorFFFFFF,
                            fontSize: FontSize.sixteen,
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResource.colorE5E5E5,
      appBar: AppBar(
        backgroundColor: ColorResource.colorE5E5E5,
        title: CustomText(
          StringResource.caseDetials,
          fontWeight: FontWeight.w700,
        ),
        leading: Image.asset(
          ImageResource.back,
          width: 16,
        ),
        centerTitle: false,
        elevation: 0.0,
      ),
      body: BlocListener<CaseDetailsBloc, CaseDetailsState>(
        bloc: bloc,
        listener: (context, state) {},
        child: BlocBuilder<CaseDetailsBloc, CaseDetailsState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is CaseDetailsLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Stack(
                children: [
                  SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 179,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        // ignore: unnecessary_new
                                        decoration: new BoxDecoration(
                                            color: ColorResource.colorD4F5CF,
                                            borderRadius: new BorderRadius.all(
                                                Radius.circular(10.0))),
                                        width: double.infinity,

                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              CustomText(
                                                'DEBASISH PATNAIK',
                                                fontWeight: FontWeight.w700,
                                                fontSize: FontSize.fourteen,
                                                fontStyle: FontStyle.normal,
                                                color:
                                                    ColorResource.color333333,
                                              ),
                                              const SizedBox(height: 9),
                                              CustomText(
                                                StringResource.accountNo,
                                                fontWeight: FontWeight.w400,
                                                fontSize: FontSize.twelve,
                                                fontStyle: FontStyle.normal,
                                                color:
                                                    ColorResource.color666666,
                                              ),
                                              const SizedBox(height: 7),
                                              CustomText(
                                                'TVSF_BFRT6524869550',
                                                fontWeight: FontWeight.w700,
                                                fontSize: FontSize.fourteen,
                                                fontStyle: FontStyle.normal,
                                                color:
                                                    ColorResource.color333333,
                                              ),
                                              const SizedBox(height: 11),
                                              CustomText(
                                                StringResource.overdueAmount,
                                                fontWeight: FontWeight.w400,
                                                fontSize: FontSize.twelve,
                                                fontStyle: FontStyle.normal,
                                                color:
                                                    ColorResource.color666666,
                                              ),
                                              const SizedBox(height: 7),
                                              CustomText(
                                                '397553.67',
                                                fontWeight: FontWeight.w700,
                                                fontSize: FontSize.twentyFour,
                                                fontStyle: FontStyle.normal,
                                                color:
                                                    ColorResource.color333333,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 55,
                                      height: 18,
                                      decoration: new BoxDecoration(
                                          color: ColorResource.colorD5344C,
                                          borderRadius: new BorderRadius.all(
                                              Radius.circular(30.0))),
                                      child: Center(
                                        child: CustomText(
                                          StringResource.nEW,
                                          color: ColorResource.colorFFFFFF,
                                          fontSize: FontSize.ten,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              CustomTextFormField(
                                  '67793', StringResource.loanAmount),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Container(
                                    width: (MediaQuery.of(context).size.width -
                                            62) /
                                        2,
                                    child: CustomTextFormField(
                                        '24', StringResource.loanDuration),
                                  ),
                                  const SizedBox(width: 22),
                                  Container(
                                    width: (MediaQuery.of(context).size.width -
                                            62) /
                                        2,
                                    child: CustomTextFormField(
                                        '128974', StringResource.pos),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Container(
                                    width: (MediaQuery.of(context).size.width -
                                            62) /
                                        2,
                                    child: CustomTextFormField(
                                        '34', StringResource.schemeCode),
                                  ),
                                  const SizedBox(width: 22),
                                  Container(
                                    width: (MediaQuery.of(context).size.width -
                                            62) /
                                        2,
                                    child: CustomTextFormField('08-09-2017',
                                        StringResource.emiStartDate),
                                    // child: TextFormField(
                                    //   readOnly: true,
                                    //   initialValue: '08-09-2017',
                                    //   //controller: loanDurationController,
                                    //   decoration: new InputDecoration(
                                    //       labelText:
                                    //           StringResource.emiStartDate,
                                    //       focusColor: ColorResource.colorE5EAF6,
                                    //       labelStyle: new TextStyle(
                                    //           color: const Color(0xFF424242))),
                                    // ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              CustomTextFormField(
                                  'TVS', StringResource.bankName),
                              // TextFormField(
                              //   initialValue: 'TVS',
                              //   //controller: loanDurationController,
                              //   readOnly: true,
                              //   decoration: new InputDecoration(
                              //       labelText: StringResource.bankName,
                              //       focusColor: ColorResource.colorE5EAF6,
                              //       labelStyle: new TextStyle(
                              //           color: const Color(0xFF424242))),
                              // ),
                              SizedBox(height: 17),
                              CustomTextFormField('2W', StringResource.product),
                              SizedBox(height: 17),
                              CustomTextFormField('HAR_50CASES-16102020_015953',
                                  StringResource.batchNo),
                              // TextFormField(
                              //   initialValue: 'HAR_50CASES-16102020_015953',
                              //   //controller: loanDurationController,
                              //   readOnly: true,
                              //   decoration: new InputDecoration(
                              //       labelText: StringResource.batchNo,
                              //       focusColor: ColorResource.colorE5EAF6,
                              //       labelStyle: new TextStyle(
                              //           color: const Color(0xFF424242))),
                              // ),
                              SizedBox(height: 23),
                              CustomText(
                                StringResource.repaymentInfo,
                                fontSize: FontSize.sixteen,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
                              const SizedBox(height: 5),
                              Container(
                                width: double.infinity,
                                decoration: new BoxDecoration(
                                    color: ColorResource.colorFFFFFF,
                                    border: Border.all(
                                        color: ColorResource.colorDADADA,
                                        width: 0.5),
                                    borderRadius: new BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(6.0),
                                      width: double.infinity,
                                      height: 97,
                                      decoration: new BoxDecoration(
                                          color: ColorResource.colorF7F8FA,
                                          borderRadius: new BorderRadius.all(
                                              Radius.circular(10.0))),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              StringResource.beneficiaryDetails,
                                              fontWeight: FontWeight.w400,
                                              fontSize: FontSize.twelve,
                                              fontStyle: FontStyle.normal,
                                              color: ColorResource.color666666,
                                            ),
                                            const SizedBox(height: 9),
                                            CustomText(
                                              'TVSF FINANCE',
                                              fontWeight: FontWeight.w700,
                                              color: ColorResource.color333333,
                                              fontSize: FontSize.fourteen,
                                              fontStyle: FontStyle.normal,
                                            ),
                                            const SizedBox(height: 7),
                                            CustomText(
                                              'SBI_BFRT6458922993',
                                              fontWeight: FontWeight.w700,
                                              color: ColorResource.color333333,
                                              fontSize: FontSize.fourteen,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 12.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            StringResource.repaymentBankName,
                                            fontSize: FontSize.twelve,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            color: ColorResource.color666666,
                                          ),
                                          const SizedBox(height: 4),
                                          CustomText(
                                            'Bank Name',
                                            fontSize: FontSize.fourteen,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w700,
                                            color: ColorResource.color333333,
                                          ),
                                          const SizedBox(height: 10),
                                          CustomText(
                                            StringResource.referenceLender,
                                            fontSize: FontSize.twelve,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            color: ColorResource.color666666,
                                          ),
                                          const SizedBox(height: 4),
                                          CustomText(
                                            'Name',
                                            fontSize: FontSize.fourteen,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w700,
                                            color: ColorResource.color333333,
                                          ),
                                          const SizedBox(height: 10),
                                          CustomText(
                                            StringResource.referenceURL,
                                            fontSize: FontSize.twelve,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            color: ColorResource.color666666,
                                          ),
                                          const SizedBox(height: 4),
                                          CustomText(
                                            'URL',
                                            fontSize: FontSize.fourteen,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w700,
                                            color: ColorResource.color333333,
                                          ),
                                          const SizedBox(height: 12),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 100,
                                                child: CustomButton(
                                                  StringResource.sendSMS,
                                                  onTap: () async {
                                                    const uri =
                                                        'sms:+39 348 060 888?body=hello%20there';
                                                    if (await canLaunch(uri)) {
                                                      await launch(uri);
                                                    } else {
                                                      const uri =
                                                          'sms:0039-222-060-888?body=hello%20there';
                                                      if (await canLaunch(
                                                          uri)) {
                                                        await launch(uri);
                                                      } else {
                                                        throw 'Could not launch $uri';
                                                      }
                                                    }
                                                  },
                                                  buttonBackgroundColor:
                                                      ColorResource.color23375A,
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                width: 175,
                                                child: CustomButton(
                                                  StringResource.sendWHATSAPP,
                                                  isLeading: true,
                                                  trailingWidget: Image.asset(
                                                      ImageResource.whatsApp),
                                                  onTap: () async {
                                                    const url =
                                                        "https://wa.me/?text=Hey buddy, try this super cool new app!";
                                                    if (await canLaunch(url)) {
                                                      await launch(url);
                                                    } else {
                                                      throw 'Could not launch $url';
                                                    }
                                                  },
                                                  buttonBackgroundColor:
                                                      ColorResource.color23375A,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 27),
                              CustomText(StringResource.oTHERLOANOF),
                              CustomText(StringResource.dEBASISHPATNAIK),
                              SizedBox(height: 9),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 3,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          decoration: new BoxDecoration(
                                              boxShadow: [
                                                new BoxShadow(
                                                  color: ColorResource
                                                      .color000000
                                                      .withOpacity(.25),
                                                  blurRadius: 2.0,
                                                  offset: Offset(1.0, 1.0),
                                                ),
                                              ],
                                              border: Border.all(
                                                  color:
                                                      ColorResource.colorDADADA,
                                                  width: 0.5),
                                              color: ColorResource.colorF7F8FA,
                                              borderRadius:
                                                  new BorderRadius.all(
                                                      Radius.circular(10.0))),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 12),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                    StringResource.accountNo),
                                                SizedBox(height: 5),
                                                CustomText(
                                                    'TVSF_BFRT6458922993'),
                                                SizedBox(height: 11),
                                                CustomText(StringResource
                                                    .overdueAmount),
                                                SizedBox(height: 5),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CustomText('408559.17'),
                                                    Row(
                                                      children: [
                                                        CustomText(
                                                          StringResource.vIEW,
                                                          color: ColorResource
                                                              .color23375A,
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Image.asset(
                                                            ImageResource
                                                                .viewShape)
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    );
                                  }),
                            ],
                          ))),
                ],
              );
            }
          },
        ),
      ),
      // bottomNavigationBar: SizedBox.expand(
      //   child: DraggableScrollableSheet(
      //     initialChildSize: 1,
      //     minChildSize: 1,
      //     maxChildSize: 1,
      //     builder: (BuildContext context, ScrollController scrollController) {
      //       return CustomDraggableScrollableSheet(scrollController);
      //     },
      //   ),
      // )
    );
  }
}
