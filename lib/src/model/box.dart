import '../enum/box.dart';

typedef Boxes = List<Box>;

class Box {
  Box({this.type = BoxType.none, this.char, this.slot});

  final BoxType type;
  final String? char;
  final int? slot;
}
