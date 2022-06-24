import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_probus/conn.dart';

class PetunjukPenggunaan extends StatelessWidget {
  const PetunjukPenggunaan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          onPressed: () {
            showBottomSheet(
              enableDrag: true,
              context: context,
              builder: (context) => Material(
                color: Colors.grey.shade600,
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          BackButton(),
                          Text(
                            "Petunjuk Penggunaan",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        controller: ScrollController(),
                        child: CachedNetworkImage(
                          imageUrl: Conn().host + "/images/petunjuk.png",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          child: Text(
            "Petunjuk Penggunaan",
            style: TextStyle(
              color: Colors.cyan,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      );
  }
}