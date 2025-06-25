import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:excel/excel.dart';
import '../components.dart';
import 'shop/shops_data.dart';

/// a class to represent a backup of items in the database in a json format
/// this class is used to backup the database to a json file
class Backup {
  /// the date of the backup
  DateTime date = DateTime.now();

  /// the path to the backup
  String? path;

  /// the items in the backup
  List<ShopData> shopsDataList = [];

  /// the constructor for the backup class
  Backup({this.path, required this.date, required this.shopsDataList}) {
    this.path =
        '/storage/emulated/0/Android/data/com.dev.bourheem.Lkarnet/files';
  }

  /// the toJson method for the backup class
  /// this method is used to convert the backup to a json format
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date.toIso8601String();
    // data['items'] = this.items.map((x) => x.toJson()).toList();
    return data;
  }

  /// the fromJson method for the backup class
  /// this method is used to convert a json format to a backup
  // Backup.fromJson(Map<String, dynamic> json) {
  //   this.date = DateTime.parse(json['date']);
  //   this.items =
  //       json['items'].map<ItemModel>((x) => ItemModel.fromJson(x)).toList();
  // }

  /// a function to stroe the backup to a json file in the backup folder in the app directory with the name of the date of the backup and the extension .json
  Future<void> store() async {
    path = '$path/backup/oussaid.json';
    log('path: $path');
    final File file = File(path!);
    log('file: ${file}');
    await file.writeAsString(json.encode(this.toJson()));
    // File("$path/backup${DateFormat.yMMMd().format(this.date)}.xlsx")
    // file..createSync(recursive: true)
    // ..writeAsString(json.encode(this.toJson()));
  }

  /// a function to load the backup from a json file in the backup folder in the app directory with the name of the date of the backup and the extension .json
  /// this function is used to load the backup from a json file
  // static Future<Backup> load(String date) async {
  //   final String path =
  //       '${(await getApplicationDocumentsDirectory()).path}/backup/${date}.json';
  //   final File file = File(path);
  //   final String jsonString = await file.readAsString();
  //   final Map<String, dynamic> jsonMap = json.decode(jsonString);
  //  // return Backup.fromJson(jsonMap);
  // }

  /// store the list of items  in excel format in the backup folder in the app directory with the name of the date of the backup and the extension .xlsx
  /// this function is used to store the list of items in excel format
  // Future<void> storeExcel() async {
  //   final String path =
  //       '${(await getApplicationDocumentsDirectory()).path}/backup/${this.date.toIso8601String()}.xlsx';
  //   final File file = File(path);
  //   // await file.writeAsString(this.toExcel());
  // }

  /// toExcel method for the backup class
  /// this method is used to convert the backup to a excel format

  /////////////////////////////////////////
  void exportAsExcel() {
    var excel =
        Excel.createExcel(); // automatically creates 1 empty sheet: Sheet1
    excel.setDefaultSheet('');
    CellStyle cellStyle = CellStyle(
      // backgroundColorHex: "#EBA696",
      fontSize: 12,
      bold: true,
      // fontColorHex: "#EBA696",
      fontFamily: getFontFamily(FontFamily.Calibri),
    );
    ////////////////////////////////////////
    CellStyle cellStyleItemName = CellStyle(
      // backgroundColorHex: "#0097D3",
      fontFamily: getFontFamily(FontFamily.Calibri),
    );
    //////////////////
    ///////////////////////////////////////////
    CellStyle cellStyleDate = CellStyle(
      // backgroundColorHex: "#4A9470",
      fontFamily: getFontFamily(FontFamily.Calibri),
    );
    ///////////////////////////////////////////
    CellStyle cellStyleQuantity = CellStyle(
      //   backgroundColorHex: "#486F88",
      fontFamily: getFontFamily(FontFamily.Calibri),
    );
    ///////////////////////////////////////////
    CellStyle cellStylePrice = CellStyle(
      //  backgroundColorHex: "#D4856A",
      fontFamily: getFontFamily(FontFamily.Calibri),
    );
    ///////////////////////////////////////////
    CellStyle cellStyleTotalPrice = CellStyle(
      //  backgroundColorHex: "#D4A66A",
      fontFamily: getFontFamily(FontFamily.Calibri),
    );
    //////////////////
    //cellStyle.underline = Underline.Single;
    for (var shopData in shopsDataList) {
      Sheet sheetObject = excel['${shopData.shop.shopName}'];
      ////////////////////////////////////////
      var cell1 = sheetObject.cell(CellIndex.indexByString("A1"));
      cell1.value = 'ItemName' as CellValue;
      cell1.cellStyle = cellStyleItemName;
      /////////////////////////////////////////// ////////////////////////////////////////
      var cell2 = sheetObject.cell(CellIndex.indexByString("B1"));
      cell2.value = 'Date' as CellValue;
      cell2.cellStyle = cellStyleDate;
      /////////////////////////////////////////// ////////////////////////////////////////
      var cell3 = sheetObject.cell(CellIndex.indexByString("C1"));
      cell3.value = 'Quantity' as CellValue;
      cell3.cellStyle = cellStyleQuantity;
      /////////////////////////////////////////// ////////////////////////////////////////
      var cell4 = sheetObject.cell(CellIndex.indexByString("D1"));
      cell4.value = 'Price' as CellValue;
      cell4.cellStyle = cellStylePrice;
      ////////////////////////////////////////////////////////////
      var cell5 = sheetObject.cell(CellIndex.indexByString("E1"));
      cell5.value = 'TotalPrice' as CellValue;
      cell5.cellStyle = cellStyleTotalPrice;
      ////////////////////////////////////////
      var cellx1 = sheetObject.cell(CellIndex.indexByString("G1"));
      cellx1.value = 'Payment Date' as CellValue;
      cellx1.cellStyle = cellStyleTotalPrice;
      ///////////////////////////////////////////////
      var cellx2 = sheetObject.cell(CellIndex.indexByString("I1"));
      cellx2.value = 'Paid Amount' as CellValue;
      cellx2.cellStyle = cellStyleTotalPrice;
      ///////////////////////////////////////////
      // var cellx3 = sheetObject.cell(CellIndex.indexByString("G1"));
      // cellx3.value = 'TotalPrice';
      // cellx3.cellStyle = cellStyleTotalPrice;
      ///////////////////////////////////////////
      // or Underline.Double
      ////////////////////////////// Payments ///////////////////////////////
      for (int i = 0; i < shopData.payments.length; i++) {
        var cell1 = sheetObject.cell(CellIndex.indexByString("G${i + 2}"));
        cell1.value =
            shopData.payments[i].formattedDate
                as CellValue; // dynamic values support provided;
        ////////////////////////////////////////
        var cell2 = sheetObject.cell(CellIndex.indexByString("I${i + 2}"));
        cell2.value = shopData.payments[i].paidAmount as CellValue;
        ////////////////////////////////////////
      }
      /////////////////////////// Items /////////////////////////
      for (int i = 0; i < shopData.items.length; i++) {
        var cell1 = sheetObject.cell(CellIndex.indexByString("A${i + 2}"));
        cell1.value =
            shopData.items[i].itemName
                as CellValue; // dynamic values support provided;
        ////////////////////////////////////////
        var cell2 = sheetObject.cell(CellIndex.indexByString("B${i + 2}"));
        cell2.value = shopData.items[i].formattedDate as CellValue; //
        ////////////////////////////////////////
        var cell3 = sheetObject.cell(CellIndex.indexByString("C${i + 2}"));
        cell3.value = shopData.items[i].quantity as CellValue;
        //////////////////
        var cell4 = sheetObject.cell(CellIndex.indexByString("D${i + 2}"));
        cell4.value = shopData.items[i].itemPrice as CellValue;
        //////////////////
        var cell5 = sheetObject.cell(CellIndex.indexByString("E${i + 2}"));
        cell5.value = shopData.items[i].itemPrix as CellValue;
        cell5.cellStyle = cellStyle;

        // cell.cellStyle = cellStyle;
        // if (i > 10) break;
      }
      // var cell = sheetObject.cell(CellIndex.indexByString("A1"));

      // // printing cell-type
      // print("CellType: " + cell.cellType.toString());
    }
    excel.save();
    saveToFile(bytes: excel.encode() ?? []);
  }

  void saveToFile({required List<int> bytes}) {
    if (path != null) {
      File("$path/backup${DateFormat.yMMMd().format(this.date)}.xlsx")
        ..createSync(recursive: true)
        ..writeAsBytesSync(bytes);
    }
  }
}
