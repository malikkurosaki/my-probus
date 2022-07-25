import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class V2IsMobileWidget extends StatelessWidget {
  const V2IsMobileWidget({Key? key, required this.isMobile}) : super(key: key);
  final Function(bool isMobile, bool isTablet, bool isDesktop) isMobile;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return SafeArea(child: isMobile(sizingInformation.isMobile, sizingInformation.isTablet, sizingInformation.isDesktop));
      },
    );
  }
}
