import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DailyCard extends StatelessWidget {
  final int number;
  final Color backgroundColor;
  final String title;
  final Icon icon;

  

  const DailyCard(
      {this.number, this.backgroundColor, this.title, this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 2.4,
        height: 50,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                icon,
                Text(title,style: TextStyle(fontSize: 17 ,color: Colors.white,fontWeight: FontWeight.bold),)
              ],
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                '$number',
                style: TextStyle(color: Colors.white,fontSize: 50,fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }
}
