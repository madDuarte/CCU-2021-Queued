import 'dart:math' as math;

import 'package:Staff/dto/StoreDto.dart';
import 'package:Staff/services/ServerCommunicationService.dart';
import 'package:flutter/material.dart';

import '../Widget/navBarWidget.dart';
import '../Card/StoresCard.dart';

class AllStaffStoresScreen extends StatefulWidget {
  @override
  _AllStaffStoresScreenState createState() => _AllStaffStoresScreenState();
}

class _AllStaffStoresScreenState extends State<AllStaffStoresScreen> {
  Future<List<StoreDto>> futureStores;
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Color(0x50000000)),
    gapPadding: 10,
  );

  @override
  void initState() {
    futureStores = ServerCommunicationService.getAllStoresFromStaffEmail('staff@gmail.com'); // todo insert user id
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF8FBFF),
        body: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: screenSize().height / 15),
            Align(
              alignment: Alignment.center,
              child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize().width / 25),
                    child: mainRow(),
                  )),
            ),
            SizedBox(height: screenSize().height / 30),
            Container(
              width: 380,
              child: buildSearchField(),
              color: Colors.white,
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1),
                  child: FutureBuilder<List<StoreDto>>(
                      future: this.futureStores,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(
                                child: SizedBox(
                                    height: 70.0,
                                    width: 70.0,
                                    child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                            Color(0xff22bec8)),
                                        strokeWidth: 5.0)));
                          default:
                            if (snapshot.hasError)
                              return new Text('Error: ${snapshot.error}');
                            else
                              return _buildGridView(context, snapshot.data);
                        }
                      })),
            ),
            Nav(0),
          ],
        ));
  }

  Widget _buildGridView(BuildContext context, List<StoreDto> stores) {
    return GridView.builder(
        itemCount: stores.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: screenSize().width / 20,
          crossAxisSpacing: screenSize().width / 25,
          childAspectRatio: 5,
        ),
        itemBuilder: (context, index) => StoresCard(
              store: stores[index],
              // press: () => Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => DetailsScreen(
              //         category: categories[index],
              //       ),
              //     )),
            ));
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }

  TextFormField buildSearchField() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: "What are you looking for?",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 27),
              child: Icon(Icons.search, color: Color(0xff27192B0), size: 32.0),
            )));
  }

  Row mainRow() {
    return Row(
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text("Hello Staff!",
                  style: TextStyle(color: Color(0xFFB2B2B2), fontSize: 20)),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Select a store:",
                  style: TextStyle(color: Color(0xFF143656), fontSize: 20)),
            ),
        ],),
        Spacer(),
        Icon(Icons.notifications_none_outlined,
            color: Color(0xff13497B), size: 32.0),
        Icon(Icons.settings_outlined, color: Color(0xff13497B), size: 32.0),
      ],
    );
  }
}
