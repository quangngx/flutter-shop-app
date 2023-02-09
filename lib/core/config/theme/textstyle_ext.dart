import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'light_theme.dart';

class TextStyles {
  static TextStyle defaultStyle = GoogleFonts.poppins(
    fontSize: 14,
    color: LightTheme.neutral900Color,
    fontWeight: FontWeight.w400,
    height: 18 / 14,
  );

  BuildContext? context;

  TextStyles(this.context);
}

extension ExtendedTextStyle on TextStyle {
  TextStyle get bold {
    return copyWith(fontWeight: FontWeight.w700);
  }

  TextStyle get italic {
    return copyWith(
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.italic,
    );
  }

  TextStyle get light {
    return copyWith(fontWeight: FontWeight.w300);
  }

  TextStyle get medium {
    return copyWith(fontWeight: FontWeight.w500);
  }

  TextStyle get primaryTextColor {
    return copyWith(color: LightTheme.neutral900Color);
  }

  TextStyle get regular {
    return copyWith(fontWeight: FontWeight.w400);
  }

  TextStyle get semibold {
    return copyWith(fontWeight: FontWeight.w600);
  }

  TextStyle get subTitleTextColor {
    return copyWith(color: LightTheme.neutral500Color);
  }

  TextStyle get whiteTextColor {
    return copyWith(color: Colors.white);
  }

  TextStyle setColor(Color color) {
    return copyWith(color: color);
  }

  TextStyle setTextSize(double size) {
    return copyWith(fontSize: size);
  }
}
