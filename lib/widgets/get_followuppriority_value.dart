import 'package:flutter/material.dart';

class EventFollowUpPriority {
  static connectedFollowUpPriority(
      {required String currentCaseStatus,
      required String eventType,
      required String currentFollowUpPriority}) {
    debugPrint(
        'return connectedFollowUpPriority value ------> $currentCaseStatus $eventType $currentFollowUpPriority');
    try {
      if (EventFollowUpPriority.eventFollowUpPriority(currentCaseStatus) <=
          EventFollowUpPriority.eventFollowUpPriority(eventType)) {
        if (eventType == 'PTP' ||
            eventType == 'SURRENDER' ||
            eventType == 'OTS') {
          return eventType;
        } else if (eventType == 'Reminder' || eventType == 'Feedback') {
          return 'RETRY';
        } else if (eventType == 'Denial' ||
            eventType == 'Dispute' ||
            eventType == 'FIELDCOLLECT' ||
            eventType == 'Receipt' ||
            eventType == 'IMAGE CAPTURED' ||
            eventType == 'REPO') {
          return 'REVIEW';
        } else {
          return currentFollowUpPriority;
        }
      } else {
        return currentFollowUpPriority;
      }
    } catch (e) {
      debugPrint(
          'if check error ${e.toString()} and  $currentFollowUpPriority');
      return currentFollowUpPriority;
    }
  }

  static String unreachableFollowUpPriority(
      {required String currentCaseStatus,
      required String eventType,
      required String currentFollowUpPriority}) {
    debugPrint(
        'return unreachableFollowUpPriority value ------> $currentCaseStatus $eventType $currentFollowUpPriority');
    try {
      if (EventFollowUpPriority.eventFollowUpPriority(currentCaseStatus) <=
          EventFollowUpPriority.eventFollowUpPriority(eventType)) {
        return 'AWAITING CONTACT';
      } else {
        return currentFollowUpPriority;
      }
    } catch (e) {
      // debugPrint(e.toString());
      return currentFollowUpPriority;
    }
  }

  static phoneInvalidFollowUpPriority(
      {required String currentCaseStatus,
      required String eventType,
      required String currentFollowUpPriority}) {
    debugPrint(
        'return invalidFollowUpPriority value ------> $currentCaseStatus $eventType $currentFollowUpPriority');
    try {
      if (EventFollowUpPriority.eventFollowUpPriority(currentCaseStatus) <=
          EventFollowUpPriority.eventFollowUpPriority(eventType)) {
        return 'UNREACHABLE';
      } else {
        return currentFollowUpPriority;
      }
    } catch (e) {
      // debugPrint(e.toString());
      return currentFollowUpPriority;
    }
  }

  static eventFollowUpPriority(String followuppriority) {
    int? returnValue;
    switch (followuppriority) {
      case 'new':
        returnValue = 90;
        break;
      case 'PTP':
        returnValue = 100;
        break;
      case 'Reminder':
        returnValue = 95;
        break;
      case 'Feedback':
        returnValue = 95;
        break;
      case 'Denial':
        returnValue = 100;
        break;
      case 'Dispute':
        returnValue = 100;
        break;
      case 'Receipt':
        returnValue = 120;
        break;
      case 'REPO':
        returnValue = 119;
        break;
      case 'SURRENDER':
        returnValue = 200;
        break;
      case 'FIELDCOLLECT':
        returnValue = 200;
        break;
      case 'RNR':
        returnValue = 50;
        break;
      case 'Line Busy':
        returnValue = 50;
        break;
      case 'Switch Off':
        returnValue = 50;
        break;
      case 'Out Of Network':
        returnValue = 50;
        break;
      case 'Disconnecting':
        returnValue = 50;
        break;
      case 'Does Not Exist':
        returnValue = 20;
        break;
      case 'Incorrect Number':
        returnValue = 20;
        break;
      case 'Number Not Working':
        returnValue = 20;
        break;
      case 'Not Operational':
        returnValue = 20;
        break;
      case 'ots':
        returnValue = 20;
        break;
      case 'OTS':
        returnValue = 20;
        break;
      default:
        returnValue = null;
        break;
    }
    return returnValue;
  }
}
