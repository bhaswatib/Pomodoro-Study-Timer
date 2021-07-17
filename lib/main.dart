import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Pomodoro(),
));

class Pomodoro extends StatefulWidget {
  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  double percent=0;
  double percentP=0;
  static int TimeInMinut=25;
  static int TimeInMinutP=5;
  int TimeInSec=TimeInMinut*60;
  int TimeInSecP=TimeInMinutP*60;

  Timer timer1;
  Timer timerP;

  _StartTimer(){
    TimeInMinut=25;
    int Time=TimeInMinut*60;
    double SecPercent=(Time/100);
    timer1=Timer.periodic(Duration(seconds:1), (timer) {
      setState(() {
        if(Time>0)
        {
          Time--;
          if(Time%60==0)
          {
            TimeInMinut--;
          }
          if(Time%SecPercent==0)
          {
            if(percent<1)
            {
              percent+=0.01;
              if(percent>1)
              {
                percent=1;
              }
            }
          }
        }
        else
        {
           percent=0;
           TimeInMinut=25;
           timer1.cancel();
        }
      });
    });
  }

  _StartTimer2() {
    TimeInMinutP=5;
    int TimeP=TimeInMinutP*60;
    double SecPercentP=(TimeP/100);
    timerP=Timer.periodic(Duration(seconds:1), (timer) {
      setState(() {
        if(TimeP>0)
        {
          TimeP--;
          if(TimeP%60==0)
          {
            TimeInMinutP--;
          }
          if(TimeP%SecPercentP==0)
          {
            if(percentP<1)
            {
              percentP+=0.01;
              if(percentP>1)
              {
                percentP=1;
              }
            }
          }
        }
        else
        {
          percentP=0;
          TimeInMinutP=5;
          timerP.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff00838f),Color(0xff0097A7)],
              begin: FractionalOffset(0.5,1)
            )
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:25.0),
                child: Text(
                  "Pomodoro Clock",
                  style: TextStyle (
                    color: Colors.white,
                    fontSize: 52.0,
                    fontWeight: FontWeight.bold
                   ),
                  ),
                ),
              Expanded(
                child: CircularPercentIndicator(
                  circularStrokeCap: CircularStrokeCap.round,
                  percent: percent,
                  animation: true,
                  animateFromLastPercent: true,
                  radius: 200.0,
                  lineWidth: 20.0,
                  progressColor: Colors.white,
                  center: Text(
                    "$TimeInMinut",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60.0
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.0, bottom: 30.0, right: 30.0),
                child: LinearPercentIndicator(
                  percent: percentP,
                  animation: true,
                  animateFromLastPercent: true,
                  lineHeight: 20.0,
                  progressColor: Colors.white,
                  center: Text(
                    "$TimeInMinutP",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                    ),
                  )
                 )
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30.0),topLeft: Radius.circular(30.0))
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                    child: Column(
                      children: <Widget> [
                        Expanded(
                          child: Row(
                            children: <Widget> [
                              Expanded(
                                child: Column(
                                  children: <Widget> [
                                    Text(
                                      "Study",
                                      style: TextStyle(
                                        fontSize: 25.0,
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      "25 mins",
                                      style: TextStyle(
                                        fontSize: 33.0
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget> [
                                    Text(
                                      "Take a Break",
                                      style: TextStyle(
                                        fontSize: 25.0,
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      "5 mins",
                                      style: TextStyle(
                                          fontSize: 33.0
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 14.0),
                          child: RaisedButton(
                            onPressed: _StartTimer,
                            color: Colors.cyan.shade800,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                "Start Studying",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: RaisedButton(
                            onPressed: _StartTimer2,
                            color: Colors.cyan.shade800,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                "Break Time",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
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