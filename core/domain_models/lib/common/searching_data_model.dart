class SearchingDataModel {
  SearchingDataModel(
      {this.accountNumber,
      this.customerID,
      this.customerName,
      this.bankName,
      this.dpdBucket,
      this.pincode,
      this.status,
      this.isStarCases,
      this.isMyRecentActivity});

  String? accountNumber;
  String? customerName;
  String? dpdBucket;
  String? status;
  String? pincode;
  String? customerID;
  String? bankName;
  bool? isStarCases;
  bool? isMyRecentActivity;
}
