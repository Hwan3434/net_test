import 'package:flutter/material.dart';

typedef OrientationViewBuilder = Widget Function(BuildContext context);

class OrientationScreen extends StatelessWidget {
  final OrientationViewBuilder portraitBuilder;
  final OrientationViewBuilder? landScapeBuilder;

  const OrientationScreen({
    super.key,
    required this.portraitBuilder,
    this.landScapeBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (landScapeBuilder == null) {
          return portraitBuilder.call(context);
        }
        switch (orientation) {
          case Orientation.portrait:
            return portraitBuilder.call(context);
          case Orientation.landscape:
            return landScapeBuilder!.call(context);
        }
      },
    );
  }
}
