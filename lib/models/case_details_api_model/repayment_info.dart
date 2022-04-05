class RepaymentInfo {
  RepaymentInfo({
    this.reference2,
    this.officeMobile,
    this.repaymentIfscCode,
    this.benefeciaryAccNo,
    this.benefeciaryAccName,
    this.repayBankName,
    this.refUrl,
    this.refLender,
  });

  factory RepaymentInfo.fromJson(Map<String, dynamic> json) => RepaymentInfo(
        reference2:
            json['reference2'] != null ? json['reference2'] as String? : null,
        officeMobile: json['officeMobile'] != null
            ? json['officeMobile'] as String?
            : null,
        repaymentIfscCode: json['repaymentIfscCode'] != null
            ? json['repaymentIfscCode'] as String?
            : null,
        benefeciaryAccNo: json['benefeciaryAcc_No'] != null
            ? json['benefeciaryAcc_No'] as String?
            : null,
        benefeciaryAccName: json['benefeciaryAcc_Name'] != null
            ? json['benefeciaryAcc_Name'] as String?
            : null,
        repayBankName: json['repayBankName'] != null
            ? json['repayBankName'] as String?
            : null,
        refUrl: json['ref_url'] != null ? json['ref_url'] as String? : null,
        refLender:
            json['refLender'] != null ? json['refLender'] as String? : null,
      );
  String? reference2;
  String? officeMobile;
  String? repaymentIfscCode;
  String? benefeciaryAccNo;
  String? benefeciaryAccName;
  String? repayBankName;
  String? refUrl;
  String? refLender;

  Map<String, dynamic> toJson() => {
        'reference2': reference2,
        'officeMobile': officeMobile,
        'repaymentIfscCode': repaymentIfscCode,
        'benefeciaryAcc_No': benefeciaryAccNo,
        'benefeciaryAcc_Name': benefeciaryAccName,
        'repayBankName': repayBankName,
        'ref_url': refUrl,
        'refLender': refLender,
      };
}
