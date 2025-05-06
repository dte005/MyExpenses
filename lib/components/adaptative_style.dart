class AdaptativeStyle {
  final double? padding;
  final double? fontSize;
  final String? fontFamily;
  final double? margin;

  const AdaptativeStyle({
    this.padding,
    this.fontSize,
    this.margin,
    this.fontFamily,
  });

  static AdaptativeStyle checkingStyle(
    AdaptativeStyle? style,
    AdaptativeStyle failedCondition,
  ) {
    return style ?? failedCondition;
  }
}
