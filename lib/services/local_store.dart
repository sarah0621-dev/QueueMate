import 'package:hive/hive.dart';

class LocalStore {
  static final _box = Hive.box('queueMate');

  // ---------- Favorites ----------
  static List<String> getFavorites() {
    return (_box.get('favorites', defaultValue: <String>[]) as List)
        .cast<String>();
  }

  static Future<void> toggleFavorite(String venueId) async {
    final favs = getFavorites();
    if (favs.contains(venueId)) {
      favs.remove(venueId);
    } else {
      favs.add(venueId);
    }
    await _box.put('favorites', favs);
  }

  static bool isFavorite(String venueId) {
    return getFavorites().contains(venueId);
  }

  // ---------- Active Queue ----------
  static Map<String, dynamic>? getActiveQueue() {
    final data = _box.get('activeQueue');
    if (data == null) return null;
    return Map<String, dynamic>.from(data as Map);
  }

  static Future<void> saveActiveQueue(Map<String, dynamic> queue) async {
    await _box.put('activeQueue', queue);
  }

  static Future<void> clearActiveQueue() async {
    await _box.delete('activeQueue');
  }

  static bool hasActiveQueue() {
    return _box.containsKey('activeQueue');
  }

  // ---------- Recent Venues ----------
  static List<String> getRecentVenues() {
    return (_box.get('recentVenues', defaultValue: <String>[]) as List)
        .cast<String>();
  }

  static Future<void> addRecentVenue(String venueId) async {
    final recents = getRecentVenues();

    // Remove if already exists (to move to front)
    recents.remove(venueId);

    // Add to front
    recents.insert(0, venueId);

    // Keep only last 10
    if (recents.length > 10) {
      recents.removeRange(10, recents.length);
    }

    await _box.put('recentVenues', recents);
  }

  static Future<void> clearRecentVenues() async {
    await _box.delete('recentVenues');
  }

  // ---------- User Info ----------
  static String? getUserName() {
    return _box.get('userName');
  }

  static Future<void> saveUserName(String name) async {
    await _box.put('userName', name);
  }

  static String? getUserEmail() {
    return _box.get('userEmail');
  }

  static Future<void> saveUserEmail(String email) async {
    await _box.put('userEmail', email);
  }

  // ---------- Onboarding ----------
  static bool hasSeenOnboarding() {
    return _box.get('hasSeenOnboarding', defaultValue: false) as bool;
  }

  static Future<void> setOnboardingComplete() async {
    await _box.put('hasSeenOnboarding', true);
  }

  // ---------- Clear All Data ----------
  static Future<void> clearAllData() async {
    await _box.clear();
  }
}
