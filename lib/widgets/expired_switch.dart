import 'package:flutter/material.dart';

import 'date_picker.dart';

class ExpiredSwitch extends StatefulWidget {
  const ExpiredSwitch({Key? key, required this.onChanged}) : super(key: key);
  final void Function(Map<String, dynamic>) onChanged;
  @override
  State<ExpiredSwitch> createState() => _ExpiredSwitchState();
}

class _ExpiredSwitchState extends State<ExpiredSwitch> {
  bool _isExpired = false;
  DateTime _expiryDate = DateTime.now();
  // bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Expired ?'),
            Switch(
              onChanged: (value) {
                if (value) {
                  setState(() {
                    _isExpired = true;
                  });
                  widget.onChanged(
                      {'isExpired': _isExpired, 'expiryDate': _expiryDate});
                } else {
                  setState(() {
                    _isExpired = false;
                  });
                  widget
                      .onChanged({'isExpired': _isExpired, 'expiryDate': null});
                }

                //_isExpired = !value;
              },
              value: _isExpired,
            ),
          ],
        ),
        _isExpired
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Date'),
                  SelectDate2(
                    initialDate: DateTime.now(),
                    onDateSelected: (date) {
                      if (_isExpired) {
                        setState(() {
                          _expiryDate = date;
                        });
                        widget.onChanged({
                          'isExpired': _isExpired,
                          'expiryDate': _expiryDate
                        });
                      } else {
                        setState(() {
                          _isExpired = false;
                        });
                        widget.onChanged(
                            {'isExpired': _isExpired, 'expiryDate': null});
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$date' + '\n' + '$_isExpired'),
                        ),
                      );
                      //  _isLoading = false;
                    },
                  )
                ],
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
