import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/customer_met_model.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/image_resource.dart';

part 'telecaller_phone_event.dart';
part 'telecaller_phone_state.dart';

class TelecallerPhoneBloc
    extends Bloc<TelecallerPhoneEvent, TelecallerPhoneState> {
  List<CustomerMetGridModel> addressCustomerMetGridList = [];
  List<CustomerMetGridModel> phoneCustomerMetGridList = [];
  final phoneInvalidFormKey = GlobalKey<FormState>();
  final phoneUnreachableFormKey = GlobalKey<FormState>();
  FocusNode phoneUnreachableNextActionDateFocusNode = FocusNode();
  FocusNode phoneUnreachableRemarksFocusNode = FocusNode();
  FocusNode phoneInvalidRemarksFocusNode = FocusNode();
  TextEditingController phoneUnreachableNextActionDateController =
      TextEditingController();
  String phoneUnreachableSelectedDate = '';
  String phoneSelectedUnreadableClip = '';
  String phoneSelectedInvalidClip = '';
  TextEditingController phoneUnreachableRemarksController =
      TextEditingController();
  TextEditingController phoneInvalidRemarksController = TextEditingController();
  TelecallerPhoneBloc() : super(TelecallerPhoneInitial()) {
    on<TelecallerPhoneEvent>((event, emit) {
      if (event is TelecallerInitialPhoneEvent) {
        emit.call(TelecallerPhoneLoadingState());
        addressCustomerMetGridList.addAll([
          CustomerMetGridModel(ImageResource.ptp,
              Languages.of(event.context!)!.ptp.toUpperCase(),
              onTap: () =>
                  add(ClickOpenBottomSheetEvent(Constants.ptp, [], false))),
          CustomerMetGridModel(ImageResource.rtp,
              Languages.of(event.context!)!.rtp.toUpperCase(),
              onTap: () =>
                  add(ClickOpenBottomSheetEvent(Constants.rtp, [], false))),
          CustomerMetGridModel(ImageResource.dispute,
              Languages.of(event.context!)!.dispute.toUpperCase(),
              onTap: () =>
                  add(ClickOpenBottomSheetEvent(Constants.dispute, [], false))),
          CustomerMetGridModel(
              ImageResource.remainder,
              (Languages.of(event.context!)!.remainderCb.toUpperCase())
                  .toUpperCase(),
              onTap: () => add(
                  ClickOpenBottomSheetEvent(Constants.remainder, [], false))),
          CustomerMetGridModel(ImageResource.collections,
              Languages.of(event.context!)!.collections.toUpperCase(),
              onTap: () => add(
                  ClickOpenBottomSheetEvent(Constants.collections, [], false))),
          CustomerMetGridModel(ImageResource.ots,
              Languages.of(event.context!)!.ots.toUpperCase(),
              onTap: () =>
                  add(ClickOpenBottomSheetEvent(Constants.ots, [], false))),
        ]);

        phoneCustomerMetGridList.addAll([
          CustomerMetGridModel(ImageResource.ptp,
              Languages.of(event.context!)!.ptp.toUpperCase(),
              onTap: () =>
                  add(ClickOpenBottomSheetEvent(Constants.ptp, [], true)),
              isCall: true),
          CustomerMetGridModel(ImageResource.rtp,
              Languages.of(event.context!)!.rtp.toUpperCase(),
              onTap: () =>
                  add(ClickOpenBottomSheetEvent(Constants.rtp, [], true)),
              isCall: true),
          CustomerMetGridModel(ImageResource.dispute,
              Languages.of(event.context!)!.dispute.toUpperCase(),
              onTap: () =>
                  add(ClickOpenBottomSheetEvent(Constants.dispute, [], true)),
              isCall: true),
          CustomerMetGridModel(
              ImageResource.remainder,
              (Languages.of(event.context!)!.remainderCb.toUpperCase())
                  .toUpperCase()
                  .toUpperCase(),
              onTap: () =>
                  add(ClickOpenBottomSheetEvent(Constants.remainder, [], true)),
              isCall: true),
          CustomerMetGridModel(ImageResource.collections,
              Languages.of(event.context!)!.collections.toUpperCase(),
              onTap: () => add(
                  ClickOpenBottomSheetEvent(Constants.collections, [], true)),
              isCall: true),
          CustomerMetGridModel(ImageResource.ots, Constants.ots,
              onTap: () => add(ClickOpenBottomSheetEvent(
                  Languages.of(event.context!)!.ots.toUpperCase(), [], true)),
              isCall: true),
        ]);
        emit.call(TelecallerPhoneLoadedState());
      }
    });
  }
}
