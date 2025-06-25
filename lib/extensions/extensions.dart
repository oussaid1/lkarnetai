import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
// Our design contains Neumorphism design and i made a extention for it
// We can apply it on any  widget

extension Neumorphism on Widget {
  addNeumorphism({
    double borderRadius = 10.0,
    Offset offset = const Offset(5, 5),
    double blurRadius = 10,
    Color topShadowColor = Colors.white60,
    Color bottomShadowColor = const Color(0x26234395),
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        boxShadow: [
          BoxShadow(
            offset: offset,
            blurRadius: blurRadius,
            color: bottomShadowColor,
          ),
          BoxShadow(
            offset: Offset(-offset.dx, -offset.dx),
            blurRadius: blurRadius,
            color: topShadowColor,
          ),
        ],
      ),
      child: this,
    );
  }
}

extension ContextExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  void gotoPage(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}

extension DtExtension on DateTime {
  String formatted() {
    try {
      return DateFormat("yyyy-MM-dd").format(this);
    } catch (e) {
      return '';
    }
  }

  String ddmmyyyy() {
    return '$day/$month/$year';
  }

  String formattedHH() {
    try {
      return DateFormat.yMd().add_jm().format(this);
    } catch (e) {
      return '';
    }
  }

  DateTime toDate() {
    return DateTime(year, month, day);
  }

  DateTime toMonth() {
    return DateTime(year, month, 1);
  }

  DateTime toYear() {
    return DateTime(year, 1, 1);
  }

  /// check if given date is today
  bool isMatchDay(DateTime date) {
    if (day == date.day && month == date.month && year == date.year) {
      return true;
    }
    return false;
  }

  bool isMatchWeek(DateTime date) {
    if (weekday == date.weekday && month == date.month && year == date.year) {
      return true;
    }
    return false;
  }

  bool isMatchMonth(DateTime date) {
    if (month == date.month && year == date.year) {
      return true;
    }
    return false;
  }

  bool isMatchYear(DateTime date) {
    if (year == date.year) {
      return true;
    }
    return false;
  }

  bool isAs(DateTime other) {
    return day == DateTime.now().day &&
        month == DateTime.now().month &&
        year == DateTime.now().year;
  }

  /// get number of days in the month from the date
  int get daysInMonth {
    return DateTime(
      year,
      month + 1,
      1,
    ).difference(DateTime(year, month, 1)).inDays;
  }
}

/// extension on [List<T>] to limit the list size to [limit]
extension ListExtension<T> on List<T> {
  List<T> limit(int limit) {
    if (this.length > limit) {
      return this.sublist(0, limit);
    }
    return this;
  }
}

/// extension on [List<String>] to turn all items to lower case
extension LowerCaseList on List<String> {
  List<String> toLowerCase() {
    for (int i = 0; i < length; i++) {
      this[i] = this[i].toLowerCase();
    }
    return this;
  }
}

extension Ex on double {
  double toPrecision(int digitsAfter) =>
      double.parse(toStringAsFixed(digitsAfter));
}

extension CountMatch on String {
  matches(String str2, {bool ignoreCase = true, bool ignoreSpaces = true}) {
    toLowerCase();
    str2.toLowerCase();
    var list = [];
    var count = 0;
    for (var item in split('')) {
      if (!item.isAlpha()) {
        if (str2.contains(item) && !list.contains(item)) {
          count++;
          list.add(item);
        }
      }
    }
    // print(count);
    // check if totalLetters is not zero to avoid division by zero
    if ((length + str2.length) > 0) {
      return ((count * 2) / (length + str2.length)) * 100;
    } else {
      return 0;
    }
  }
}

extension on String {
  bool isAlpha() {
    if (isEmpty) {
      return false;
    }
    return codeUnits.every(
      (codeUnit) =>
          (codeUnit >= 65 && codeUnit <= 90) ||
          (codeUnit >= 97 && codeUnit <= 122),
    );
  }
}

extension Group<T> on Iterable<T> {
  Iterable<T> wereItemsForShop(String Function(T) predicate, String shopId) {
    List<T> list = [];
    for (var item in this) {
      var key = predicate(item);
      if (key == shopId) {
        list.add(item);
      }
    }
    return list;
  }
}
