import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class V2IsMobileWidget extends StatelessWidget {
  const V2IsMobileWidget({Key? key, required this.isMobile}) : super(key: key);
  final Function(bool) isMobile;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Scaffold(
          body: SafeArea(child: isMobile(sizingInformation.isMobile)),
        );
      },
    );
  }
}
