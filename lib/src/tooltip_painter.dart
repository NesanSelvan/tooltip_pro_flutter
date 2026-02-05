import 'package:flutter/material.dart';
import 'package:tooltip_pro/src/tooltip_enums.dart';

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

  Path _buildPath(Size size) {
    final path = Path();
    // Use instance variables instead of constants
    // caretHeight and caretWidth are already part of the class

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

    // Build a single continuous path with caret integrated
    switch (tooltipDirection) {
      case TooltipDirection.bottom:
        // Caret points up, body below
        final bodyTop = caretHeight;
        final bodyBottom = size.height;

        // Start from top-left corner of body (after radius)
        path.moveTo(radius, bodyTop);

        // Top edge with caret
        path.lineTo(caretPos - caretWidth / 2, bodyTop);
        path.lineTo(caretPos, 0); // Caret tip
        path.lineTo(caretPos + caretWidth / 2, bodyTop);
        path.lineTo(size.width - radius, bodyTop);

        // Top-right corner
        path.arcToPoint(
          Offset(size.width, bodyTop + radius),
          radius: Radius.circular(radius),
        );

        // Right edge
        path.lineTo(size.width, bodyBottom - radius);

        // Bottom-right corner
        path.arcToPoint(
          Offset(size.width - radius, bodyBottom),
          radius: Radius.circular(radius),
        );

        // Bottom edge
        path.lineTo(radius, bodyBottom);

        // Bottom-left corner
        path.arcToPoint(
          Offset(0, bodyBottom - radius),
          radius: Radius.circular(radius),
        );

        // Left edge
        path.lineTo(0, bodyTop + radius);

        // Top-left corner
        path.arcToPoint(
          Offset(radius, bodyTop),
          radius: Radius.circular(radius),
        );
        break;

      case TooltipDirection.top:
        // Caret points down, body above
        final bodyBottom = size.height - caretHeight;

        // Start from top-left corner (after radius)
        path.moveTo(radius, 0);

        // Top edge
        path.lineTo(size.width - radius, 0);

        // Top-right corner
        path.arcToPoint(
          Offset(size.width, radius),
          radius: Radius.circular(radius),
        );

        // Right edge
        path.lineTo(size.width, bodyBottom - radius);

        // Bottom-right corner
        path.arcToPoint(
          Offset(size.width - radius, bodyBottom),
          radius: Radius.circular(radius),
        );

        // Bottom edge with caret
        path.lineTo(caretPos + caretWidth / 2, bodyBottom);
        path.lineTo(caretPos, size.height); // Caret tip
        path.lineTo(caretPos - caretWidth / 2, bodyBottom);
        path.lineTo(radius, bodyBottom);

        // Bottom-left corner
        path.arcToPoint(
          Offset(0, bodyBottom - radius),
          radius: Radius.circular(radius),
        );

        // Left edge
        path.lineTo(0, radius);

        // Top-left corner
        path.arcToPoint(Offset(radius, 0), radius: Radius.circular(radius));
        break;

      case TooltipDirection.right:
        // Caret points left, body on right
        final bodyLeft = caretHeight;

        // Start from top-left of body (after radius)
        path.moveTo(bodyLeft + radius, 0);

        // Top edge
        path.lineTo(size.width - radius, 0);

        // Top-right corner
        path.arcToPoint(
          Offset(size.width, radius),
          radius: Radius.circular(radius),
        );

        // Right edge
        path.lineTo(size.width, size.height - radius);

        // Bottom-right corner
        path.arcToPoint(
          Offset(size.width - radius, size.height),
          radius: Radius.circular(radius),
        );

        // Bottom edge
        path.lineTo(bodyLeft + radius, size.height);

        // Bottom-left corner
        path.arcToPoint(
          Offset(bodyLeft, size.height - radius),
          radius: Radius.circular(radius),
        );

        // Left edge with caret
        path.lineTo(bodyLeft, caretPos + caretWidth / 2);
        path.lineTo(0, caretPos); // Caret tip
        path.lineTo(bodyLeft, caretPos - caretWidth / 2);
        path.lineTo(bodyLeft, radius);

        // Top-left corner
        path.arcToPoint(
          Offset(bodyLeft + radius, 0),
          radius: Radius.circular(radius),
        );
        break;

      case TooltipDirection.left:
        // Caret points right, body on left
        final bodyRight = size.width - caretHeight;

        // Start from top-left corner (after radius)
        path.moveTo(radius, 0);

        // Top edge
        path.lineTo(bodyRight - radius, 0);

        // Top-right corner
        path.arcToPoint(
          Offset(bodyRight, radius),
          radius: Radius.circular(radius),
        );

        // Right edge with caret
        path.lineTo(bodyRight, caretPos - caretWidth / 2);
        path.lineTo(size.width, caretPos); // Caret tip
        path.lineTo(bodyRight, caretPos + caretWidth / 2);
        path.lineTo(bodyRight, size.height - radius);

        // Bottom-right corner
        path.arcToPoint(
          Offset(bodyRight - radius, size.height),
          radius: Radius.circular(radius),
        );

        // Bottom edge
        path.lineTo(radius, size.height);

        // Bottom-left corner
        path.arcToPoint(
          Offset(0, size.height - radius),
          radius: Radius.circular(radius),
        );

        // Left edge
        path.lineTo(0, radius);

        // Top-left corner
        path.arcToPoint(Offset(radius, 0), radius: Radius.circular(radius));
        break;
    }

    path.close();
    return path;
  }

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
