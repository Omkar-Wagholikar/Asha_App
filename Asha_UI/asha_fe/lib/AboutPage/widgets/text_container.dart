import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  final String title;
  final String context_;
  const TextContainer({Key? key, required this.title, required this.context_})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "opensans light",
                ),
              ),
            ),
            const Divider(color: Colors.black), // Add a divider for separation
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                context_,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontFamily: "opensans light",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
