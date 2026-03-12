import 'package:flutter/material.dart';
import 'package:tooltip_pro/src/tooltip_enums.dart';

Path buildTooltipPath({
  required Size size,
  required TooltipDirection tooltipDirection,
  required TooltipCaretDirection caretDirection,
  required double borderRadius,
  required double customCaretOffset,
  required double caretWidth,
  required double caretHeight,
}) {
  final path = Path();

  double radius = borderRadius;

  double bodyHeight = size.height;
  double bodyWidth = size.width;

  if (tooltipDirection == TooltipDirection.top ||
      tooltipDirection == TooltipDirection.bottom) {
    bodyHeight -= caretHeight;
  } else {
    bodyWidth -= caretHeight;
  }

  final maxRadius = (bodyHeight < bodyWidth ? bodyHeight : bodyWidth) / 2;

  if (radius > maxRadius) radius = maxRadius;
  if (radius < 0) radius = 0;

  if (tooltipDirection == TooltipDirection.top ||
      tooltipDirection == TooltipDirection.bottom) {
    if (radius > (bodyWidth - caretWidth) / 2) {
      radius = (bodyWidth - caretWidth) / 2;
    }
  } else {
    if (radius > (bodyHeight - caretWidth) / 2) {
      radius = (bodyHeight - caretWidth) / 2;
    }
  }

  if (radius < 0) radius = 0;

  double caretPos;
  final minCaretOffset = radius + caretWidth / 2;

  if (size.width < minCaretOffset * 2 &&
      (tooltipDirection == TooltipDirection.top ||
          tooltipDirection == TooltipDirection.bottom)) {
    caretPos = size.width / 2;
  } else if (size.height < minCaretOffset * 2 &&
      (tooltipDirection == TooltipDirection.left ||
          tooltipDirection == TooltipDirection.right)) {
    caretPos = size.height / 2;
  } else {
    if (tooltipDirection == TooltipDirection.left ||
        tooltipDirection == TooltipDirection.right) {
      final maxPos = size.height - minCaretOffset;
      switch (caretDirection) {
        case TooltipCaretDirection.left:
          caretPos = (size.height * 0.2).clamp(minCaretOffset, maxPos);
          break;
        case TooltipCaretDirection.right:
          caretPos = (size.height * 0.8).clamp(minCaretOffset, maxPos);
          break;
        case TooltipCaretDirection.center:
          caretPos = size.height * 0.5;
          break;
        case TooltipCaretDirection.custom:
          caretPos = (size.height * customCaretOffset).clamp(
            minCaretOffset,
            maxPos,
          );
          break;
        case TooltipCaretDirection.none:
          caretPos = 0;
          break;
      }
    } else {
      final maxPos = size.width - minCaretOffset;
      switch (caretDirection) {
        case TooltipCaretDirection.left:
          caretPos = (size.width * 0.2).clamp(minCaretOffset, maxPos);
          break;
        case TooltipCaretDirection.right:
          caretPos = (size.width * 0.8).clamp(minCaretOffset, maxPos);
          break;
        case TooltipCaretDirection.center:
          caretPos = size.width * 0.5;
          break;
        case TooltipCaretDirection.custom:
          caretPos = (size.width * customCaretOffset).clamp(
            minCaretOffset,
            maxPos,
          );
          break;
        case TooltipCaretDirection.none:
          caretPos = 0;
          break;
      }
    }
  }

  if (caretDirection == TooltipCaretDirection.none) {
    final bodyRect = Rect.fromLTWH(0, 0, size.width, size.height);
    path.addRRect(RRect.fromRectAndRadius(bodyRect, Radius.circular(radius)));
    return path;
  }

  switch (tooltipDirection) {
    case TooltipDirection.bottom:
      final bodyTop = caretHeight;
      final bodyBottom = size.height;

      path.moveTo(radius, bodyTop);

      path.lineTo(caretPos - caretWidth / 2, bodyTop);
      path.lineTo(caretPos, 0);
      path.lineTo(caretPos + caretWidth / 2, bodyTop);
      path.lineTo(size.width - radius, bodyTop);

      path.arcToPoint(
        Offset(size.width, bodyTop + radius),
        radius: Radius.circular(radius),
      );

      path.lineTo(size.width, bodyBottom - radius);

      path.arcToPoint(
        Offset(size.width - radius, bodyBottom),
        radius: Radius.circular(radius),
      );

      path.lineTo(radius, bodyBottom);

      path.arcToPoint(
        Offset(0, bodyBottom - radius),
        radius: Radius.circular(radius),
      );

      path.lineTo(0, bodyTop + radius);

      path.arcToPoint(
        Offset(radius, bodyTop),
        radius: Radius.circular(radius),
      );
      break;

    case TooltipDirection.top:
      final bodyBottom = size.height - caretHeight;

      path.moveTo(radius, 0);

      path.lineTo(size.width - radius, 0);

      path.arcToPoint(
        Offset(size.width, radius),
        radius: Radius.circular(radius),
      );

      path.lineTo(size.width, bodyBottom - radius);

      path.arcToPoint(
        Offset(size.width - radius, bodyBottom),
        radius: Radius.circular(radius),
      );

      path.lineTo(caretPos + caretWidth / 2, bodyBottom);
      path.lineTo(caretPos, size.height);
      path.lineTo(caretPos - caretWidth / 2, bodyBottom);
      path.lineTo(radius, bodyBottom);

      path.arcToPoint(
        Offset(0, bodyBottom - radius),
        radius: Radius.circular(radius),
      );

      path.lineTo(0, radius);

      path.arcToPoint(Offset(radius, 0), radius: Radius.circular(radius));
      break;

    case TooltipDirection.right:
      final bodyLeft = caretHeight;

      path.moveTo(bodyLeft + radius, 0);

      path.lineTo(size.width - radius, 0);

      path.arcToPoint(
        Offset(size.width, radius),
        radius: Radius.circular(radius),
      );

      path.lineTo(size.width, size.height - radius);

      path.arcToPoint(
        Offset(size.width - radius, size.height),
        radius: Radius.circular(radius),
      );

      path.lineTo(bodyLeft + radius, size.height);

      path.arcToPoint(
        Offset(bodyLeft, size.height - radius),
        radius: Radius.circular(radius),
      );

      path.lineTo(bodyLeft, caretPos + caretWidth / 2);
      path.lineTo(0, caretPos);
      path.lineTo(bodyLeft, caretPos - caretWidth / 2);
      path.lineTo(bodyLeft, radius);

      path.arcToPoint(
        Offset(bodyLeft + radius, 0),
        radius: Radius.circular(radius),
      );
      break;

    case TooltipDirection.left:
      final bodyRight = size.width - caretHeight;

      path.moveTo(radius, 0);

      path.lineTo(bodyRight - radius, 0);

      path.arcToPoint(
        Offset(bodyRight, radius),
        radius: Radius.circular(radius),
      );

      path.lineTo(bodyRight, caretPos - caretWidth / 2);
      path.lineTo(size.width, caretPos);
      path.lineTo(bodyRight, caretPos + caretWidth / 2);
      path.lineTo(bodyRight, size.height - radius);

      path.arcToPoint(
        Offset(bodyRight - radius, size.height),
        radius: Radius.circular(radius),
      );

      path.lineTo(radius, size.height);

      path.arcToPoint(
        Offset(0, size.height - radius),
        radius: Radius.circular(radius),
      );

      path.lineTo(0, radius);

      path.arcToPoint(Offset(radius, 0), radius: Radius.circular(radius));
      break;
  }

  path.close();
  return path;
}

