import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../extensions/extensions.dart';

import 'glasswidget.dart';

class SelectDate extends StatefulWidget {
  const SelectDate({Key? key, required this.onDateSelected, this.initialDate})
    : super(key: key);
  final void Function(DateTime) onDateSelected;
  final DateTime? initialDate;
  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  DateTime _selectedDate = DateTime.now();

  void _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: widget.initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ))!;
    if (picked != DateTime.now()) {
      _selectedDate = picked;
      widget.onDateSelected(picked);
    }
  }

  @override
  void initState() {
    //  widget.onDateSelected(_selectedDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: BluredContainer(
        height: 50,
        width: 200,
        child: Row(
          children: [
            Container(
              height: 45,
              width: 45,
              child: IconButton(
                onPressed: () {
                  _selectDate(context);
                },
                icon: Icon(CupertinoIcons.calendar),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Text(
                _selectedDate.ddmmyyyy(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectDate2 extends StatefulWidget {
  const SelectDate2({Key? key, required this.onDateSelected, this.initialDate})
    : super(key: key);
  final ValueSetter<DateTime> onDateSelected;
  final DateTime? initialDate;
  @override
  State<SelectDate2> createState() => _SelectDate2State();
}

class _SelectDate2State extends State<SelectDate2> {
  DateTime _selectedDate = DateTime.now();

  // void _selectDate(BuildContext context) async {
  //   final DateTime picked = (await showDatePicker(
  //     context: context,
  //     initialDate: widget.initialDate ?? DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2025),
  //   ))!;
  //   if (picked != DateTime.now()) {
  //     setState(() {
  //       _selectedDate = picked;
  //       widget.onDateSelected(_selectedDate);
  //     });
  //   }
  // }

  @override
  void initState() {
    // widget.onDateSelected(_selectedDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final DateTime picked = (await showDatePicker(
          context: context,
          initialDate: widget.initialDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2025),
        ))!;
        if (picked != DateTime.now()) {
          setState(() {
            _selectedDate = picked;
          });
          widget.onDateSelected(_selectedDate);
        }
      },
      // _selectDate(context),
      child: BluredContainer(
        height: 50,
        width: 300,
        child: Row(
          children: [
            Container(
              height: 45,
              width: 45,
              child: IconButton(
                onPressed: null,
                icon: Icon(CupertinoIcons.calendar),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Text(
                _selectedDate.ddmmyyyy(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
