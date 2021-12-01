class RepaymentInfo {
  String? reference2;
  String? officeMobile;
  String? repaymentIfscCode;
  String? benefeciaryAcc_No;
  String? benefeciaryAcc_Name;
  String? repayBankName;
  String? ref_url;
  String? refLender;

  RepaymentInfo({
    this.reference2,
    this.officeMobile,
    this.repaymentIfscCode,
    this.benefeciaryAcc_No,
    this.benefeciaryAcc_Name,
    this.repayBankName,
    this.ref_url,
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
        benefeciaryAcc_No: json['benefeciaryAcc_No'] != null
            ? json['benefeciaryAcc_No'] as String?
            : null,
        benefeciaryAcc_Name: json['benefeciaryAcc_Name'] != null
            ? json['benefeciaryAcc_Name'] as String?
            : null,
        repayBankName: json['repayBankName'] != null
            ? json['repayBankName'] as String?
            : null,
        ref_url: json['ref_url'] != null ? json['ref_url'] as String? : null,
        refLender:
            json['refLender'] != null ? json['refLender'] as String? : null,
      );

  Map<String, dynamic> toJson() => {
        'reference2': reference2,
        'officeMobile': officeMobile,
        'repaymentIfscCode': repaymentIfscCode,
        'benefeciaryAcc_No': benefeciaryAcc_No,
        'benefeciaryAcc_Name': benefeciaryAcc_Name,
        'repayBankName': repayBankName,
        'ref_url': ref_url,
        'refLender': refLender,
      };
}
