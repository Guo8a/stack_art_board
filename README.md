# Stack Art Board

A Flutter package consisting of stacks that allows adding any widgets, and enables editing, deleting, and changing the order of layers.

[![pub package](https://img.shields.io/pub/v/stack_board?logo=dart&label=stable&style=flat-square)](https://pub.dev/packages/stack_art_board)
[![GitHub stars](https://img.shields.io/github/stars/Apach3Q/stack_art_board?logo=github&style=flat-square)](https://github.com/Apach3Q/stack_art_board/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/Apach3Q/stack_art_board?logo=github&style=flat-square)](https://github.com/Apach3Q/stack_art_board/network/members)

---
For a more throughout example see the example.


---
### Initialize a `StackArtboard`

```dart
import 'package:stack_art_board/stack_art_board.dart';

final StackArtBoardController controller = StackArtBoardController();

StackArtBoard(
    stackArtBoardKey: UniqueKey(),
    controller: controller,
    artBoardConfig: ArtBoardConfig(
    containerSize: const Size(300, 300),
    artBoardSize: const Size(3000, 3000),
    toolIconWidth: 20,
    borderWidth: 5,
    borderColor: Colors.black,
    rotateWidget: Container(color: Colors.orange),
    deleteWidget: Container(color: Colors.purple),
    ),
    background: Container(color: Colors.green),
),
```
---

### Add a custom Widget


```dart
controller.add(
    CustomCanvasItem(
        child: Container(
            color: Colors.red,
            child: const Center(
                child: Text('text'),
            ),
        ),
        canvasConfig: CanvasConfig(
            size: const Size(600, 600),
            transform: Matrix4.identity(),
            allowUserInteraction: true,
        ),
    ),
);
```
---
### Add an Image widget with the ability to penetrate click events through transparent areas of the image.

```dart
final ByteData data = await rootBundle.load('assets/image.png');
final imageBytes = data.buffer.asUint8List();
final image = img_lib.decodeImage(imageBytes);
if (image == null) return;
controller.add(
    TransparentBgImageCanvasItem(
        image: image,
        imageBytes: imageBytes,
        canvasConfig: CanvasConfig(
            size: Size(image.width.toDouble(), image.height.toDouble()),
            transform: Matrix4.identity(),
            allowUserInteraction: true,
        ),
    ),
);
```
---

### All canvas operations


```dart
void add<T extends CanvasItem>(T item)
```

```dart
void insert<T extends CanvasItem>(T item, int index)
```
```dart
void remove(Key key)
```
```dart
void removeExcept(Key key)
```
```dart
bool contain(Key key)
```
```dart
void clear()
```
```dart
void moveToTop()
```
```dart
void moveToBottom()
```
```dart
void move(int oldIndex, int newIndex)
```
```dart
void reset()
```
```dart
void dispose()
```


