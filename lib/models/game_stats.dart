class GameStats {
  final int totalClicks;
  final int completedRounds;
  final Duration bestTime;
  final DateTime? startTime;

  GameStats({
    this.totalClicks = 0,
    this.completedRounds = 0,
    this.bestTime = const Duration(hours: 1),
    this.startTime,
  });

  GameStats copyWith({
    int? totalClicks,
    int? completedRounds,
    Duration? bestTime,
    DateTime? startTime,
  }) {
    return GameStats(
      totalClicks: totalClicks ?? this.totalClicks,
      completedRounds: completedRounds ?? this.completedRounds,
      bestTime: bestTime ?? this.bestTime,
      startTime: startTime ?? this.startTime,
    );
  }

  String get formattedBestTime {
    if (bestTime.inHours > 0) return '--:--';
    return '${bestTime.inMinutes}:${(bestTime.inSeconds % 60).toString().padLeft(2, '0')}';
  }
}
