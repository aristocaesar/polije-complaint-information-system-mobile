import 'package:flutter/material.dart';

class HeroComponent extends StatefulWidget {
  final String title;
  final GlobalKey<ScaffoldState> drawer;
  const HeroComponent({Key? key, required this.title, required this.drawer})
      : super(key: key);

  @override
  State<HeroComponent> createState() => _HeroComponentState();
}

class _HeroComponentState extends State<HeroComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              "POLIJE",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold),
            ),
            IconButton(
                icon: const Icon(Icons.menu, size: 35, color: Colors.white),
                onPressed: () => {widget.drawer.currentState?.openDrawer()})
          ]),
        ),
        const SizedBox(height: 30),
        Center(
          child: Text(
            widget.title,
            style: const TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}
