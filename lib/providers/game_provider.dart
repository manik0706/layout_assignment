import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../models/box_model.dart';
import '../models/game_stats.dart';
import '../utils/c_shape_calculator.dart';

class GameProvider extends ChangeNotifier {
  int _numberOfBoxes = 0;
  List<BoxModel> _boxes = [];
  List<int> _clickOrder = [];
  bool _isAnimating = false;
  String _errorMessage = '';
  Timer? _animationTimer;
  GameStats _stats = GameStats();

  // Getters
  int get numberOfBoxes => _numberOfBoxes;
  List<BoxModel> get boxes => _boxes;
  List<int> get clickOrder => _clickOrder;
  bool get isAnimating => _isAnimating;
  String get errorMessage => _errorMessage;
  GameStats get stats => _stats;
  bool get hasBoxes => _numberOfBoxes > 0;
  bool get allBoxesGreen => _boxes.isNotEmpty && _boxes.every((box) => box.isGreen);

  void generateBoxes(String input) {
    if (input.isEmpty) {
      _setError('Please enter a number');
      return;
    }

    final number = int.tryParse(input);
    if (number == null || number < 5 || number > 25) {
      _setError('Please enter a number between 5 and 25');
      return;
    }

    _numberOfBoxes = number;
    _boxes = List.generate(
      number,
      (index) => BoxModel(index: index),
    );
    _clickOrder = [];
    _isAnimating = false;
    _errorMessage = '';
    _stats = _stats.copyWith(
      totalClicks: 0,
      startTime: DateTime.now(),
    );

    _animationTimer?.cancel();
    HapticFeedback.mediumImpact();
    notifyListeners();
  }

  void onBoxTap(int index) {
    if (_isAnimating || _boxes[index].isGreen) return;

    _boxes[index] = _boxes[index].copyWith(
      isGreen: true,
      clickOrder: _clickOrder.length + 1,
    );
    _clickOrder.add(index);
    _stats = _stats.copyWith(totalClicks: _stats.totalClicks + 1);

    HapticFeedback.lightImpact();

    if (allBoxesGreen) {
      _startReverseAnimation();
    }

    notifyListeners();
  }

  void _startReverseAnimation() {
    _isAnimating = true;

    // Calculate completion time
    if (_stats.startTime != null) {
      final completionTime = DateTime.now().difference(_stats.startTime!);
      if (completionTime < _stats.bestTime) {
        _stats = _stats.copyWith(bestTime: completionTime);
      }
    }

    HapticFeedback.heavyImpact();

    int currentIndex = _clickOrder.length - 1;
    _animationTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (currentIndex >= 0) {
        final boxIndex = _clickOrder[currentIndex];
        _boxes[boxIndex] = _boxes[boxIndex].copyWith(
          isGreen: false,
          clickOrder: null,
        );
        HapticFeedback.selectionClick();
        currentIndex--;
        notifyListeners();
      } else {
        timer.cancel();
        _isAnimating = false;
        _clickOrder.clear();
        _stats = _stats.copyWith(completedRounds: _stats.completedRounds + 1);
        HapticFeedback.mediumImpact();
        notifyListeners();
      }
    });

    notifyListeners();
  }

  void reset() {
    _numberOfBoxes = 0;
    _boxes = [];
    _clickOrder = [];
    _isAnimating = false;
    _errorMessage = '';
    _stats = GameStats();
    _animationTimer?.cancel();
    HapticFeedback.mediumImpact();
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    HapticFeedback.lightImpact();
    notifyListeners();
  }

  String getLayoutPreview() {
    if (_numberOfBoxes == 0) return '';
    
    final layout = CShapeCalculator.calculateLayout(_numberOfBoxes);
    
    String preview = 'Layout Preview (N=$_numberOfBoxes):\n';
    preview += 'Top: ${layout.topBottomCount} boxes, Middle: ${layout.middleCount} boxes, Bottom: ${layout.topBottomCount} boxes\n\n';
    
    // Top row
    String topRow = '';
    for (int i = 0; i < layout.topBottomCount; i++) {
      topRow += '█ ';
    }
    preview += topRow + '\n';
    
    // Middle rows
    for (int i = 0; i < layout.middleCount; i++) {
      preview += '█\n';
    }
    
    // Bottom row
    String bottomRow = '';
    for (int i = 0; i < layout.topBottomCount; i++) {
      bottomRow += '█ ';
    }
    preview += bottomRow;
    
    return preview;
  }

  @override
  void dispose() {
    _animationTimer?.cancel();
    super.dispose();
  }
}
