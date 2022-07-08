import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stemcon/utils/color/color_pallets.dart';

class DashboardEffect extends StatelessWidget {
  const DashboardEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: baseColor,
      period: const Duration(milliseconds: 4500),
      highlightColor: highlightColor,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              height: _size.height * 0.1,
              width: double.infinity,
            ),
          );
        },
      ),
    );
  }
}

// pic Effect

class PictureEffect extends StatelessWidget {
  const PictureEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: baseColor,
      period: const Duration(milliseconds: 4500),
      highlightColor: highlightColor,
      child: Card(
        child: Container(
          margin: const EdgeInsets.all(8.0),
          height: _size.height * 0.1,
          width: double.infinity,
        ),
      ),
    );
  }
}
