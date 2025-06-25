import 'dart:developer';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lkarnet/blocs/payments/payments_bloc.dart';
import 'package:lkarnet/blocs/shopsbloc/shops_bloc.dart';
import 'package:lkarnet/models/user/user.dart';
import 'package:flutter/material.dart';
import 'package:lkarnet/widgets/dialogs.dart';
import 'package:lkarnet/widgets/myappbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../blocs/itemsbloc/items_bloc.dart';
import '../../blocs/loginbloc/login_bloc.dart';
import '../../components.dart';
import '../../cubits/userCubit/usermodel_cubit.dart';
import '../../models/backup.dart';
import '../../models/data_sink.dart';
import '../../models/item/item.dart';
import '../../models/shop/shop_model.dart';
import '../../models/shop/shops_data.dart';
import '../../utils.dart';
import '../../widgets/notifications_switch.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<ItemModel> _items = [];
  String? path;
  void exportAsExcel() {
    var excel =
        Excel.createExcel(); // automatically creates 1 empty sheet: Sheet1

    CellStyle cellStyle = CellStyle(
      // backgroundColorHex: "#1AFF1A",
      fontFamily: getFontFamily(FontFamily.Calibri),
    );
    Sheet sheetObject = excel['SheetName'];
    cellStyle.underline = Underline.Single; // or Underline.Double
    for (int i = 0; i < _items.length; i++) {
      var cell1 = sheetObject.cell(CellIndex.indexByString("A${i + 1}"));
      cell1.value =
          _items[i].itemName as CellValue?; // dynamic values support provided;
      ////////////////////////////////////////
      var cell2 = sheetObject.cell(CellIndex.indexByString("B${i + 1}"));
      cell2.value = _items[i].quantity as CellValue?;
      //////////////////
      var cell3 = sheetObject.cell(CellIndex.indexByString("C${i + 1}"));
      cell3.value = _items[i].itemPrice as CellValue?;
      ;
      // cell.cellStyle = cellStyle;
      // if (i > 10) break;
    }
    // var cell = sheetObject.cell(CellIndex.indexByString("A1"));

    // // printing cell-type
    // print("CellType: " + cell.cellType.toString());
    excel.save();
    saveToFile(bytes: excel.encode() ?? []);
  }

  void saveToFile({required List<int> bytes}) {
    if (path != null) {
      File("$path/backup${DateFormat.yMMMd().format(DateTime.now())}.xlsx")
        ..createSync(recursive: true)
        ..writeAsBytesSync(bytes);
    }
  }
  // Future<List<Directory>?> getExternalStorageDirectories({
  //   /// Optional parameter. See [StorageDirectory] for more informations on
  //   /// how this type translates to Android storage directories.
  //   StorageDirectory? type,
  // }) async {
  //   final List<String>? paths = await Platform
  //     ..getExternalStoragePaths(type: type);
  //   if (paths == null) {
  //     return null;
  //   }

  //   return paths.map((String path) => Directory(path)).toList();
  // }

  //late RecentOperation _recentOperation;
  @override
  Widget build(BuildContext context) {
    //  var appThemeState = ref.watch(appThemeStateNotifier);
    //context.read<UserModelCubit>().loadUser();
    return BluredContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: MyAppBar(
            title: Text(
              'Settings',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        body: BlocBuilder<UserModelCubit, UserModel?>(
          builder: (context, state) {
            if (state != null) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Account Settings'),
                              // Row(
                              //   children: [
                              //     Switch(
                              //       activeColor:
                              //           Theme.of(context).colorScheme.secondary,
                              //       value: appThemeState.darkMode,
                              //       onChanged: (enabled) {
                              //         if (enabled) {
                              //           appThemeState.toggleChangeTheme();
                              //         } else {
                              //           appThemeState.toggleChangeTheme();
                              //         }
                              //       },
                              //     ),
                              //     Icon(
                              //       CupertinoIcons.moon_fill,
                              //     ),
                              //   ],
                              // )
                            ],
                          ),
                        ),
                        Text(
                          'Update your settings like profile edit, change password etc.',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                    SizedBox(height: 60),
                    ListTile(
                      leading: Container(
                        width: 45,
                        height: 45,
                        child: Icon(Icons.account_circle_outlined, size: 35),
                      ),
                      title: Text(
                        '${state.email}',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Container(
                        width: 45,
                        height: 45,
                        child: Icon(Icons.lock),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Change Password',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          Text(
                            'change your password',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20),
                      onTap: () {},
                    ),
                    BlocBuilder<ItemsBloc, ItemsState>(
                      builder: (context, itemsState) {
                        return BlocBuilder<ShopsBloc, ShopsState>(
                          builder: (context, shopsState) {
                            return BlocBuilder<PaymentsBloc, PaymentsState>(
                              builder: (context, paymentsState) {
                                if (itemsState.items.isNotEmpty) {
                                  List<ShopModel> _shops = shopsState.shops;
                                  //////////////////////////////////////////////////////
                                  var dataSink = DataSink(
                                    items: itemsState.items,
                                    payments: paymentsState.payments,
                                    shops: _shops,
                                  );
                                  //////////////////////////////////////////////////////
                                  List<ShopData> allShopsData =
                                      dataSink.allShopsData;
                                  ///////////////////////////////////////////////////////
                                  // ShopDataCalculations _shopDataCalculations =
                                  //     ShopDataCalculations(
                                  //   items: itemsState.items,
                                  //   payments: paymentsState.payments,
                                  // );
                                  ///////////////////////////////////////////////////////
                                  ///////////////////////////////////////////////////////
                                  return ListTile(
                                    leading: Container(
                                      width: 45,
                                      height: 45,
                                      child: Icon(Icons.backup_outlined),
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Back up your Database',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.displaySmall,
                                        ),
                                        Text(
                                          'export your database as excel',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleSmall,
                                        ),
                                      ],
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 20,
                                    ),
                                    onTap: () async {
                                      /// show a confirmation dialogue to backup
                                      Dialogs.confirmDialogue(
                                        context,
                                        title: 'Back Up',
                                        message:
                                            'Are you sure you want to export your database ?',
                                      ).then((value) async {
                                        var status = await Permission.storage
                                            .request()
                                            .isGranted;
                                        if (!status) {
                                          Dialogs.snackBar(
                                            'Please grant storage permission',
                                          );
                                        }
                                        //Directory docsDirectory = await getExternalStorageDirectories();
                                        Directory? dir =
                                            await getDownloadsDirectory();
                                        setState(() {
                                          path = dir!.path;
                                        });
                                        log(path ?? '');

                                        if (path != null) {
                                          // exportAsExcel();
                                          Dialogs.snackBar(path ?? '');
                                          final backup = Backup(
                                            path: path,
                                            date: DateTime.now(),
                                            shopsDataList: allShopsData,
                                          );
                                          backup.exportAsExcel();
                                          //backup.store; // .then((value) =>
                                          GlobalFunctions.showSnackBar(
                                            context,
                                            'backup created',
                                          );
                                        }
                                      });
                                    },
                                  );
                                }
                                return CircularPercentIndicator(radius: 20);
                              },
                            );
                          },
                        );

                        //return CircularPercentIndicator(radius: 50);
                      },
                    ),
                    ListTile(
                      leading: Container(
                        width: 45,
                        height: 45,
                        child: Icon(Icons.share_outlined),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Share to Friends',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          Text(
                            'change your account information ',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Container(
                        width: 45,
                        height: 45,
                        child: Icon(Icons.notifications),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Activate Notification',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          Text(
                            'Turn on/off notification',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      trailing: NotificationsSwitch(),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Container(
                        width: 45,
                        height: 45,
                        child: Icon(CupertinoIcons.power),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Logout',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          Text(
                            'logout and try different login',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20),
                      onTap: () {
                        Dialogs.confirmDialogue(
                          context,
                          title: 'Logout',
                          message: 'Are you sure you want to logout?',
                        ).then((value) {
                          if (value) {
                            BlocProvider.of<LoginBloc>(
                              context,
                            ).add(LogOutRequestedEvent());
                          }
                        });
                      },
                    ),
                  ],
                ),
              );
            }
            return CircularPercentIndicator(radius: 50);
          },
        ),
      ),
    );
  }
}
