import 'package:flutter/material.dart';

class ArrowIcons extends StatelessWidget {
  final Function onPressedUp;
  final Function onPressedDown;
  final Function onPressedBack;
  final Size parentSize;
  const ArrowIcons(
      {Key? key,
      required this.onPressedBack,
      required this.onPressedUp,
      required this.onPressedDown,
      required this.parentSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: parentSize.height * 0.3,
        left: 0.0,
        child: SizedBox(
          height: parentSize.height * 0.3,
          width: parentSize.width / 8.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () => onPressedUp(),
                  color: Colors.white,
                  icon: Icon(Icons.arrow_upward)),
              Spacer(),
              IconButton(
                  onPressed: () => onPressedDown(),
                  color: Colors.white,
                  icon: Icon(Icons.arrow_downward)),
              Spacer(),
              IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () => onPressedBack(),
              )
            ],
          ),
        ));
  }
}
