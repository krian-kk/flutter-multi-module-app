import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/authentication/authentication_bloc.dart';
import 'package:origa/router.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/floating_action_button.dart';
import 'package:origa/widgets/widget_utils.dart';

import 'bloc/allocation_bloc.dart';

class AllocationScreen extends StatefulWidget {
  // AuthenticationBloc authenticationBloc;
  // AllocationScreen(this.authenticationBloc);

  @override
  _AllocationScreenState createState() => _AllocationScreenState();
}

class _AllocationScreenState extends State<AllocationScreen> {
  late AllocationBloc bloc;
  String version = "";

  @override
  void initState() {
    super.initState();
    bloc = AllocationBloc()..add(AllocationInitialEvent());
  }
  String selectedOption= StringResource.priority;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return BlocListener<AllocationBloc , AllocationState>(
       bloc: bloc,
      listener: (BuildContext context, AllocationState state) {
        // TODO: implement listener
      },
      child: BlocBuilder<AllocationBloc, AllocationState>(
         bloc: bloc,
        builder: (BuildContext context,AllocationState state) {
          return Scaffold(
            backgroundColor: ColorResource.colorF7F8FA,
            floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(
                      width: 175,
                      // padding: EdgeInsets.all(10),
                      child: CustomButton(
                        StringResource.message,
                        alignment: MainAxisAlignment.start,
                        cardShape: 50,
                        isLeading: true,
                        trailingWidget: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 40,
                            child: Container(
                              height: 26,
                              width: 26,
                              decoration: BoxDecoration(
                                color: ColorResource.colorffffff,
                                shape: BoxShape.circle,
                              ),
                              child: Center(child: CustomText(
                                '2',
                                fontSize: FontSize.twelve,
                                fontWeight: FontWeight.w700,
                                )),
                            ),
                          ),
                        ),
                        onTap: (){
                          AppUtils.showToast('Message');
                        },
                        ),
                        ),
                  ),
                    const Spacer(),
                  CustomFloatingActionButton(
                    onTap: (){
                      AppUtils.showToast('search');
                    },
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 9.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    
                    decoration: BoxDecoration(
                      color: ColorResource.colorffffff,
                      borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: ColorResource.colorECECEC, width: 1.0),
                      ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImageResource.location),
                        const SizedBox(width: 13.0,),
                        CustomText(
                          StringResource.areYouAtOffice,
                          fontSize: FontSize.twelve,
                          fontWeight: FontWeight.w700,
                          color: ColorResource.color000000,
                        ),
                        const SizedBox(width: 15.0,),
                        Container(
                          width: 80,
                          height: 40,
                          child: CustomButton(StringResource.yes,
                          fontSize: FontSize.twelve,
                          borderColor: ColorResource.colorEA6D48,
                          buttonBackgroundColor: ColorResource.colorEA6D48,
                          cardShape: 5,
                          )),
                          const SizedBox(width: 10.0,),
                          Container(
                          width: 80,
                          height: 40,
                          child: CustomButton(StringResource.no,
                          fontSize: FontSize.twelve,
                          textColor: ColorResource.color23375A,
                          buttonBackgroundColor: ColorResource.colorffffff,
                          cardShape: 5,
                          )),
                      ],
                    ),
                    ),
                  const SizedBox(height: 10.0,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(35, 55, 90, 0.27),
                      borderRadius: BorderRadius.circular(10),
                      ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(StringResource.searchbasedOn,
                        fontSize: FontSize.ten,
                        color: ColorResource.color000000,
                        fontWeight: FontWeight.w600,
                        ),
                        // const SizedBox(height: 10.0,),
                        CustomText(StringResource.pincode+' 636808',
                        fontSize: FontSize.fourteen,
                        color: ColorResource.color000000,
                        fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0,),
                  Wrap(
                   runSpacing: 10,
                    spacing: 10,
                    children: _buildSelectOptions(),
                  ),
                  const SizedBox(height: 8.0,),
                  CustomText('10 Allocation',
                        fontSize: FontSize.fourteen,
                        color: ColorResource.color000000,
                        fontWeight: FontWeight.w700,
                        ),
                  const SizedBox(height: 8.0,),
                  Expanded(child: WidgetUtils.buildListView(bloc))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildSelectOptions() {
    List<Widget> widgets = [];
    bloc.selectOptions.forEach((element) {
      widgets.add(_buildUpiIdWidget(element));
    });
    return widgets;
  }

    Widget _buildUpiIdWidget(String option) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedOption = option;
        });
        print(option);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 5, 8, 8),
        width: 84,
        // height: 35,
        decoration: BoxDecoration(
          border: Border.all(color: ColorResource.color23375A, width: 0.5),
          borderRadius: BorderRadius.circular(5),
          color:
              option == selectedOption ? ColorResource.color23375A : Colors.white,
        ),
        child: Center(
          child: CustomText(
            option,
            fontSize: FontSize.twelve,
            fontWeight: FontWeight.w700,
             color: option == selectedOption
                      ? Colors.white
                      : ColorResource.color000000,
            
          ),
        ),
      ),
    );
  }
}
