import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../gen/assets.gen.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFFE5E5E5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('RESET PASSWORD',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xFF23375A),
                    )),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF8F9FB),
                    elevation: 0,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: SvgPicture.asset(Assets.images.resetPasswordCross),
                  // child: const Icon(AllocationIcons.resetpassword_cross,
                  //     color: Color(0xFF23375A), size: 14),
                )
              ],
            ),
            const SizedBox(height: 40),
            TextFormField(
                decoration: InputDecoration(
              suffixIcon: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // side: const BorderSide(
                  //   width: 0.5,
                  //   color: Color(0xFF23375A),
                  // ),
                  minimumSize: const Size(85, 15),
                  backgroundColor: const Color(0xFF151515),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
                onPressed: () {},
                child: const Text('Check',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    )),
              ),
              hintText: 'User Name',
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                width: 1,
                color: Color(0xFFFFFFFF),
              )),
              hintStyle: const TextStyle(
                color: Color(0xFFCbcbd0),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              filled: true,
              fillColor: const Color(0xFFFFFFFF),
            )),
            const SizedBox(height: 30),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Mobile Number',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  width: 1,
                  color: Color(0xFFFFFFFF),
                )),
                hintStyle: TextStyle(
                  color: Color(0xFFCbcbd0),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                filled: true,
                fillColor: Color(0xFFFFFFFF),
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
                decoration: const InputDecoration(
              hintText: 'Password',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                width: 1,
                color: Color(0xFFFFFFFF),
              )),
              hintStyle: TextStyle(
                color: Color(0xFFCbcbd0),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              filled: true,
              fillColor: Color(0xFFFFFFFF),
            )),
            const SizedBox(height: 30),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Email',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  width: 1,
                  color: Color(0xFFFFFFFF),
                )),
                hintStyle: TextStyle(
                  color: Color(0xFFCbcbd0),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                filled: true,
                fillColor: Color(0xFFFFFFFF),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // side: const BorderSide(
                //   width: 0.5,
                //   color: Color(0xFF23375A),
                // ),
                minimumSize: const Size(320, 50),
                backgroundColor: const Color(0xFF999B9C),
                // elevation: 0,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
              ),
              onPressed: () {},
              child: const Text('Send OTP',
                  style: TextStyle(
                      color: Color(0xFFFEFFFF),
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
