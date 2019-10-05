///FifthAIPlayer
import 'package:flutter/material.dart';
import 'dart:async';

import 'video_layer.dart';


enum GameStatus { loading, play, complete }
enum Directions { none, left, right, top, bottom }

class MainPainter extends CustomPainter {
  final VideoLayer vLayer;
  MainPainter({this.vLayer});
  @override
  void paint(Canvas canvas, Size size) {
    vLayer.paint(canvas, size);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class FifthAIPlayer extends StatefulWidget {
  _FifthAIPlayer createState() => _FifthAIPlayer();
}

class _FifthAIPlayer extends State<FifthAIPlayer> with TickerProviderStateMixin  {

  GameStatus gameStatus = GameStatus.loading;
  Animation<double> animation;
  AnimationController controller;
  int index = 0;
  VideoLayer vLayer;

  GlobalKey _keyRed = GlobalKey();
  _getSizes() {
    final RenderBox renderBoxRed = _keyRed.currentContext.findRenderObject();
    final sizeRed = renderBoxRed.size;
    print("SIZE of Red: $sizeRed");
  }
  _getPositions() {
    final RenderBox renderBoxRed = _keyRed.currentContext.findRenderObject();
    final positionRed = renderBoxRed.localToGlobal(Offset.zero);
    print("POSITION of Red: $positionRed ");
  }

  _afterLayout(_) {
    _getSizes();
    _getPositions();
  }

  initState() {
//    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 16), vsync: this);

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    );
    animation.addListener(() {
      setState(() {});
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.repeat();
      }
    });
    vLayer = VideoLayer();
    vLayer.init().then((val) {
      setState(() {
        gameStatus = GameStatus.play;
      });
      showStartAnimation();
    });

  }
  void showStartAnimation() {
    controller.forward();
  }




  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    if (gameStatus == GameStatus.loading) {
      return Center(
        child: Text('Loading', style: TextStyle(decoration: TextDecoration.none)),
      );
    }
    return GestureDetector(
        child: CustomPaint(
          key: _keyRed,
            painter: MainPainter(vLayer: vLayer)
        ),
        onPanStart: (DragDownDetails) {
          print("onPanStart $DragDownDetails");
//          hero.moveTo(DragDownDetails.globalPosition.dx, DragDownDetails.globalPosition.dy);

        },
        onPanUpdate: (DragDownDetails) {
          print("onPanUpdate $DragDownDetails");
//          hero.moveTo(DragDownDetails.globalPosition.dx, DragDownDetails.globalPosition.dy);
        }
    );
//    return CustomPaint(
//      painter: MainPainter(background: background, hero: hero),
//    );
  }
}
