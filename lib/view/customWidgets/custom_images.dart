import 'package:tarek_agro/extensions/view_extensions.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomNetworkImage extends StatelessWidget {
  String url;
  Widget? errorImage;
  double errorIconSize;
  double? width, height;
  BoxFit? fit = BoxFit.contain;
  CustomNetworkImage(this.url, {Key? key, this.errorImage, this.errorIconSize = 48, this.width, this.height,this.fit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (BuildContext? context, Object? exception, StackTrace? stackTrace) {
        return errorImage != null
            ? errorImage!
            : Center(
                child: Icon(
                Icons.error,
                color: Colors.red,
                size: errorIconSize,
              ));
      },
      loadingBuilder: (BuildContext? context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class CircleColorIcon extends StatelessWidget {
  String hexColor;
  double width, height;

  CircleColorIcon({Key? key, required this.hexColor, this.width = 16.0, this.height = 16.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: HexColor.fromHex(hexColor),
        shape: BoxShape.circle,
      ),
    );
  }
}
