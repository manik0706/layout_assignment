class BoxModel {
  final int index;
  final bool isGreen;
  final int? clickOrder;

  BoxModel({
    required this.index,
    this.isGreen = false,
    this.clickOrder,
  });

  BoxModel copyWith({
    int? index,
    bool? isGreen,
    int? clickOrder,
  }) {
    return BoxModel(
      index: index ?? this.index,
      isGreen: isGreen ?? this.isGreen,
      clickOrder: clickOrder ?? this.clickOrder,
    );
  }
}
