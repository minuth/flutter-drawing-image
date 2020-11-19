import 'package:drawing_image/model/image_state.dart';
import 'package:drawing_image/painter/image_switcher_painter.dart';
import 'package:drawing_image/utils/util.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ImageSwitcherWidget extends StatefulWidget {
  @override
  _ImageSwitcherWidgetState createState() => _ImageSwitcherWidgetState();
}

class _ImageSwitcherWidgetState extends State<ImageSwitcherWidget> {
  Offset _selectedsPosition;
  List<ImageState> listImages;
  bool isPresed;
  @override
  Widget build(BuildContext context) {
    if(listImages != null){
      return GestureDetector(
            onTapDown: (details) {
              setState(() {
                  _selectedsPosition = details.localPosition;
                  isPresed = true;
              });
            },
            onTapUp: (details) {
              setState(() {
                  _selectedsPosition = details.localPosition;
                  isPresed = false;
              });
            },
            child: CustomPaint(
            size: Size.infinite,
            painter: ImageSwitcherPainter(images: listImages,keyPressed: isPresed, selectedPosition: _selectedsPosition)),
          );
    }
    return Container(
      child: FutureBuilder<List<ImageState>>(
        initialData: null,
        future: _getListImage(),
        builder: (context, snapshot) {
          if(snapshot.data == null){
            return CircularProgressIndicator();
          }
          listImages = snapshot.data;
          return GestureDetector(
            onTapDown: (details) {
              setState(() {
                  _selectedsPosition = details.localPosition;
                  isPresed = true;
              });
            },
            onTapUp: (details) {
              setState(() {
                  _selectedsPosition = details.localPosition;
                  isPresed = false;
              });
            },
            child: CustomPaint(
            size: Size.infinite,
            painter: ImageSwitcherPainter(images: listImages,keyPressed: isPresed, selectedPosition: _selectedsPosition)),
          );
        },
        ),
      );
  }

  Future<List<ImageState>> _getListImage() async{
    ui.Image imageBlackUp = await Util.getUiImage("asset/black_up.png");
    ui.Image imageBlackDown = await Util.getUiImage("asset/black_down.png");
    ui.Image imageWhiteUp = await Util.getUiImage("asset/white_up.png");
    ui.Image imageWhiteDown = await Util.getUiImage("asset/white_down.png");
    List<ImageState> listResults = [];
    for (var i = 0; i < 10; i++) {
      ImageState imageState;
      if(i % 2 == 0){
        imageState = ImageState(imageWhiteDown, imageWhiteUp);
      }
      else{
        imageState = ImageState(imageBlackDown, imageBlackUp);
      }
      listResults.add(imageState);
    }
    return listResults;
  }
}