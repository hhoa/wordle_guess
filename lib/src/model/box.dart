import '../enum/box.dart';

typedef Boxes = List<Box>;

class Box {
  Box({this.type = BoxType.none, this.char});

  final String? char;
  final BoxType type;
}
