class AdaptativeStyle {
  final double? padding;
  final double? fontSize;
  final double? margin;

  const AdaptativeStyle({
    this.padding,
    this.fontSize,
    this.margin,
  }); //positional sempre é obrigatório
  const AdaptativeStyle.position(this.padding, this.fontSize, this.margin);
}
