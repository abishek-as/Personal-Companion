import 'package:flutter/material.dart';
import 'package:personal_companion/ExpensePage.dart';
import 'package:personal_companion/page/notes_page.dart';
import 'package:personal_companion/radial_progress.dart';
import 'package:personal_companion/topbar.dart';
import 'package:intl/intl.dart';

DateTime selectedDate = DateTime.now();

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Personal Companion",
      theme: ThemeData(
        primaryColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: const MyHomePage(),
    ));

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  // ignore: unused_field
  late AnimationController _iconAnimationController;

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _iconAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                const TopBar(),
                Positioned(
                  top: 65.0,
                  left: 0.0,
                  right: 0.0,
                  child: Column(
                    children: <Widget>[
                      Text(
                        DateFormat("EEEE").format(selectedDate),
                        style: const TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 40.0,
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontFamily: 'GoogleBold'),
                      ),
                      Text(
                        DateFormat("MMM d y").format(selectedDate),
                        style: const TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontFamily: 'GoogleRegular'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const RadialProgress(),
            const SizedBox(
              height: 80,
            ),
            SizedBox(
                height: 49,
                width: 250,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.amber[200], onPrimary: Colors.black),
                  label:
                      const Text('Take Notes', style: TextStyle(fontSize: 17)),
                  icon: const Icon(Icons.notes_rounded),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotesPage()));
                  },
                )),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
                height: 49,
                width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.amber[200], onPrimary: Colors.black),
                  child: const Text('\u{20B9} Add Expenses',
                      style: TextStyle(fontSize: 17)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ExpensePage()));
                  },
                )),
          ],
        ),
      ],
    ));
  }
}
