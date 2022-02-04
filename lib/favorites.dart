import 'dart:convert';
import 'dart:developer';
import 'search.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesPage extends StatefulWidget {
  Function callback;

  FavoritesPage(this.callback);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<City> list = [];


  @override
  void initState() {
    getAllPrefs();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
            color: Color(0xFFE2EBFF),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          saveFavourites(list);
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios_outlined),
                        iconSize: 20,
                        color: Colors.black),
                    SizedBox(
                      width: 18,
                    ),
                    Text('Избранные',
                        style: GoogleFonts.manrope(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                       Container(
                        width: MediaQuery.of(context).size.width,
                        height: 400,
                        child: Column(
                          children: [
                            Expanded(
                                child: ListView.builder(
                                  itemCount: list.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('${list[index].name} ${list[index].country}'),
                                          IconButton(
                                            icon: Icon(Icons.delete_forever),
                                            onPressed: () {
                                              setState(() {
                                                list.removeAt(index);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        widget.callback(
                                            list[index].lat,
                                            list[index].lon,
                                            list[index].name);
                                        saveFavourites(list);
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                            )),
                          ],
                        ),
                      )
                    // return Container(
                    //   child: Center(
                    //     child: Column(
                    //       children: [
                    //         Row(
                    //           children: [
                    //             Text('Weather',
                    //                 style: GoogleFonts.manrope(
                    //                     fontSize: 35,
                    //                     color: Colors.black,
                    //                     fontWeight: FontWeight.w600)),
                    //           ],
                    //         ),
                    //         Row(
                    //           children: [
                    //             CircularProgressIndicator(
                    //               color: Colors.black,
                    //
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // );

              ],
            ),
          ),
        ),
      );
  String encode(List<City> f) =>
      json.encode(
          f.map<Map<String, dynamic>>((f) => toMap(f)).toList()
      );

  void saveFavourites(List<City> favourites) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String fav = encode(favourites);
      prefs.setString('Favourites', fav);
    });
    log(prefs.getString('Favourites'));
  }

  getAllPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    log(jsonDecode(prefs.getString('Favourites')).toString(),
        name: 'getAllPrefs');
    Future.delayed(Duration.zero, () {
      setState(() {
        list = jsonDecode(prefs.getString('Favourites')).map<City>((key) {
          return City(
            name: key['name'],
            country: key['country'],
            lat: key['lat'],
            lon: key['lon'],
          );
        }).toList();
      });
    });
  }
}

