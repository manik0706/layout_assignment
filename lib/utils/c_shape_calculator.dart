class CShapeLayout {
  final int topBottomCount;
  final int middleCount;

  CShapeLayout({
    required this.topBottomCount,
    required this.middleCount,
  });
}

class CShapeCalculator {
  static CShapeLayout calculateLayout(int numberOfBoxes) {
    int topBottomCount;
    int middleCount;

    // Special handling for different numbers to ensure proper C shape
    if (numberOfBoxes == 5) {
      topBottomCount = 2; // Top: 2, Middle: 1, Bottom: 2
      middleCount = 1;
    } else if (numberOfBoxes == 6) {
      topBottomCount = 2; // Top: 2, Middle: 2, Bottom: 2
      middleCount = 2;
    } else if (numberOfBoxes == 7) {
      topBottomCount = 2; // Top: 2, Middle: 3, Bottom: 2
      middleCount = 3;
    } else if (numberOfBoxes == 8) {
      topBottomCount = 3; // Top: 3, Middle: 2, Bottom: 3
      middleCount = 2;
    } else {
      // For larger numbers, use proportional distribution
      topBottomCount = (numberOfBoxes / 3).ceil();
      middleCount = numberOfBoxes - (topBottomCount * 2);
      
      // Ensure we don't have negative middle count
      if (middleCount < 0) {
        topBottomCount = (numberOfBoxes / 2).floor();
        middleCount = numberOfBoxes - (topBottomCount * 2);
      }
    }

    return CShapeLayout(
      topBottomCount: topBottomCount,
      middleCount: middleCount,
    );
  }

  static double calculateBoxSize(double availableWidth, int maxBoxesInRow) {
    const double maxBoxSize = 80.0;
    const double minBoxSize = 35.0;
    const double marginPerBox = 8.0;
    
    double calculatedBoxSize = (availableWidth - (maxBoxesInRow * marginPerBox)) / maxBoxesInRow;
    return calculatedBoxSize.clamp(minBoxSize, maxBoxSize);
  }
}
