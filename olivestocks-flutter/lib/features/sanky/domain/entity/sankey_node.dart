
part of 'sankey.dart';

base class SankeyNode {
  /// Unique name or label of the node.
  final String id;
  double value = 0;
  int? _level = null;
  bool isVisited = false;
  Set<String> children = {};


  SankeyNode({
    required this.id,
  });

  int? get level => _level;

  set level(int? value) {
    if (value != null && value < 0) {
      throw ArgumentError('Level cannot negative');
    }
    _level = value;
  }

}