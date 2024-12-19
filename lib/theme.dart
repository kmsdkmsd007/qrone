import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4283456402),
      surfaceTint: Color(4283456402),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4292796927),
      onPrimaryContainer: Color(4278785611),
      secondary: Color(4283521938),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4292796671),
      onSecondaryContainer: Color(4278851147),
      tertiary: Color(4285944942),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4294957042),
      onTertiaryContainer: Color(4281143848),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294703359),
      onSurface: Color(4279966497),
      onSurfaceVariant: Color(4282795599),
      outline: Color(4285953664),
      outlineVariant: Color(4291216848),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281348150),
      inversePrimary: Color(4290364415),
      primaryFixed: Color(4292796927),
      onPrimaryFixed: Color(4278785611),
      primaryFixedDim: Color(4290364415),
      onPrimaryFixedVariant: Color(4281877369),
      secondaryFixed: Color(4292796671),
      onSecondaryFixed: Color(4278851147),
      secondaryFixedDim: Color(4290429951),
      onSecondaryFixedVariant: Color(4281942905),
      tertiaryFixed: Color(4294957042),
      onTertiaryFixed: Color(4281143848),
      tertiaryFixedDim: Color(4293245656),
      onTertiaryFixedVariant: Color(4284300373),
      surfaceDim: Color(4292598240),
      surfaceBright: Color(4294703359),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294308602),
      surfaceContainer: Color(4293914100),
      surfaceContainerHigh: Color(4293519343),
      surfaceContainerHighest: Color(4293124585),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4281614196),
      surfaceTint: Color(4283456402),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4284969386),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281679732),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4284969386),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4283971921),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4287523204),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294703359),
      onSurface: Color(4279966497),
      onSurfaceVariant: Color(4282532427),
      outline: Color(4284374631),
      outlineVariant: Color(4286216835),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281348150),
      inversePrimary: Color(4290364415),
      primaryFixed: Color(4284969386),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4283324560),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4284969386),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283324560),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4287523204),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4285813099),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292598240),
      surfaceBright: Color(4294703359),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294308602),
      surfaceContainer: Color(4293914100),
      surfaceContainerHigh: Color(4293519343),
      surfaceContainerHighest: Color(4293124585),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4279311698),
      surfaceTint: Color(4283456402),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4281614196),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4279377234),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4281679732),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4281604143),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4283971921),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294703359),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280427307),
      outline: Color(4282532427),
      outlineVariant: Color(4282532427),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281348150),
      inversePrimary: Color(4293585663),
      primaryFixed: Color(4281614196),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4280100957),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4281679732),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4280166493),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4283971921),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4282393402),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292598240),
      surfaceBright: Color(4294703359),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294308602),
      surfaceContainer: Color(4293914100),
      surfaceContainerHigh: Color(4293519343),
      surfaceContainerHighest: Color(4293124585),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4290364415),
      surfaceTint: Color(4290364415),
      onPrimary: Color(4280364129),
      primaryContainer: Color(4281877369),
      onPrimaryContainer: Color(4292796927),
      secondary: Color(4290429951),
      onSecondary: Color(4280429665),
      secondaryContainer: Color(4281942905),
      onSecondaryContainer: Color(4292796671),
      tertiary: Color(4293245656),
      onTertiary: Color(4282656318),
      tertiaryContainer: Color(4284300373),
      onTertiaryContainer: Color(4294957042),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279374616),
      onSurface: Color(4293124585),
      onSurfaceVariant: Color(4291216848),
      outline: Color(4287664282),
      outlineVariant: Color(4282795599),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293124585),
      inversePrimary: Color(4283456402),
      primaryFixed: Color(4292796927),
      onPrimaryFixed: Color(4278785611),
      primaryFixedDim: Color(4290364415),
      onPrimaryFixedVariant: Color(4281877369),
      secondaryFixed: Color(4292796671),
      onSecondaryFixed: Color(4278851147),
      secondaryFixedDim: Color(4290429951),
      onSecondaryFixedVariant: Color(4281942905),
      tertiaryFixed: Color(4294957042),
      onTertiaryFixed: Color(4281143848),
      tertiaryFixedDim: Color(4293245656),
      onTertiaryFixedVariant: Color(4284300373),
      surfaceDim: Color(4279374616),
      surfaceBright: Color(4281874751),
      surfaceContainerLowest: Color(4279045651),
      surfaceContainerLow: Color(4279966497),
      surfaceContainer: Color(4280229669),
      surfaceContainerHigh: Color(4280887855),
      surfaceContainerHighest: Color(4281611322),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4290758911),
      surfaceTint: Color(4290364415),
      onPrimary: Color(4278390598),
      primaryContainer: Color(4286811592),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4290758911),
      onSecondary: Color(4278456134),
      secondaryContainer: Color(4286811592),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4293508828),
      onTertiary: Color(4280749091),
      tertiaryContainer: Color(4289496481),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279374616),
      onSurface: Color(4294834943),
      onSurfaceVariant: Color(4291545812),
      outline: Color(4288848556),
      outlineVariant: Color(4286743180),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293124585),
      inversePrimary: Color(4282008698),
      primaryFixed: Color(4292796927),
      onPrimaryFixed: Color(4278192703),
      primaryFixedDim: Color(4290364415),
      onPrimaryFixedVariant: Color(4280758887),
      secondaryFixed: Color(4292796671),
      onSecondaryFixed: Color(4278192448),
      secondaryFixedDim: Color(4290429951),
      onSecondaryFixedVariant: Color(4280824423),
      tertiaryFixed: Color(4294957042),
      onTertiaryFixed: Color(4280354589),
      tertiaryFixedDim: Color(4293245656),
      onTertiaryFixedVariant: Color(4283051076),
      surfaceDim: Color(4279374616),
      surfaceBright: Color(4281874751),
      surfaceContainerLowest: Color(4279045651),
      surfaceContainerLow: Color(4279966497),
      surfaceContainer: Color(4280229669),
      surfaceContainerHigh: Color(4280887855),
      surfaceContainerHighest: Color(4281611322),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294834943),
      surfaceTint: Color(4290364415),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4290758911),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294834943),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4290758911),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294965754),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4293508828),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279374616),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294834943),
      outline: Color(4291545812),
      outlineVariant: Color(4291545812),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293124585),
      inversePrimary: Color(4279903578),
      primaryFixed: Color(4293125631),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4290758911),
      onPrimaryFixedVariant: Color(4278390598),
      secondaryFixed: Color(4293125631),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4290758911),
      onSecondaryFixedVariant: Color(4278456134),
      tertiaryFixed: Color(4294958579),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4293508828),
      onTertiaryFixedVariant: Color(4280749091),
      surfaceDim: Color(4279374616),
      surfaceBright: Color(4281874751),
      surfaceContainerLowest: Color(4279045651),
      surfaceContainerLow: Color(4279966497),
      surfaceContainer: Color(4280229669),
      surfaceContainerHigh: Color(4280887855),
      surfaceContainerHighest: Color(4281611322),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
