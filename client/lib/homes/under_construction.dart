import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UnderConstruction extends StatelessWidget {
  const UnderConstruction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          color: Colors.grey.shade100,
          width: double.infinity,
          child: Center(
            child: Text('Under Construction',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
            ),
          ),
        ),
      ),
    );
  }
}
