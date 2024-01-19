import 'package:asha_fe/Constants/theme.dart';
import 'package:flutter/material.dart';

import 'PdfPage/pages/pdf_page.dart';

class AnimExpandableCard extends StatefulWidget {
  final String mainText;
  final String additionalInfo;
  final String pageName;

  const AnimExpandableCard(
      {super.key,
      required this.mainText,
      required this.additionalInfo,
      required this.pageName});
  @override
  State<AnimExpandableCard> createState() => _AnimExpandableCardState();
}

class _AnimExpandableCardState extends State<AnimExpandableCard> {
  bool _customTileExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            color: Theme.of(context).primaryColorLight.withOpacity(0.7),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
                width: 1, color: Theme.of(context).primaryColorLight)),
        child: ExpansionTile(
          onExpansionChanged: (bool expanded) => setState(() {
            _customTileExpanded = expanded;
          }),
          title: Text(
            widget.mainText,
            style: TextStyle(
                fontWeight:
                    _customTileExpanded ? FontWeight.bold : FontWeight.normal),
          ),
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  color: AppColors.iconsLightTheme.withOpacity(0.7),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: Column(
                  children: [
                    Text(
                      widget.additionalInfo,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PdfPage(fileName: widget.pageName)));
                      },
                      child: Text(widget.pageName,
                          style: const TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          )),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
