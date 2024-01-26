import 'package:asha_fe/Components/glass_morphic_container.dart';
import 'package:asha_fe/Constants/theme.dart';
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
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.white)),
        child: GlassmorphicContainer(
          borderRadius: 10,
          sigmaX: 4,
          sigmaY: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "opensans light",
                    color: AppColors.fontLight,
                  ),
                ),
              ),
              const Divider(
                  color: Colors.white), // Add a divider for separation
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  context_,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: "opensans light",
                      color: AppColors.fontLight),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
