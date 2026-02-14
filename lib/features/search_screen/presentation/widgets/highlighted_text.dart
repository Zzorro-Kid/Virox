import 'package:flutter/widgets.dart';

class HighlightedText extends StatelessWidget {
  final String text;
  final String? query;
  final TextStyle style;
  final FontWeight highlightWeight;

  const HighlightedText({
    super.key,
    required this.text,
    required this.query,
    required this.style,
    this.highlightWeight = FontWeight.w700,
  });

  @override
  Widget build(BuildContext context) {
    if (query == null || query!.isEmpty) {
      return Text(text, style: style);
    }

    final spans = _buildTextSpans(
      text,
      query!.toLowerCase(),
      style,
      highlightWeight,
    );

    return RichText(text: TextSpan(children: spans));
  }

  List<TextSpan> _buildTextSpans(
    String text,
    String query,
    TextStyle baseStyle,
    FontWeight highlightWeight,
  ) {
    final List<TextSpan> spans = [];
    final lowerText = text.toLowerCase();
    int start = 0;

    while (start < text.length) {
      final index = lowerText.indexOf(query, start);

      if (index == -1) {
        if (start < text.length) {
          spans.add(_buildNormalTextSpan(text.substring(start), baseStyle));
        }
        break;
      }

      if (index > start) {
        spans.add(
          _buildNormalTextSpan(text.substring(start, index), baseStyle),
        );
      }

      spans.add(
        _buildHighlightedTextSpan(
          text.substring(index, index + query.length),
          baseStyle,
          highlightWeight,
        ),
      );

      start = index + query.length;
    }

    return spans;
  }

  TextSpan _buildNormalTextSpan(String text, TextStyle style) {
    return TextSpan(text: text, style: style);
  }

  TextSpan _buildHighlightedTextSpan(
    String text,
    TextStyle baseStyle,
    FontWeight highlightWeight,
  ) {
    return TextSpan(
      text: text,
      style: baseStyle.copyWith(fontWeight: highlightWeight),
    );
  }
}
