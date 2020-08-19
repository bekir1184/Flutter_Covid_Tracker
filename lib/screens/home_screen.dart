import 'dart:html';

import 'package:covid_tracker/services/countries_services.dart';
import 'package:covid_tracker/utilities/constants.dart';
import 'package:covid_tracker/widgets/daily_card.dart';
import 'package:covid_tracker/widgets/total_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> countries = getAllCountries();
  String current;

  @override
  void initState() {
    super.initState();
    current = "Türkiye";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.menu ), onPressed: null),
      ),
      body: FutureBuilder(
        future: fetchData(current),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(bottom :Radius.circular(30))),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Color(0xFFE5E5E5),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.location_on),
                        SizedBox(width: 20),
                        Expanded(
                          child: DropdownButton(
                            isExpanded: true,
                            underline: SizedBox(),
                            icon: Icon(Icons.arrow_drop_down),
                            value: snapshot.data.name,
                            items: countries.map((String country) {
                              return DropdownMenuItem<String>(
                                value: country,
                                child: Text(country),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                this.current = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bugunku Veriler",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Son Guncelleme ${DateTime.parse(snapshot.data.lastUpdate)}",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            DailyCard(
                              number: snapshot.data.today['confirmed'],
                              backgroundColor: Colors.orange,
                              icon: Icon(
                                Icons.group_add,
                                color: Colors.white,
                              ),
                              title: "Vaka Sayisi",
                            ),
                            DailyCard(
                              number: snapshot.data.today['deaths'],
                              backgroundColor: Colors.red,
                              icon: Icon(
                                Icons.airline_seat_flat,
                                color: Colors.white,
                              ),
                              title: "Vefat Sayisi",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "$current Toplam Verileri",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: double.infinity,
                        height: 200,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: color1,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TotalCard(
                              title: "Toplam Vaka Sayisi",
                              number: snapshot.data.total['confirmed'],
                              icon: Icon(
                                Icons.group_add,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            TotalCard(
                              title: "Toplam Vefat Sayisi",
                              number: snapshot.data.total['deaths'],
                              icon: Icon(Icons.airline_seat_flat,
                                  size: 30, color: Colors.white),
                            ),
                            TotalCard(
                              title: "Toplam Iyilesen Sayisi",
                              number: snapshot.data.total['recovered'],
                              icon: Icon(Icons.refresh,
                                  size: 30, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
