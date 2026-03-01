import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../services/database_service.dart';
import '../../utils/theme_provider.dart';
import '../onboarding/onboarding_screen.dart';
import '../navigation/main_navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final VideoPlayerController _controller;
  bool _navigated = false;
  bool _videoDone = false;
  bool _dbReady = false;

  @override
  void initState() {
    super.initState();

    // Start DB initialization in background.
    DatabaseService.initialize().then((_) {
      _dbReady = true;
      // Reload theme now that profileBox is available.
      if (mounted) {
        context.read<ThemeProvider>().loadFromDb();
      }
      _tryNavigate();
    }).catchError((e) {
      debugPrint('DB initialization failed: $e');
      _dbReady = true;
      _tryNavigate();
    });

    // Start video playback.
    _controller = VideoPlayerController.asset('assets/splash.mp4');
    _controller.initialize().then((_) {
      if (mounted) {
        _controller.setVolume(0);
        setState(() {});
        _controller.play();
      }
    }).catchError((e) {
      debugPrint('Video initialization failed: $e');
      _videoDone = true;
      _tryNavigate();
    });
    _controller.addListener(_onVideoUpdate);
  }

  void _onVideoUpdate() {
    if (_controller.value.isCompleted) {
      _videoDone = true;
      _tryNavigate();
    }
  }

  void _skip() {
    _videoDone = true;
    _tryNavigate();
  }

  void _tryNavigate() {
    if (!_videoDone || !_dbReady || _navigated || !mounted) return;
    _navigated = true;

    final onboardingCompleted = DatabaseService.isInitialized &&
        DatabaseService.profileBox.get('onboarding_completed') == true;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => onboardingCompleted
            ? const MainNavigationScreen()
            : const OnboardingScreen(),
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_onVideoUpdate);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _skip,
        child: _controller.value.isInitialized
            ? SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              )
            : const SizedBox.expand(),
      ),
    );
  }
}
