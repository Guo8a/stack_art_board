# Stack Art Board

A Flutter package consisting of stacks that allows adding any widgets, and enables editing, deleting, and changing the order of layers.

[![pub package](https://img.shields.io/pub/v/stack_art_board?logo=dart&label=stable&style=flat-square)](https://pub.dev/packages/stack_art_board)
[![GitHub stars](https://img.shields.io/github/stars/Apach3Q/stack_art_board?logo=github&style=flat-square)](https://github.com/Apach3Q/stack_art_board/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/Apach3Q/stack_art_board?logo=github&style=flat-square)](https://github.com/Apach3Q/stack_art_board/network/members)

---
For a more throughout example see the example.

[video](https://github.com/Apach3Q/stack_art_board/assets/21135761/e35e814d-ddc9-4927-937a-e99daa11df1d)

---
## How to Use

### Getting started

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  stack_art_board: <latest_version>
```

In your library add the following import:

```dart
import 'package:stack_art_board/stack_art_board.dart';
```

For help getting started with Flutter, view the online [documentation](https://docs.flutter.dev/).


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
---

## Sponsoring

I'm working on my packages on my free-time, but I don't have as much time as I would. If this package or any other package I created is helping you, please consider to sponsor me so that I can take time to read the issues, fix bugs, merge pull requests and add features to these packages.

---
## Contributions

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue](https://github.com/Apach3Q/stack_art_board/issues).  
If you fixed a bug or implemented a feature, please send a [pull request](https://github.com/Apach3Q/stack_art_board/pulls).