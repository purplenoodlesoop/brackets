// ignore_for_file: avoid_print

import 'package:brackets/brackets.dart';

void main() {
  final markup = html([
    'head'([
      'title'([
        'Example'.$,
      ]),
    ]),
    'body'([
      'h1'([
        'Hello from brackets!'.$,
      ]),
    ]),
  ]);

  print(markup.render());
}
