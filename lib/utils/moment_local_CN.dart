// Copyright (c) 2016, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'package:simple_moment/simple_moment.dart';

class LocaleCN implements ILocaleData {
  String get seconds => '几分钟';

  String get aMinute => '1分钟';
  String get minutes => '%i 分钟';

  String get anHour => '1小时';
  String get hours => '%i 小时';

  String get aDay => '1天';
  String get days => '%i 天';

  String get aMonth => '1月';
  String get months => '%i 月';

  String get aYear => '1年';
  String get years => '%i 年';

  String get futureIdentifier => '内';
  String get pastIdentifier => '前';

  String get localeString => 'cn';

  IdentifierPosition get futurePosition => IdentifierPosition.prepend;
  IdentifierPosition get pastPosition => IdentifierPosition.append;
}
