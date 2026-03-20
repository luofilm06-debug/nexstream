
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primarySeedColor = Colors.red;

    final TextTheme appTextTheme = TextTheme(
      displayLarge: GoogleFonts.oswald(fontSize: 57, fontWeight: FontWeight.bold),
      titleLarge: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w500),
      bodyMedium: GoogleFonts.openSans(fontSize: 14),
    );

    final ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primarySeedColor,
        brightness: Brightness.dark,
      ),
      textTheme: appTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        titleTextStyle: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
      ),
    );

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'NEX STREAM',
          theme: darkTheme,
          darkTheme: darkTheme,
          themeMode: themeProvider.themeMode,
          home: const SplashScreen(),
        );
      },
    );
  }
}

class YouTubeHomePage extends StatefulWidget {
  const YouTubeHomePage({super.key});

  @override
  State<YouTubeHomePage> createState() => _YouTubeHomePageState();
}

class _YouTubeHomePageState extends State<YouTubeHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ShortsScreen(),
    SubscriptionsScreen(),
    LibraryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/images/youtube_logo.png', width: 30),
        title: const Text('NEX STREAM'),
        actions: [
          const SizedBox(
            width: 300,
            child: SearchBar(
              leading: Icon(Icons.search),
              hintText: 'Search',
            ),
          ),
          IconButton(
            icon: const Icon(Icons.mic),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.cast),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          const CircleAvatar(
            radius: 15,
            backgroundColor: Colors.grey,
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_outline),
            label: 'Shorts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions_outlined),
            label: 'Subscriptions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library_outlined),
            label: 'Library',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class Video {
  final String thumbnail;
  final String avatar;
  final String title;
  final String channel;
  final String views;
  final String time;
  final String videoUrl;

  Video({
    required this.thumbnail,
    required this.avatar,
    required this.title,
    required this.channel,
    required this.views,
    required this.time,
    required this.videoUrl,
  });
}

final List<Video> mockVideos = [
  Video(
    thumbnail: 'https://picsum.photos/seed/1/800/450',
    avatar: 'https://picsum.photos/seed/101/100/100',
    title: 'Soft Jazz Music & Cozy Coffee Shop Ambience for Working, Studying',
    channel: 'Cozy Coffee Shop',
    views: '134K views',
    time: 'Streamed 20 hours ago',
    videoUrl: 'https://player.mediadelivery.net/embed/620546/38bacefa-f6b3-4509-a252-8e228db32303?autoplay=true&loop=false&muted=false&preload=true&responsive=true',
  ),
  Video(
    thumbnail: 'https://picsum.photos/seed/2/800/450',
    avatar: 'https://picsum.photos/seed/102/100/100',
    title: 'Philadelphia Eagles vs. Tampa Bay Buccaneers Game Highlights | NFL 2023',
    channel: 'NFL',
    views: '2.3M views',
    time: '14 hours ago',
    videoUrl: 'https://www.youtube.com/watch?v=9_g_v2_o_fU',
  ),
  // ... (rest of the videos)
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const FilterChipBar(),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = (constraints.maxWidth / 350).floor();
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount == 0 ? 1 : crossAxisCount,
                  childAspectRatio: 1.0,
                ),
                itemCount: mockVideos.length,
                itemBuilder: (context, index) {
                  return VideoCard(video: mockVideos[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class FilterChipBar extends StatelessWidget {
  const FilterChipBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const SizedBox(width: 10),
            FilterChip(label: const Text('All'), onSelected: (value) {}),
            const SizedBox(width: 10),
            FilterChip(label: const Text('Music'), onSelected: (value) {}),
            const SizedBox(width: 10),
            FilterChip(label: const Text('Live'), onSelected: (value) {}),
            const SizedBox(width: 10),
            FilterChip(label: const Text('Meditation music'), onSelected: (value) {}),
            const SizedBox(width: 10),
            FilterChip(label: const Text('Chill-out music'), onSelected: (value) {}),
            const SizedBox(width: 10),
            FilterChip(label: const Text('News'), onSelected: (value) {}),
            const SizedBox(width: 10),
            FilterChip(label: const Text('Gaming'), onSelected: (value) {}),
            const SizedBox(width: 10),
            FilterChip(label: const Text('Philadelphia Eagles'), onSelected: (value) {}),
            const SizedBox(width: 10),
            FilterChip(label: const Text('Romantic comedies'), onSelected: (value) {}),
          ],
        ),
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final Video video;

  const VideoCard({super.key, required this.video});

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(video.videoUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: _launchUrl,
        hoverColor: Colors.grey.withOpacity(0.3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                video.thumbnail,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(video.avatar),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          video.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('${video.channel} • ${video.views} • ${video.time}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShortsScreen extends StatelessWidget {
  const ShortsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Shorts Screen'),
    );
  }
}

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Subscriptions Screen'),
    );
  }
}

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Library Screen'),
    );
  }
}
