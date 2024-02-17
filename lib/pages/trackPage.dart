import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:math';

const events = {
  "19th - 25th February, 2024": [
    {
      "organizer": "USS ACM",
      "event_name": "Galactica 2.0",
      "timing": "5:00 PM - 9:00 PM",
      "venue": "Online"
    }
  ],
  "18th February, 2024": [
    {
      "organizer": "GGSIPU",
      "event_name": "Silver Jubilee Grand Alumni Meet",
      "timing": "10:00 AM Onwards",
      "venue": "Main Auditorium"
    }
  ],
  "14th February, 2024": [
    {
      "organizer": "AICTE IDEA LAB",
      "event_name": "Call for Project and Prototype\n Development",
      "timing": "10:00 AM Onwards",
      "venue": "C Block Seminar Hall"
    }
  ],
  "8th - 10th February, 2024": [
    {
      "organizer": "GGSIPU",
      "event_name": "Anugoonj Cultural Festival 2024",
      "timing": "9:00 AM - 9:00 PM",
      "venue": "GGSIPU Dwarka",
    }
  ],
  "28th January, 2024": [
    {
      "organizer": "USS ACM",
      "event_name": "ACM Endgame",
      "timing": "10:00 AM - 1:00 PM",
      "venue": "Online"
    }
  ]
  // ,
  // "22nd January, 2024": [
  //   {
  //     "organizer": "Srijan Science Club",
  //     "event_name": "Vikshit Bharat Mascot\n Designing Competition",
  //     "timing": "null",
  //     "venue": "null",
  //   }
  // ]
};

var keys = events.keys;

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Text(
                "Track Events",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 25),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (String key in keys) IntrinsicTimedEvent(key)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

MaterialAccentColor getColor() {
  List<MaterialAccentColor> eventCardColorList = const [
    Colors.redAccent,
    Colors.blueAccent,
    Colors.purpleAccent,
    Colors.deepOrangeAccent,
    Colors.orangeAccent,
  ];
  int randomIndex = Random().nextInt(eventCardColorList.length);
  return eventCardColorList[randomIndex];
}

class IntrinsicTimedEvent extends StatelessWidget {
  final String eventKey;

  const IntrinsicTimedEvent(
    String this.eventKey, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var eventCardColorIndex = 0;
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              SizedBox(height: 5),
              Container(
                height: 15,
                width: 15,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.green),
              ),
              Expanded(
                child: Container(
                  constraints: BoxConstraints(minHeight: 50),
                  width: 3,
                  decoration: BoxDecoration(color: Colors.green),
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // event key is date
                eventKey,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
              SizedBox(height: 10),
              if (events[eventKey] != null)
                for (Map<String, String> event in events[eventKey]!)
                  EventCard(event, getColor()),
            ],
          ),
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Map<String, String> event;
  final MaterialAccentColor color;
  const EventCard(
    Map<String, String> this.event,
    MaterialAccentColor this.color, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Material(
            borderRadius: BorderRadius.circular(20),
            color: color,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event["organizer"]!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      event["event_name"]!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Timing - " + event["timing"]!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Venue - " + event["venue"]!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
