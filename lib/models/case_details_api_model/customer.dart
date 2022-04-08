class Customer {
  String? customerId;
  String? name;
  String? accNo;

  Customer({this.customerId, this.name, this.accNo});

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        customerId: json['customerId'] as String?,
        name: json['name'] as String?,
        accNo: json['accNo'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'customerId': customerId,
        'name': name,
        'accNo': accNo,
      };
}
