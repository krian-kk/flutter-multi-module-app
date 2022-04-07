class UpdateHealthStatusModel {
  UpdateHealthStatusModel(
    this.selectedHealthIndex,
    this.tabIndex,
    this.currentHealth,
  );
  UpdateHealthStatusModel.fromJson(Map<String, dynamic> json) {
    selectedHealthIndex = json['selectedHealthIndex'];
    tabIndex = json['tabIndex'];
    currentHealth = json['currentHealth'];
  }
  late final int? selectedHealthIndex;
  late final int? tabIndex;
  late final dynamic currentHealth;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['selectedHealthIndex'] = selectedHealthIndex;
    data['tabIndex'] = tabIndex;
    data['currentHealth'] = currentHealth;
    return data;
  }
}
