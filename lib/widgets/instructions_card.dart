import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';

class InstructionsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: gameProvider.isAnimating 
                    ? [Colors.orange[100]!, Colors.orange[50]!]
                    : [Colors.blue[100]!, Colors.blue[50]!],
              ),
            ),
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  gameProvider.isAnimating ? Icons.autorenew : Icons.info_outline,
                  color: gameProvider.isAnimating ? Colors.orange[700] : Colors.blue[700],
                  size: 24,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    gameProvider.isAnimating 
                        ? 'Watch the magic! Boxes are turning red in reverse order...' 
                        : 'Tap red boxes to turn them green. Complete the sequence to see the reverse animation!',
                    style: TextStyle(
                      fontSize: 14,
                      color: gameProvider.isAnimating ? Colors.orange[800] : Colors.blue[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
