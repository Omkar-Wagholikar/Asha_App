import 'package:asha_fe/AboutPage/data/about_data.dart';
import 'package:asha_fe/AboutPage/widgets/text_container.dart';
import 'package:asha_fe/Components/appbar.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AshaAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextContainer(
                title: AboutData.aimTitle, context_: AboutData.aimContext),
            TextContainer(
                title: AboutData.sourceTitle,
                context_: AboutData.sourceContext),
            TextContainer(
                title: AboutData.ackTitle, context_: AboutData.ackContext),
            TextContainer(
                title: AboutData.partnerTitle,
                context_: AboutData.partnerContext),
          ],
        ),
      ),
    );
  }
}
