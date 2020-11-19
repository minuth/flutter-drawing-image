import 'package:drawing_image/model/image_state.dart';
import 'package:flutter/widgets.dart';

class ImageSwitcherPainter extends CustomPainter {
  final List<ImageState> images;
  final Offset selectedPosition;
  final bool keyPressed;
  ImageSwitcherPainter({@required this.images,@required this.keyPressed, this.selectedPosition});
  @override
  void paint(Canvas canvas, Size size) {
    size = Size(size.width * 0.1, size.height);
    int index = 0;
    for (ImageState imageState in images) {
      var image = imageState.imageReleased;
      var imageSize = Size(image.width.toDouble(), image.height.toDouble());
      FittedSizes fitSize = applyBoxFit(BoxFit.fitHeight, imageSize, size);
      Rect inputSubrect = Alignment.center.inscribe(fitSize.source, Offset.zero & imageSize);
      Rect outputSubrect = Alignment.center.inscribe(fitSize.destination, Offset(index * size.width, 0) & size);
      
      if(selectedPosition != null && outputSubrect.contains(selectedPosition)){
        image = keyPressed ? imageState.imagePressed : imageState.imageReleased;
      }
      canvas.drawImageRect(image, inputSubrect, outputSubrect, Paint());
      index ++;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
  
}