// import 'package:flutter/material.dart';
// import 'package:origa/utils/color_resource.dart';

// //enum to declare 3 state of button
// enum ButtonState { init, submitting, completed }

// class ButtonStates extends StatefulWidget {
//   const ButtonStates({Key? key}) : super(key: key);
//   @override
//   _ButtonStatesState createState() => _ButtonStatesState();
// }

// bool isAnimating = true;

// class _ButtonStatesState extends State<ButtonStates> {
//   ButtonState state = ButtonState.init;
//   @override
//   Widget build(BuildContext context) {
//     final buttonWidth = MediaQuery.of(context).size.width;
//     // update the UI depending on below variable values
//     final isInit = isAnimating || state == ButtonState.init;
//     final isDone = state == ButtonState.completed;
//     return Scaffold(
//       body: Container(
//         alignment: Alignment.center,
//         padding: EdgeInsets.all(40),
//         child: AnimatedContainer(
//             duration: Duration(milliseconds: 300),
//             onEnd: () => setState(() {
//                   isAnimating = !isAnimating;
//                 }),
//             width: state == ButtonState.init ? buttonWidth : 70,
//             height: 50,
//             // If Button State is Submiting or Completed  show 'buttonCircular' widget as below
//             child: isInit ? buildButton() : circularContainer(isDone)),
//       ),
//     );
//   }

//   // If Button State is init : show Normal submit button
//   Widget buildButton() => ElevatedButton(
//         style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
//         onPressed: () async {
//           // here when button is pressed
//           // we are changing the state
//           // therefore depending on state our button UI changed.
//           setState(() {
//             state = ButtonState.submitting;
//           });
//           //await 2 sec // you need to implement your server response here.
//           await Future.delayed(Duration(seconds: 2));
//           setState(() {
//             state = ButtonState.completed;
//           });
//           await Future.delayed(Duration(seconds: 2));
//           setState(() {
//             state = ButtonState.init;
//           });
//         },
//         child: const Text('SUBMIT'),
//       );
//   // this is custom Widget to show rounded container
//   // here is state is submitting, we are showing loading indicator on container then.
//   // if it completed then showing a Icon.
//   Widget circularContainer(bool done) {
//     final color = done ? ColorResource.color23375A : ColorResource.color23375A;
//     return Container(
//       decoration: BoxDecoration(shape: BoxShape.circle, color: color),
//       height: 50,
//       child: Center(
//         child: done
//             ? const SizedBox(
//                 height: 30,
//                 width: 30,
//                 child: Icon(Icons.done, size: 30, color: Colors.white))
//             : const SizedBox(
//                 height: 30,
//                 width: 30,
//                 child: CircularProgressIndicator(
//                   color: ColorResource.colorffffff,
//                   strokeWidth: 3,
//                 ),
//               ),
//       ),
//     );
//   }
// }
