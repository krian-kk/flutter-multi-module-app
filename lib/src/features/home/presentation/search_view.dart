import 'package:design_system/widgets/textFormField_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../gen/assets.gen.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5C8CE),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFC5C8CE),
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text('SEARCH ALLOCATION DETAILS',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF101010),
              )),
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(Assets.images.resetPasswordCross),
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: SizedBox(
            height: 575,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFormFieldWidget(
                  placeholder: 'Account No.',
                ),
                TextFormFieldWidget(
                  placeholder: 'Customer Name',
                ),
                TextFormFieldWidget(
                  placeholder: 'DPD/Bucket',
                ),
                TextFormFieldWidget(
                  placeholder: 'Status',
                ),
                TextFormFieldWidget(
                  placeholder: 'Pincode',
                ),
                TextFormFieldWidget(
                  placeholder: 'Customer ID',
                ),
                Column(
                  children: [
                    ChkBoxWithText(textVal: 'My Recent Activity'),
                    ChkBoxWithText(textVal: 'Show only STAR (High Priority)'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          height: 75,
          color: const Color(0xFFFFFFFF),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(191, 50),
                  backgroundColor: const Color(0xFFEA6D48),
                ),
                onPressed: () {},
                child: const Text(
                  'SEARCH',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class ChkBoxWithText extends StatefulWidget {
  final String textVal;

  const ChkBoxWithText({
    Key? key,
    required this.textVal,
  }) : super(key: key);

  @override
  State<ChkBoxWithText> createState() => _ChkBoxWithTextState();
}

class _ChkBoxWithTextState extends State<ChkBoxWithText> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          activeColor: const Color(0xFF23375A),
          onChanged: (newbool) {
            setState(() {
              isChecked = newbool;
            });
          },
        ),
        Text(
          widget.textVal,
          style: const TextStyle(
            color: Color(0xFF535050),
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
