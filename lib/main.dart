import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClipFlow',
      theme: ThemeData.dark(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        children: const [
          VideoPage(
            videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
            title: '¡Bienvenido a ClipFlow! 🎉',
            author: '@tuyo',
          ),
          VideoPage(
            videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
            title: 'Desliza hacia arriba 👆',
            author: '@clipflow',
          ),
        ],
      ),
    );
  }
}

class VideoPage extends StatefulWidget {
  final String videoUrl;
  final String title;
  final String author;

  const VideoPage({
    super.key,
    required this.videoUrl,
    required this.title,
    required this.author,
  });

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller;
  bool _liked = false;
  int _likes = 124;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const Center(child: CircularProgressIndicator()),
        
        // Texto inferior
        Positioned(
          bottom: 80,
          left: 16,
          right: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.author,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(widget.title),
            ],
          ),
        ),

        // Botones derecha
        Positioned(
          bottom: 100,
          right: 16,
          child: Column(
            children: [
              IconButton(
                icon: Icon(
                  _liked ? Icons.favorite : Icons.favorite_border,
                  color: _liked ? Colors.red : Colors.white,
                  size: 32,
                ),
                onPressed: () {
                  setState(() {
                    _liked = !_liked;
                    _liked ? _likes++ : _likes--;
                  });
                },
              ),
              Text('$_likes'),
              const SizedBox(height: 20),
              const Icon(Icons.comment, size: 32),
              const Text('42'),
              const SizedBox(height: 20),
              const Icon(Icons.share, size: 32),
              const Text('Compartir'),
            ],
          ),
        ),
      ],
    );
  }
}
