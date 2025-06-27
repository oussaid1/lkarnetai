import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkarnet/settings/theme.dart';

class AddCategory extends StatelessWidget {
  const AddCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        height: 340,
        width: 400,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8),
                      child: Text('category', overflow: TextOverflow.ellipsis),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 4, right: 4),
                      height: 45,
                      width: 240,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              style: BorderStyle.none,
                            ),
                          ),
                          hintText: 'shopping',
                          hintStyle: GoogleFonts.robotoSlab(),
                          contentPadding: EdgeInsets.only(top: 4),
                          prefixIcon: Icon(Icons.category),
                          filled: true,
                          fillColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8),
                      child: Text('item-price'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 50, height: 50),
                        Container(
                          margin: EdgeInsets.only(left: 4, right: 4),
                          height: 45,
                          width: 120,
                          child: TextField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: BorderSide(),
                              ),
                              hintText: '00.00',
                              hintStyle: GoogleFonts.robotoSlab(),
                              contentPadding: EdgeInsets.only(top: 4),

                              // prefixIcon: Icon(Icons.qr_code),
                              filled: true,
                            ),
                          ),
                        ),
                        SizedBox(width: 50, height: 50),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(padding: const EdgeInsets.all(4.0)),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: MThemeData.raisedButtonStyleCancel,
                      child: Text('Cancel'),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: MThemeData.raisedButtonStyleSave,
                      child: Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