class TooltipPainter extends CustomPainter {
  final Color color;
  final TooltipCaretDirection caretDirection;
  final TooltipDirection tooltipDirection;
  final bool enableShadow;
  final Color shadowColor;
  final double shadowElevation;
  final double shadowBlurRadius;
  final bool enableBorder;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double customCaretOffset;
  final double caretWidth;
  final double caretHeight;

  TooltipPainter({
    required this.color,
    required this.caretDirection,
    required this.tooltipDirection,
    this.enableShadow = false,
    this.shadowColor = const Color(0x4D000000),
    this.shadowElevation = 4.0,
    this.shadowBlurRadius = 4.0,
    this.enableBorder = false,
    this.borderColor = Colors.black,
    this.borderWidth = 1.0,
    this.borderRadius = 8.0,
    this.customCaretOffset = 0.5,
    this.caretWidth = 12.0,
    this.caretHeight = 10.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = _buildPath(size);

    if (enableShadow) {
      final shadowPaint = Paint()
        ..color = shadowColor
        ..style = PaintingStyle.fill
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowBlurRadius);

      canvas.save();
      canvas.translate(0, shadowElevation);
      canvas.drawPath(path, shadowPaint);
      canvas.restore();
    }

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);

    if (enableBorder) {
      final borderPaint = Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth;
      canvas.drawPath(path, borderPaint);
    }
  }

  Path _buildPath(Size size) => buildTooltipPath(
        size: size,
        tooltipDirection: tooltipDirection,
        caretDirection: caretDirection,
        borderRadius: borderRadius,
        customCaretOffset: customCaretOffset,
        caretWidth: caretWidth,
        caretHeight: caretHeight,
      );

  @override
  bool shouldRepaint(covariant TooltipPainter oldDelegate) =>
      color != oldDelegate.color ||
      caretDirection != oldDelegate.caretDirection ||
      tooltipDirection != oldDelegate.tooltipDirection ||
      enableShadow != oldDelegate.enableShadow ||
      shadowColor != oldDelegate.shadowColor ||
      shadowElevation != oldDelegate.shadowElevation ||
      shadowBlurRadius != oldDelegate.shadowBlurRadius ||
      enableBorder != oldDelegate.enableBorder ||
      borderColor != oldDelegate.borderColor ||
      borderWidth != oldDelegate.borderWidth ||
      borderRadius != oldDelegate.borderRadius ||
      customCaretOffset != oldDelegate.customCaretOffset ||
      caretWidth != oldDelegate.caretWidth ||
      caretHeight != oldDelegate.caretHeight;
}

class TooltipClipper extends CustomClipper<Path> {
  final TooltipCaretDirection caretDirection;
  final TooltipDirection tooltipDirection;
  final double borderRadius;
  final double customCaretOffset;
  final double caretWidth;
  final double caretHeight;

  TooltipClipper({
    required this.caretDirection,
    required this.tooltipDirection,
    required this.borderRadius,
    required this.customCaretOffset,
    required this.caretWidth,
    required this.caretHeight,
  });

  @override
  Path getClip(Size size) => buildTooltipPath(
        size: size,
        tooltipDirection: tooltipDirection,
        caretDirection: caretDirection,
        borderRadius: borderRadius,
        customCaretOffset: customCaretOffset,
        caretWidth: caretWidth,
        caretHeight: caretHeight,
      );

  @override
  bool shouldReclip(covariant TooltipClipper oldClipper) =>
      caretDirection != oldClipper.caretDirection ||
      tooltipDirection != oldClipper.tooltipDirection ||
      borderRadius != oldClipper.borderRadius ||
      customCaretOffset != oldClipper.customCaretOffset ||
      caretWidth != oldClipper.caretWidth ||
      caretHeight != oldClipper.caretHeight;
}
