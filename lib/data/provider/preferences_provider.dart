import 'dart:async';

import 'package:dicoding_restaurant/data/provider/shared_preference_provider.dart';
import 'package:dicoding_restaurant/preferences/preferences_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncDailyReminderNotifier extends AsyncNotifier<bool> {
  Future<bool> _getDailyReminder() async {
    PreferencesHelper preferencesHelper = PreferencesHelper(
        sharedPreferences: ref.read(sharedPreferencesProvider));

    final restaurant = await preferencesHelper.isDailyReminderActive();

    return restaurant;
  }

  @override
  FutureOr<bool> build() async {
    return _getDailyReminder();
  }

  Future<void> setDailyReminder(bool value) async {
    PreferencesHelper preferencesHelper = PreferencesHelper(
        sharedPreferences: ref.read(sharedPreferencesProvider));
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await preferencesHelper.setDailyReminder(value);
      return _getDailyReminder();
    });
  }
}

final asyncDailyReminderProvider =
    AsyncNotifierProvider<AsyncDailyReminderNotifier, bool>(() {
  return AsyncDailyReminderNotifier();
});
