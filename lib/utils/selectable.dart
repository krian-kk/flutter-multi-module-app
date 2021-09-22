abstract class Selectable {
  String get displayName;
  bool isSelected = false;
}

abstract class SelectionModelProtocol {
  onSelection(String tag, List<Selectable> selection);
}
