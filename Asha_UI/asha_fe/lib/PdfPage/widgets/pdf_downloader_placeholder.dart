import 'package:asha_fe/Components/glass_morphic_container.dart';
import 'package:asha_fe/Constants/theme.dart';
import 'package:flutter/material.dart';

class ShowDownloadingPdf extends StatelessWidget {
  const ShowDownloadingPdf({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/images/asha_bg.jpeg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/downloading.gif"),
            const SizedBox(
              height: 10,
            ),
            GlassmorphicContainer(
                borderRadius: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Downloading File",
                    style: TextStyle(
                        color: AppColors.fontLight,
                        fontWeight: FontWeight.bold,
                        fontSize: 23),
                  ),
                )),
          ],
        ),
      ],
    );
  }
}
