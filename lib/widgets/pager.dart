import 'package:flutter/material.dart';
import 'itemFader.dart';
import 'questionAnswer.dart';
import 'questionAnswer.dart';

class Pager extends StatefulWidget {
  final String question;
  final String answer;

  const Pager({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  PagerState createState() => PagerState();
}

class PagerState extends State<Pager> with SingleTickerProviderStateMixin {
  late List<GlobalKey<ItemFaderState>> keys;
  bool _isShowDot = true;
  GlobalKey<AnswerState> answerKey = GlobalKey<AnswerState>();
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    keys = List.generate(2, (_) => GlobalKey<ItemFaderState>());
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    onInit();
  }

  void onInit() async {
    for (GlobalKey<ItemFaderState> key in keys) {
      await Future.delayed(Duration(milliseconds: 100));
      key.currentState?.show();
    }
  }

  void hideItems() async {
    Offset startOffSet = _getCoordinateOfAnswerWidget();
    setState(() {
      _isShowDot = false;
    });
    for (GlobalKey<ItemFaderState> key in keys) {
      await Future.delayed(Duration(milliseconds: 100));
      key.currentState?.hide();
    }
    //show overlay dot
    await animateDot(startOffSet);
  }

  Future<void> animateDot(Offset startOffset) async {
    OverlayEntry entry = OverlayEntry(
      builder: (context) {
        Size size = MediaQuery.of(context).size;
        double minTop = size.height * 0.1;
        return AnimatedBuilder(
          animation: _animationController,
          child: ADot(),
          builder: (context, child) {
            return Positioned(
                left: size.width / 8.0,
                top: minTop +
                    (startOffset.dy - minTop) *
                        (1 - _animationController.value),
                child: child!);
          },
        );
      },
    );
    Overlay.of(context)?.insert(entry);
    await _animationController.forward(from: 0);
    entry.remove();
  }

  Offset _getCoordinateOfAnswerWidget() {
    RenderBox box = answerKey.currentContext?.findRenderObject() as RenderBox;

    return box.localToGlobal(Offset.zero);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: size.height * 0.1),
        ItemFader(
            key: keys[0],
            child: Question(
              question: widget.question,
              parentWidth: size.width,
            )),
        SizedBox(height: size.height * 0.5),
        ItemFader(
          key: keys[1],
          child: Answer(
            key: answerKey,
            answer: widget.answer,
            parentWidth: size.width,
            isShowADot: _isShowDot,
          ),
        )
      ],
    );
  }
}
