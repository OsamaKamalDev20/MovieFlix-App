import 'package:intl/intl.dart';

class MovieHelper {
  MovieHelper._();

  // 1: Average rating + stars
  static double averageRating(List<dynamic> ratings) {
    if (ratings.isEmpty) return 0;

    final total = ratings.fold<int>(
      0,
      (sum, rating) => sum + (rating as num).toInt(),
    );

    return total / ratings.length;
  }

  // Rating display: 6.03 / 10
  static String formatRating(List<dynamic> ratings) {
    return averageRating(ratings).toStringAsFixed(1);
  }

  // 2. Duration: PT100M -> 1h 40m
  static String formatDuration(String duration) {
    final regex = RegExp(r'^PT(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?$');

    final match = regex.firstMatch(duration.trim());
    if (match == null) return duration.isEmpty ? '-' : duration;

    final h = int.tryParse(match.group(1) ?? '0') ?? 0;
    final m = int.tryParse(match.group(2) ?? '0') ?? 0;

    // Sab kuch minutes mein badlo, phir dobara hours/minutes banao
    final totalMinutes = (h * 60) + m;
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;

    if (totalMinutes == 0) return '-';
    if (hours == 0) return '${minutes}min';
    if (minutes == 0) return '${hours}h';

    return '${hours}h ${minutes}min';
  }

  // 3. Release date: 2018-02-28 -> Feb 28, 2018
  static String formatReleaseDate(String date) {
    final parsed = DateTime.tryParse(date);
    if (parsed == null) return date;
    return DateFormat('MMM dd, yyyy').format(parsed);
  }

  // 4: "Rachel McAdams" -> "RM", "Madonna" -> "M"
  static String getInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }
}
