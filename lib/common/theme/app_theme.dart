import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF1460A5),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFD3E4FF),
  onPrimaryContainer: Color(0xFF001C38),
  secondary: Color(0xFF545F70),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFD7E3F8),
  onSecondaryContainer: Color(0xFF111C2B),
  tertiary: Color.fromARGB(255, 152, 61, 255),
  onTertiary: Color(0xFFD0BCFF),
  tertiaryContainer: Color(0xFFF5D9FF),
  onTertiaryContainer: Color(0xFF261431),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFCFCFF),
  onBackground: Color(0xFF1A1C1E),
  surface: Color(0xFFF3F4F9),
  onSurface: Color(0xFF1A1C1E),
  surfaceVariant: Color(0xFFEFF1F8),
  onSurfaceVariant: Color(0xFF43474E),
  outline: Color(0xFF73777F),
  onInverseSurface: Color(0xFFF1F0F4),
  inverseSurface: Color(0xFF2F3033),
  inversePrimary: Color(0xFFA2C9FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF1460A5),
  outlineVariant: Color(0xFFC3C6CF),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFA2C9FF),
  onPrimary: Color(0xFF00315B),
  primaryContainer: Color(0xFF2F4156),
  onPrimaryContainer: Color(0xFFD7E2FF),
  secondary: Color(0xFFBBC7DB),
  onSecondary: Color(0xFF263141),
  secondaryContainer: Color(0xFF3C4758),
  onSecondaryContainer: Color(0xFFD7E3F8),
  tertiary: Color(0xFFD0BCFF),
  onTertiary: Color(0xFF272542),
  tertiaryContainer: Color(0xFF272542),
  onTertiaryContainer: Color(0xFFF5D9FF),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF0E181E),
  onBackground: Color(0xFFE3E2E6),
  surface: Color(0xFF262626),
  onSurface: Color(0xFFE3E2E6),
  surfaceVariant: Color(0xFF13232C),
  onSurfaceVariant: Color(0xFFC3C6CF),
  outline: Color(0xFF8D9199),
  onInverseSurface: Color(0xFF1A1C1E),
  inverseSurface: Color(0xFFE3E2E6),
  inversePrimary: Color(0xFF1460A5),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFA2C9FF),
  outlineVariant: Color(0xFF43474E),
  scrim: Color(0xFF000000),
);

TextTheme lightTextTheme(BuildContext context) {
  return GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme)
      .apply(
        displayColor: lightColorScheme.onBackground,
      )
      .copyWith(
        bodyMedium: TextStyle(color: lightColorScheme.onBackground),
        bodyLarge: TextStyle(color: lightColorScheme.onBackground),
        headlineSmall: TextStyle(color: lightColorScheme.onSurfaceVariant),
        titleSmall: TextStyle(color: lightColorScheme.onSurfaceVariant),
        labelLarge: TextStyle(color: lightColorScheme.onSurfaceVariant),
        titleLarge: TextStyle(color: lightColorScheme.onSurfaceVariant),
        titleMedium: TextStyle(color: lightColorScheme.onSurfaceVariant),
        labelSmall: TextStyle(color: lightColorScheme.onSurfaceVariant),
      );
}

TextTheme darkTextTheme(BuildContext context) {
  return GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme)
      .apply(
        displayColor: darkColorScheme.onBackground,
      )
      .copyWith(
        bodyMedium: TextStyle(color: darkColorScheme.onBackground),
        bodyLarge: TextStyle(color: darkColorScheme.onBackground),
        headlineSmall: TextStyle(color: darkColorScheme.onBackground),
        titleSmall: TextStyle(color: darkColorScheme.onBackground),
        labelLarge: TextStyle(color: darkColorScheme.onBackground),
        titleLarge: TextStyle(color: darkColorScheme.onBackground),
        titleMedium: TextStyle(color: darkColorScheme.onBackground),
        labelSmall: TextStyle(color: darkColorScheme.onBackground),
      );
}
