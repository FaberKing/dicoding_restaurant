import 'dart:developer';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dicoding_restaurant/utils/background_service.dart';
import 'package:dicoding_restaurant/utils/date_time_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulingNotifier extends StateNotifier<bool> {
  SchedulingNotifier() : super(false);

  Future<bool> scheduledNews(bool value) async {
    state = value;
    if (state) {
      log('Scheduling Restaurant Activated');

      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      log('Scheduling Restaurant Canceled');
      return await AndroidAlarmManager.cancel(1);
    }
  }
}

final schedulingProvider = StateNotifierProvider<SchedulingNotifier, bool>((_) {
  return SchedulingNotifier();
});
