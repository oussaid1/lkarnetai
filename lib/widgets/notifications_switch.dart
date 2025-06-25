import 'package:flutter/material.dart';
import 'package:lkarnet/settings/theme/theme_provider.dart';

import '../components.dart';

class NotificationsSwitch extends ConsumerWidget {
  const NotificationsSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    var _notify = ref.watch(notificationStateNotifier);
    return Switch(
      value: _notify.shouldNotify,
      onChanged: (value) {
        _notify.toggleChangeTheme();
        if (value) {
          _showNotifications(context);
        } else {
          _cancelNotification(context);
        }
      },
    );
  }

  void _showNotifications(BuildContext context) async {
    // AwesomeNotifications().createdStream.listen((notification) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     backgroundColor: Colors.green,
    //     content: Text(
    //       'Notification Created on ${notification.channelKey}',
    //     ),
    //   ));
    // });

    // AwesomeNotifications().actionStream.listen((notification) {
    //   Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(
    //       builder: (_) => HomePage(),
    //     ),
    //     (route) => route.isFirst,
    //   );
    // });
  }

  void _cancelNotification(BuildContext context) async {
    AwesomeNotifications().cancelAll();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text('Notifications disabled'),
      duration: Duration(seconds: 1),
    ));
  }
}
















// import 'package:flutter/material.dart';

// import '../models/kitchen/kitchen_item.dart';
// import '../providers/operationsprovider/operations_provider.dart';
// import 'date_picker.dart';

// class KitchenItmExpiredButton extends StatefulWidget {
//   const KitchenItmExpiredButton(
//       {Key? key, required this.kitchenItem, required this.op})
//       : super(key: key);
//   final KitchenItem kitchenItem;
//   final Operations op;
//   @override
//   State<KitchenItmExpiredButton> createState() =>
//       _KitchenItmExpiredButtonState();
// }

// class _KitchenItmExpiredButtonState extends State<KitchenItmExpiredButton> {
//   DateTime _expiryDate = DateTime.now();

//   bool _isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text('Expired Date'),
//             content: SelectDate2(
//               initialDate: DateTime.now(),
//               onDateSelected: (date) {
//                 setState(() {
//                   _expiryDate = date;
//                 });
//               },
//             ),
//             actions: [
//               ElevatedButton(
//                 child: Text(
//                   'Cancel',
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ElevatedButton(
//                 child: Text('Ok'),
//                 onPressed: _isLoading
//                     ? null
//                     : () {
//                         setState(() {
//                           _isLoading = true;
//                         });
//                         widget.op.updateKitchenItem(widget.kitchenItem.copyWith(
//                             dateExpired: _expiryDate,
//                             kitchenElementId:
//                                 widget.kitchenItem.kitchenElementId));
//                         Navigator.of(context).pop();
//                       },
//               ),
//             ],
//           ),
//         );
//       },
//       child: Text('Expired Date'),
//     );
//   }
// }
