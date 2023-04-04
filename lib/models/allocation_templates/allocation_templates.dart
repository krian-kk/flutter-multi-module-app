class AllocationTemplateConfig {
  AllocationTemplateConfig({this.fields});

  AllocationTemplateConfig.fromJson(Map<String, dynamic> json) {
    if (json['fields'] != null) {
      fields = <Fields>[];
      json['fields'].forEach((v) {
        fields!.add(Fields.fromJson(v));
      });
    }
  }

  List<Fields>? fields;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (fields != null) {
      data['fields'] = fields!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Fields {
  Fields(
      {this.key,
      this.csvName,
      this.type,
      this.required,
      this.limit,
      this.isAttribute,
      this.isActive,
      this.tableHeader});

  Fields.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    csvName = json['csv_name'];
    type = json['type'];
    required = json['required'];
    limit = json['limit'];
    isAttribute = json['isAttribute'];
    isActive = json['isActive'];
    tableHeader = json['tableHeader'];
  }

  String? key;
  String? csvName;
  String? type;
  bool? required;
  int? limit;
  bool? isAttribute;
  bool? isActive;
  String? tableHeader;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['csv_name'] = csvName;
    data['type'] = type;
    data['required'] = required;
    data['limit'] = limit;
    data['isAttribute'] = isAttribute;
    data['isActive'] = isActive;
    data['tableHeader'] = tableHeader;
    return data;
  }
}
