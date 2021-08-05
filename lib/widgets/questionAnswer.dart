import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String question;
  final double parentWidth;

  const Question({Key? key, required this.question, required this.parentWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(width: parentWidth / 8.0),
      Expanded(
        child: Padding(
            padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 24.0),
            child: Text(question,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ))),
      ),
    ]);
  }
}

class ADot extends StatelessWidget {
  final bool isVisible;

  const ADot({Key? key, this.isVisible = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: Offset(-0.5, 0),
      child: Container(
        width: 13,
        height: 13,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: isVisible ? Colors.white : Colors.transparent),
      ),
    );
  }
}

class Answer extends StatefulWidget {
  // final void Function(Offset dotOffset) onTap;
  final String answer;
  bool isShowADot;
  final double parentWidth;

  Answer(
      {Key? key,
      required this.answer,
      required this.parentWidth,
      this.isShowADot = true})
      : super(key: key);

  @override
  AnswerState createState() => AnswerState();
}

class AnswerState extends State<Answer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          RenderBox box = context.findRenderObject() as RenderBox;
          Offset globalPos =
              box.localToGlobal(Offset.zero); //find global of top right corner
        },
        child: Row(
          children: [
            SizedBox(width: widget.parentWidth / 8.0),
            ADot(isVisible: widget.isShowADot),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 24.0),
                    child: Text(widget.answer,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))))
          ],
        ));
  }
}
