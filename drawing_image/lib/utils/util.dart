  
import 'dart:ui' as ui;
import 'package:image/image.dart' as image;
import 'package:flutter/services.dart';

class Util {
  static Future<ui.Image> getUiImageWithSize(
      String imageAssetPath, int height, int width) async {
    final ByteData assetImageByteData = await rootBundle.load(imageAssetPath);
    image.Image baseSizeImage =
        image.decodeImage(assetImageByteData.buffer.asUint8List());
    image.Image resizeImage =
        image.copyResize(baseSizeImage, height: height, width: width);
    ui.Codec codec =
        await ui.instantiateImageCodec(image.encodePng(resizeImage));
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

  static Future<ui.Image> getUiImage(String imageAssetPath) async {
    final ByteData assetImageByteData = await rootBundle.load(imageAssetPath);
    image.Image finalImage = image.decodeImage(assetImageByteData.buffer.asUint8List());
    ui.Codec codec =
        await ui.instantiateImageCodec(image.encodePng(finalImage));
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }
}