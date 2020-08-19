

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TotalCard extends StatelessWidget {
  final String title;
  final int number;
  final Icon icon;

  const TotalCard({this.title, this.number, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          icon,
          SizedBox(
            width: 12,
          ),
          Text(title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            width: 12,
          ),
          Text("$number",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
