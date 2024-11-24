library brackets;

/// Attributes for markup tags, represented as a map of strings to nullable strings.
///
/// `null` values represent attributes without a value, e.g. `<input disabled>`.
typedef Attributes = Map<String, String?>;

/// Base class for all markup nodes.
sealed class MarkupNode {}

/// Represents a markup tag with a name, attributes, and optional children.
final class MarkupTag implements MarkupNode {
  /// The name of the tag.
  final String name;

  /// The attributes of the tag.
  final Attributes attributes;

  /// The child nodes of the tag. May be `null` if the tag is self-closing.
  final Markup? children;

  /// Creates a [MarkupTag] with the given [name], [attributes], and [children].
  const MarkupTag({
    required this.name,
    required this.attributes,
    required this.children,
  });
}

/// Extension on `String` to create a markup tag using function call syntax.
extension TagConstructorX on String {
  /// Creates a [MarkupTag] with this string as the tag name.
  MarkupNode call(
    Markup? children, {
    Attributes attrs = const {},
  }) =>
      MarkupTag(
        name: this,
        attributes: attrs,
        children: children,
      );
}

/// Represents a text node in the markup.
final class MarkupText implements MarkupNode {
  /// The text content of the node.
  final String text;

  /// Creates a [MarkupText] node with the given [text].
  const MarkupText(this.text);
}

/// Extension on `String` to create a text node using the `$` getter.
extension TextConstructorX on String {
  /// Converts this string into a [MarkupText] node.
  MarkupNode get $ => MarkupText(this);
}

/// Creates a markup node representing a key-value [pair] with the given [key] and [value].
MarkupNode pair(String key, String value) => key(
      [value.$],
    );

/// Creates markup nodes from a list of key-value [entries].
Markup pairs(List<(String, String)> entries) =>
    entries.map((e) => pair(e.$1, e.$2));

/// A collection of markup nodes, forming a markup document.
typedef Markup = Iterable<MarkupNode>;

Iterable<String> _renderMarkup(Markup markup) => markup.expand(_renderNode);

Iterable<String> _renderNode(MarkupNode node) sync* {
  switch (node) {
    case MarkupText():
      yield node.text;
    case MarkupTag(:final name, :final children):
      yield '<';
      yield node.name;
      for (final entry in node.attributes.entries) {
        final key = entry.key;
        final value = entry.value;
        if (value != null) {
          yield ' ';
          yield key;
          yield '="';
          yield value;
          yield '"';
        } else {
          yield ' ';
          yield key;
        }
      }
      if (children != null) {
        yield '>';
        yield* _renderMarkup(children);
        yield '</';
        yield name;
        yield '>';
      } else {
        yield '/>';
      }
  }
}

/// Extension on `Markup` to render it as a string.
extension RenderMarkupX on Markup {
  /// Renders the markup as a single string.
  String render() => (StringBuffer()..writeAll(_renderMarkup(this))).toString();
}

/// Wraps the given [children] in an XML declaration.
Markup xml(Markup children) => [
      '<?xml version="1.0" encoding="UTF-8"?>'.$,
      ...children,
    ];

/// Wraps the given [children] in an HTML doctype and `<html>` tag with optional [attrs].
Markup html(
  Markup children, {
  Attributes attrs = const {},
}) =>
    [
      '<!DOCTYPE html>'.$,
      'html'(attrs: attrs, children),
    ];
