import 'package:asha_fe/utils/PDFpage.dart';
import 'package:flutter/material.dart';

class ExpandableCard extends StatefulWidget {
  final String mainText;
  final String additionalInfo;
  final String pageName;

  ExpandableCard(
      {required this.mainText,
      required this.additionalInfo,
      required this.pageName});

  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.mainText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            if (isExpanded)
              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 8), // Adjust the margin values
                child: Text(
                  widget.additionalInfo,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
            if (isExpanded)
              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 8), // Adjust the margin values
                child: TextButton(
                  onPressed: () {
                    print("pageName: " + widget.pageName);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PDFpage(path: widget.pageName)));
                  },
                  child: Text(widget.pageName,
                      style: const TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      )),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
