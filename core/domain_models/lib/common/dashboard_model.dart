class DashboardListModel {
  DashboardListModel({
    this.title,
    this.subTitle,
    this.image,
    this.count,
    this.amountRs,
  });

  String? title;
  String? subTitle;
  String? image;
  String? count;
  String? amountRs;
}

class FilterCasesByTimePeriod {
  FilterCasesByTimePeriod({
    this.timePeriodText,
    this.value,
  });

  String? timePeriodText;
  String? value;
}
