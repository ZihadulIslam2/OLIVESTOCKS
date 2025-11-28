part of 'sankey.dart';

base class SankeyLink {
  String source;
  String target;
  double value;

  SankeyLink({
    required this.source,
    required this.target,
    required this.value,
  });

  factory SankeyLink.fromMap(Map<String, dynamic> map) {
    return SankeyLink(
      source: map['source'] as String,
      target: map['target'] as String,
      value: map['value'] as double,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SankeyLink &&
        other.source == source &&
        other.target == target &&
        other.value == value;
  }

  @override
  int get hashCode => Object.hash(source, target, value);
}

