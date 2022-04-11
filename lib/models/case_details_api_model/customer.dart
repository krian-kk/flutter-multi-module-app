class Customer {
  Customer({this.customerId, this.name, this.accNo});

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        customerId: json['customerId'] as String?,
        name: json['name'] as String?,
        accNo: json['accNo'] as String?,
      );
  String? customerId;
  String? name;
  String? accNo;

  Map<String, dynamic> toJson() => {
        'customerId': customerId,
        'name': name,
        'accNo': accNo,
      };
}
