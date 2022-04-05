class Contact {
  Contact({
    this.cType,
    this.health,
    this.value,
    this.resAddressId0,
    this.contactId0,
    this.officeAddressId0,
    this.emailId0,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        cType: json['cType'] as String?,
        health: json['health'] as String?,
        value: json['value'] as String?,
        resAddressId0: json['resAddressId_0'] as String?,
        contactId0: json['contactId_0'] as String?,
        officeAddressId0: json['officeAddressId_0'] as String?,
        emailId0: json['emailId_0'] as String?,
      );
  String? cType;
  String? health;
  String? value;
  String? resAddressId0;
  String? contactId0;
  String? officeAddressId0;
  String? emailId0;

  Map<String, dynamic> toJson() => {
        'cType': cType,
        'health': health,
        'value': value,
        'resAddressId_0': resAddressId0,
        'contactId_0': contactId0,
        'officeAddressId_0': officeAddressId0,
        'emailId_0': emailId0,
      };
}
