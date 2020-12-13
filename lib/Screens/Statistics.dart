import 'package:flutter/material.dart';
import 'package:countup/countup.dart';

class Statistics extends StatelessWidget {
  final cas, rec, det;
  Statistics(this.cas, this.rec, this.det);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    "TOTAL CASES",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    cas.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ))
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    "TOTAL RECOVERED",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    rec.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ))
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    "TOTAL DEATH",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    det.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ))
            ],
          ),
        ]));
  }
}
