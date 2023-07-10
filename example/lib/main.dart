import 'package:image/image.dart' as img_lib;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stack_art_board/stack_art_board.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final StackArtBoardController controller = StackArtBoardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stack Art Board Demo'),
      ),
      body: Center(
        child: StackArtBoard(
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
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
            },
            child: const Text('add custom canvas'),
          ),
          ElevatedButton(
            onPressed: () async {
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
            },
            child: const Text('add transparent bg image'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.moveToTop();
            },
            child: const Text('move to top'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.moveToBottom();
            },
            child: const Text('move to bottom'),
          ),
        ],
      ),
    );
  }
}
