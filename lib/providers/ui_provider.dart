import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class UIProvider extends ChangeNotifier {
  bool _showStats = false;
  bool _isDarkMode = false;

  // Getters
  bool get showStats => _showStats;
  bool get isDarkMode => _isDarkMode;

  void toggleStats() {
    _showStats = !_showStats;
    HapticFeedback.lightImpact();
    notifyListeners();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    HapticFeedback.lightImpact();
    notifyListeners();
  }

  void setShowStats(bool value) {
    if (_showStats != value) {
      _showStats = value;
      notifyListeners();
    }
  }

  void setDarkMode(bool value) {
    if (_isDarkMode != value) {
      _isDarkMode = value;
      notifyListeners();
    }
  }
}
