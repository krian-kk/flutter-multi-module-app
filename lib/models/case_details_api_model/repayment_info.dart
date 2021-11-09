class RepaymentInfo {
  String? reference2;
  String? officeMobile;

  RepaymentInfo({this.reference2, this.officeMobile});

  factory RepaymentInfo.fromJson(Map<String, dynamic> json) => RepaymentInfo(
        reference2: json['reference2'] as String?,
        officeMobile: json['officeMobile'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'reference2': reference2,
        'officeMobile': officeMobile,
      };
}
