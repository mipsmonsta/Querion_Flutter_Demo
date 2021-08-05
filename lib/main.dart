import 'package:flutter/material.dart';
import 'package:querion/widgets/arrowIcons.dart';
import 'widgets/pager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Querion Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(child: QuerionPage()),
    );
  }
}

class QuerionPage extends StatefulWidget {
  QuerionPage({Key? key}) : super(key: key);

  @override
  _QuerionPageState createState() => _QuerionPageState();
}

class _QuerionPageState extends State<QuerionPage> {
  int _pageIndex = 0;
  late Pager _currentPager;
  final List<GlobalKey<PagerState>> _PagerKeyList =
      List.generate(3, (_) => GlobalKey<PagerState>()).toList();

  void nextPage() async {
    int next = 0;
    if (_pageIndex < 3 - 1) {
      next = _pageIndex + 1;
    } else {
      next = 0;
    }

    setState(() {
      _pageIndex = next;
    });
  }

  void prevPage() async {
    int next = 0;
    if (_pageIndex > 0) {
      next = _pageIndex - 1;
    } else {
      next = 3 - 1;
    }

    setState(() {
      _pageIndex = next;
    });
  }

  Widget line(size) {
    return Positioned(
      left: size.width / 8.0,
      top: size.height * 0.1,
      height: size.height * 0.9,
      width: 1.0,
      child: Container(color: Colors.white),
    );
  }

  Widget historyIcon(size) {
    return Positioned(
        top: size.height * 0.1,
        left: size.width / 8.0,
        child: FractionalTranslation(
            translation: Offset(-0.5, -0.9),
            child: Icon(Icons.history, color: Colors.white, size: 48.0)));
  }

  void onPressedUp() async {
    activateHideOnCurrentPager();
    await Future.delayed(Duration(milliseconds: 1000));
    prevPage();
  }

  void onPressedDown() async {
    activateHideOnCurrentPager();
    await Future.delayed(Duration(milliseconds: 1000));
    nextPage();
  }

  void onPressedBack() {
    print("Back");
  }

  void activateHideOnCurrentPager() async {
    var key = _PagerKeyList[_pageIndex];
    key.currentState?.hideItems();
  }

  Pager getPager() {
    _currentPager = [
      Pager(
          key: _PagerKeyList[0],
          question: 'The answer to life is?',
          answer: '42'),
      Pager(
          key: _PagerKeyList[1],
          question: 'The value of Pi',
          answer: 'The answer is 3.141'),
      Pager(
          key: _PagerKeyList[2],
          question: 'How far is the moon from earth?',
          answer:
              'The moon is 384,400 km from the centre of the Earth. And the sun is even further.'),
    ][_pageIndex];

    return _currentPager;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.amber, Colors.deepOrange])),
      child: Stack(children: [
        ArrowIcons(
            onPressedBack: onPressedBack,
            onPressedUp: onPressedUp,
            onPressedDown: onPressedDown,
            parentSize: size),
        line(size),
        historyIcon(size),
        getPager(),
      ], fit: StackFit.expand),
    ));
  }
}
