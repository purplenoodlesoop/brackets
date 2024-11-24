import 'package:brackets/brackets.dart';
import 'package:test/test.dart';

void main() {
  test('MarkupText renders correctly', () {
    expect(
      ['Hello, World!'.$].render(),
      equals('Hello, World!'),
    );
  });

  test('MarkupTag renders self-closing tag', () {
    expect(
      ['br'(null)].render(),
      equals('<br/>'),
    );
  });

  test('MarkupTag with attributes and children', () {
    expect(
      [
        'div'(
          attrs: {'class': 'container'},
          ['Content'.$],
        ),
      ].render(),
      equals('<div class="container">Content</div>'),
    );
  });

  test('pair creates a key-value pair', () {
    expect(
      [pair('key', 'value')].render(),
      equals('<key>value</key>'),
    );
  });

  test('pairs creates multiple pairs', () {
    expect(
      pairs([
        ('first', '1'),
        ('second', '2'),
      ]).render(),
      equals('<first>1</first><second>2</second>'),
    );
  });

  test('xml wraps content with XML declaration', () {
    expect(
      xml([
        'root'(['child'.$]),
      ]).render(),
      equals('<?xml version="1.0" encoding="UTF-8"?><root>child</root>'),
    );
  });

  test('html wraps content with doctype and html tag', () {
    expect(
      html([
        'body'([
          'h1'(['Title'.$]),
          'p'(['Paragraph'.$]),
        ]),
      ]).render(),
      equals(
        '<!DOCTYPE html><html><body><h1>Title</h1><p>Paragraph</p></body></html>',
      ),
    );
  });
}
