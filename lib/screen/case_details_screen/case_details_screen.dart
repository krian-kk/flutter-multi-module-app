import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/screen/search_allocation_details_screen/search_allocation_details_screen.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

class CaseDetailsScreen extends StatefulWidget {
  CaseDetailsScreen({Key? key}) : super(key: key);

  @override
  _CaseDetailsScreenState createState() => _CaseDetailsScreenState();
}

class _CaseDetailsScreenState extends State<CaseDetailsScreen> {
  late CaseDetailsBloc bloc;

  late TextEditingController loanAmountController = TextEditingController();
  late TextEditingController loanDurationController = TextEditingController();
  late TextEditingController posController = TextEditingController();
  late TextEditingController schemeCodeController = TextEditingController();
  late TextEditingController emiStartStateController = TextEditingController();
  late TextEditingController bankNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc = CaseDetailsBloc()..add(CaseDetailsInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResource.colorE5E5E5,
        appBar: AppBar(
          backgroundColor: ColorResource.colorE5E5E5,
          title: CustomText(
            'CASE DETAILS',
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
          listener: (context, state) {
            // TODO: implement listener
          },
          child: BlocBuilder<CaseDetailsBloc, CaseDetailsState>(
            bloc: bloc,
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
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
                                height: 170,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        'DEBASISH PATNAIK',
                                        fontWeight: FontWeight.w700,
                                        fontSize: FontSize.fourteen,
                                        fontStyle: FontStyle.normal,
                                        color: ColorResource.color333333,
                                      ),
                                      const SizedBox(height: 11),
                                      CustomText(
                                        'Account No',
                                        fontWeight: FontWeight.w400,
                                        fontSize: FontSize.twelve,
                                        fontStyle: FontStyle.normal,
                                        color: ColorResource.color666666,
                                      ),
                                      const SizedBox(height: 9),
                                      CustomText(
                                        'TVSF_BFRT6524869550',
                                        fontWeight: FontWeight.w700,
                                        fontSize: FontSize.fourteen,
                                        fontStyle: FontStyle.normal,
                                        color: ColorResource.color333333,
                                      ),
                                      const SizedBox(height: 13),
                                      CustomText(
                                        'Overdue Amount',
                                        fontWeight: FontWeight.w400,
                                        fontSize: FontSize.twelve,
                                        fontStyle: FontStyle.normal,
                                        color: ColorResource.color666666,
                                      ),
                                      const SizedBox(height: 9),
                                      CustomText(
                                        '397553.67',
                                        fontWeight: FontWeight.w700,
                                        fontSize: FontSize.twentyFour,
                                        fontStyle: FontStyle.normal,
                                        color: ColorResource.color333333,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12.0),
                              child: Container(
                                width: 55,
                                height: 18,
                                decoration: new BoxDecoration(
                                    color: ColorResource.colorD5344C,
                                    borderRadius: new BorderRadius.all(
                                        Radius.circular(30.0))),
                                child: Center(
                                  child: CustomText(
                                    'NEW',
                                    color: ColorResource.colorFFFFFF,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: loanAmountController,
                        decoration: new InputDecoration(
                            hintText: "Enter Loan Amount.",
                            labelText: "Loan Amount",
                            labelStyle:
                                new TextStyle(color: const Color(0xFF424242))),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Container(
                            width: (MediaQuery.of(context).size.width - 62) / 2,
                            child: TextField(
                              controller: loanDurationController,
                              decoration: new InputDecoration(
                                  hintText: "Enter Loan Duration",
                                  labelText: "Loan Duration",
                                  focusColor: ColorResource.colorE5EAF6,
                                  labelStyle: new TextStyle(
                                      color: const Color(0xFF424242))),
                            ),
                          ),
                          const SizedBox(width: 22),
                          Container(
                            width: (MediaQuery.of(context).size.width - 62) / 2,
                            child: TextField(
                              controller: loanDurationController,
                              decoration: new InputDecoration(
                                  hintText: "Enter POS",
                                  labelText: "POS",
                                  focusColor: ColorResource.colorE5EAF6,
                                  labelStyle: new TextStyle(
                                      color: const Color(0xFF424242))),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Container(
                            width: (MediaQuery.of(context).size.width - 62) / 2,
                            child: TextField(
                              controller: loanDurationController,
                              decoration: new InputDecoration(
                                  hintText: "Enter Scheme Code",
                                  labelText: "Scheme Code",
                                  focusColor: ColorResource.colorE5EAF6,
                                  labelStyle: new TextStyle(
                                      color: const Color(0xFF424242))),
                            ),
                          ),
                          const SizedBox(width: 22),
                          Container(
                            width: (MediaQuery.of(context).size.width - 62) / 2,
                            child: TextField(
                              controller: loanDurationController,
                              decoration: new InputDecoration(
                                  hintText: "Enter EMI Start Date",
                                  labelText: "EMI Start Date",
                                  focusColor: ColorResource.colorE5EAF6,
                                  labelStyle: new TextStyle(
                                      color: const Color(0xFF424242))),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: loanDurationController,
                        decoration: new InputDecoration(
                            hintText: "Enter Bank Name",
                            labelText: "Bank Name",
                            focusColor: ColorResource.colorE5EAF6,
                            labelStyle:
                                new TextStyle(color: const Color(0xFF424242))),
                      ),
                      SizedBox(height: 23),
                      CustomText(
                        'REPAYMENT INFO',
                        fontSize: FontSize.sixteen,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: double.infinity,
                        height: 340,
                        decoration: new BoxDecoration(
                            color: ColorResource.colorFFFFFF,
                            border: Border.all(
                                color: ColorResource.colorDADADA, width: 0.5),
                            borderRadius:
                                new BorderRadius.all(Radius.circular(10.0))),
                        child: Column(
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
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    'Repayment Bank Name',
                                    fontSize: FontSize.twelve,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    color: ColorResource.color666666,
                                  ),
                                  const SizedBox(height: 8),
                                  CustomText(
                                    'Bank Name',
                                    fontSize: FontSize.fourteen,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    color: ColorResource.color333333,
                                  ),
                                  const SizedBox(height: 14),
                                  CustomText(
                                    'Reference Lender',
                                    fontSize: FontSize.twelve,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    color: ColorResource.color666666,
                                  ),
                                  const SizedBox(height: 8),
                                  CustomText(
                                    'Name',
                                    fontSize: FontSize.fourteen,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    color: ColorResource.color333333,
                                  ),
                                  const SizedBox(height: 14),
                                  CustomText(
                                    'Reference URL',
                                    fontSize: FontSize.twelve,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    color: ColorResource.color666666,
                                  ),
                                  const SizedBox(height: 8),
                                  CustomText(
                                    'URL',
                                    fontSize: FontSize.fourteen,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    color: ColorResource.color333333,
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomButton(
                                        'SEND SMS',
                                        width: 120,
                                        height: 40,
                                      ),
                                      SizedBox(width: 10),
                                      CustomButton(
                                        'SEND SMS',
                                        width: 155,
                                        height: 40,
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
                      CustomText('OTHER LOAN OF'),
                      CustomText('DEBASISH PATNAIK'),
                      SizedBox(height: 9),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 130,
                                  decoration: new BoxDecoration(
                                      color: ColorResource.colorF7F8FA,
                                      borderRadius: new BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText('Account No'),
                                        SizedBox(height: 9),
                                        CustomText('TVSF_BFRT6458922993'),
                                        SizedBox(height: 15),
                                        CustomText('Overdue Amount'),
                                        SizedBox(height: 9),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText('408559.17'),
                                            Row(
                                              children: [
                                                CustomText('VIEW'),
                                                const SizedBox(width: 10),
                                                Image.asset(
                                                    ImageResource.viewShape)
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
                  ),
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 138,
          decoration: new BoxDecoration(
              color: ColorResource.colorFFFFFF,
              borderRadius: new BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0))),
        ));
  }
}
