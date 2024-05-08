import 'dart:async';

import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget
{
  final bool initTimerNow;

  TimerWidget({super.key, required this.initTimerNow,});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget>
{
  Duration duration = Duration();
  Timer? timer;

  startTimerNow()
  {
    timer = Timer.periodic(Duration(seconds: 1), (timer)
    {
      setState(() {
        duration = Duration(seconds: duration.inSeconds + 1);
      });
    });
  }

  stopTimerNow()
  {
    setState(() {
      timer?.cancel();
      timer = null;
      duration = Duration();
    });
  }

  @override
  Widget build(BuildContext context)
  {
    if(timer == null || !widget.initTimerNow)
      {
        widget.initTimerNow ? startTimerNow() : stopTimerNow();
      }

    String twoDigit(int number) => number.toString().padLeft(2, "0");
    final minutes = twoDigit(duration.inMinutes.remainder(60));
    final seconds = twoDigit(duration.inSeconds.remainder(60));
    final hours = twoDigit(duration.inHours.remainder(60));

    return Text(
      "$hours: $minutes: $seconds",
      style: TextStyle(
        fontSize: 23,
      ),
    );
  }
}

