import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/no_allocation_screen/bloc/no_allocation_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';

class NoAllocationScreen extends StatefulWidget {
  const NoAllocationScreen({Key? key}) : super(key: key);

  @override
  _NoAllocationScreenState createState() => _NoAllocationScreenState();
}

class _NoAllocationScreenState extends State<NoAllocationScreen> {
  late NoAllocationBloc bloc;

  @override
  void initState() {
    bloc = NoAllocationBloc()..add(NoAllocationInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: ColorResource.colorF7F8FA,
      body: BlocListener<NoAllocationBloc, NoAllocationState>(
        bloc: bloc,
        listener: (context, state) {},
        child: BlocBuilder<NoAllocationBloc, NoAllocationState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is NoAllocationLoadingState) {
              return const CustomLoadingWidget();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: ColorResource.colorFFFFFF,
                        boxShadow: [
                          BoxShadow(
                            color: ColorResource.color000000.withOpacity(0.2),
                            blurRadius: 2.0,
                            offset: const Offset(1.0, 1.0),
                          )
                        ],
                        border: Border.all(
                          color: ColorResource.colorDADADA,
                          width: 0.5,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 19.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 65,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color:
                                    ColorResource.colorBEC4CF.withOpacity(0.3),
                                border: Border.all(
                                  color: ColorResource.colorDADADA,
                                  width: 0.5,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                )),
                            child: const SizedBox(),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: CustomText(
                              Languages.of(context)!.noAllocation,
                              color: ColorResource.color000000,
                              fontWeight: FontWeight.w700,
                              fontSize: FontSize.eighteen,
                            ),
                          ),
                          const SizedBox(height: 13),
                          CustomText(
                            Languages.of(context)!
                                .noAllocationMessage
                                .replaceAll('manager', 'Debashish'),
                            color: ColorResource.color000000,
                            fontWeight: FontWeight.w400,
                            fontSize: FontSize.sixteen,
                          ),
                          const CustomText(
                            '9841021453',
                            color: ColorResource.color000000,
                            fontWeight: FontWeight.w700,
                            fontSize: FontSize.sixteen,
                          ),
                          const SizedBox(height: 25),
                          CustomButton(
                            Languages.of(context)!.letsConnectWithManager,
                            buttonBackgroundColor: ColorResource.colorBEC4CF,
                            borderColor: ColorResource.colorDADADA,
                            cardShape: 50,
                            fontSize: FontSize.sixteen,
                            fontWeight: FontWeight.w700,
                            textColor: ColorResource.color23375A,
                          ),
                          const SizedBox(height: 21)
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        color: ColorResource.colorFFFFFF,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: CustomButton(
                  Languages.of(context)!.call.toUpperCase(),
                  fontSize: FontSize.sixteen,
                  cardShape: 5,
                  isLeading: true,
                  trailingWidget: SvgPicture.asset(ImageResource.vector),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
