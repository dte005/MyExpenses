class AdaptativeStyle {
  final double? padding;
  final double? fontSize;
  final double? margin;

  AdaptativeStyle({
    this.padding,
    this.fontSize,
    this.margin,
  }); //positional sempre é obrigatório
  AdaptativeStyle.position(this.padding, this.fontSize, this.margin);
}
