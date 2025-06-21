import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../utils/c_shape_calculator.dart';
import 'animated_box.dart';

class BoxLayout extends StatelessWidget {
  final double screenWidth;

  const BoxLayout({Key? key, required this.screenWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        if (gameProvider.boxes.isEmpty) return SizedBox.shrink();

        final layout = CShapeCalculator.calculateLayout(gameProvider.numberOfBoxes);
        final boxSize = CShapeCalculator.calculateBoxSize(
          screenWidth - 32,
          layout.topBottomCount,
        );

        return Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildCShapeLayout(gameProvider, layout, boxSize),
          ),
        );
      },
    );
  }

  List<Widget> _buildCShapeLayout(GameProvider gameProvider, CShapeLayout layout, double boxSize) {
    List<Widget> rows = [];
    int boxIndex = 0;

    // Top row
    List<Widget> topBoxes = [];
    for (int i = 0; i < layout.topBottomCount && boxIndex < gameProvider.boxes.length; i++) {
      topBoxes.add(AnimatedBox(
        box: gameProvider.boxes[boxIndex],
        size: boxSize,
        delay: i * 100,
        onTap: () => gameProvider.onBoxTap(boxIndex),
      ));
      boxIndex++;
    }
    
    rows.add(
      Container(
        width: double.infinity,
        child: Wrap(
          alignment: WrapAlignment.start,
          children: topBoxes,
        ),
      ),
    );

    // Middle rows
    for (int i = 0; i < layout.middleCount && boxIndex < gameProvider.boxes.length; i++) {
      rows.add(
        Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AnimatedBox(
                box: gameProvider.boxes[boxIndex],
                size: boxSize,
                delay: (i + layout.topBottomCount) * 100,
                onTap: () => gameProvider.onBoxTap(boxIndex),
              ),
            ],
          ),
        ),
      );
      boxIndex++;
    }

    // Bottom row
    if (boxIndex < gameProvider.boxes.length) {
      List<Widget> bottomBoxes = [];
      for (int i = 0; i < layout.topBottomCount && boxIndex < gameProvider.boxes.length; i++) {
        bottomBoxes.add(AnimatedBox(
          box: gameProvider.boxes[boxIndex],
          size: boxSize,
          delay: (i + layout.topBottomCount + layout.middleCount) * 100,
          onTap: () => gameProvider.onBoxTap(boxIndex),
        ));
        boxIndex++;
      }
      
      rows.add(
        Container(
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.start,
            children: bottomBoxes,
          ),
        ),
      );
    }

    return rows;
  }
}
