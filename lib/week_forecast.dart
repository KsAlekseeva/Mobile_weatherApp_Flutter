import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/weather.dart';
import 'main.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'weather_type.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({Key key, @required this.callback, @required this.settings,  @required this.daily})
      : super(key: key);
  final List<Weather> daily;
  final Function callback;
  final Map settings;

  @override
  State<ForecastPage> createState() => _ForecastPage();
}

class _ForecastPage extends State<ForecastPage> {
  int selected1 = 0;
  int selected2 = 0;
  int selected3 = 0;

  @override
  void initState() {
    selected1 = widget.settings['temp'] ? 0 : 1;
    selected2 = widget.settings['wind'] ? 0 : 1;
    selected3 = widget.settings['pressure'] ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {
    log(widget.daily.toString());
    return Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 34),
                    child: Column(
                      children: [
                        Text(
                          'Прогноз на неделю',
                          style: GoogleFonts.manrope(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      height: 390,
                      width: 330,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(colors: [
                          Color(0xFFCDDAF5),
                          Color(0xFF9CBCFF),
                        ]),
                      ),
                      child: Swiper(
                          itemHeight: 387,
                          itemWidth: 320,
                          itemCount: 7,
                          layout: SwiperLayout.STACK,
                          loop: false,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(colors: [
                                  Color(0xFFCDDAF5),
                                  Color(0xFF9CBCFF),
                                ]),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        DateFormat.MMMMd('ru').format(DateTime.fromMillisecondsSinceEpoch(widget.daily[index].dt * 1000)),
                                        style: GoogleFonts.manrope(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.only(left: 10),
                                      leading: SizedBox(
                                        height: 66,
                                        width: 66,
                                        child: Image.asset(getIcon(widget.daily[index].weatherType), height: 20, width: 20),
                                      ),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.thermostat_outlined),
                                      title: Row(
                                        children: [
                                          Text(
                                            '${widget.settings['temp'] ? widget.daily[index].temp : (widget.daily[index].temp*1.8+32).round()}',
                                            style: GoogleFonts.manrope(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            widget.settings['temp']
                                                ? '°c'
                                                : '°F',
                                            style: GoogleFonts.manrope(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.water_outlined),
                                      title: Row(
                                        children: [
                                          Text(
                                            '${widget.settings['wind'] ? widget.daily[index].wind : (widget.daily[index].wind/3.6).round()}',
                                            style: GoogleFonts.manrope(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            widget.settings['wind']
                                                ? 'м/c'
                                                : 'км/ч',
                                            style: GoogleFonts.manrope(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.invert_colors),
                                      title: Row(
                                        children: [
                                          Text(
                                            '${widget.daily[index].humidity.round()}',
                                            style: GoogleFonts.manrope(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            "%",
                                            style: GoogleFonts.manrope(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.explore),
                                      title: Row(
                                        children: [
                                          Text(
                                            '${widget.settings['pressure'] ? (widget.daily[index].pressure/1.3).round() : (widget.daily[index].pressure).round()}',
                                            style: GoogleFonts.manrope(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            widget.settings['pressure']
                                                ? 'мм.рт.ст.'
                                                : 'гПа',
                                            style: GoogleFonts.manrope(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        side: BorderSide(color: Color(0xFF000000), width: 1),
                      ),
                      child: Text(
                        "Вернуться на главную",
                        style: GoogleFonts.manrope(
                            fontSize: 14,
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }
}
