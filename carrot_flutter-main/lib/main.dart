import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'src/app.dart';

void main() async {
  // GetStorage 초기화
  await GetStorage.init();

  // TimeAgo 언어 추가
  TimeUtil.init();

  // 인증 동작
  final box = GetStorage();
  String? token = box.read('access_token');
  bool isLogin = (token != null) ? true : false;

  runApp(MyApp(isLogin));
}

class TimeUtil {
  TimeUtil.init() {
    timeago.setLocaleMessages('ko', KoMessages());
  }
  static String parse(DateTime? time) {
    return (time == null) ? '' : timeago.format(time, locale: 'ko');
  }
}

class KoMessages implements timeago.LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '전';
  @override
  String suffixFromNow() => '후';
  @override
  String lessThanOneMinute(int seconds) => '방금';
  @override
  String aboutAMinute(int minutes) => '방금';
  @override
  String minutes(int minutes) => '$minutes분';
  @override
  String aboutAnHour(int minutes) => '1시간';
  @override
  String hours(int hours) => '$hours시간';
  @override
  String aDay(int hours) => '1일';
  @override
  String days(int days) => '$days일';
  @override
  String aboutAMonth(int days) => '한달';
  @override
  String months(int months) => '$months개월';
  @override
  String aboutAYear(int year) => '1년';
  @override
  String years(int years) => '$years년';
  @override
  String wordSeparator() => ' ';
}
