import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../providers/water_provider.dart';
import '../l10n/app_localizations.dart';

class HydrationWave extends StatefulWidget {
  const HydrationWave({super.key});

  @override
  State<HydrationWave> createState() => _HydrationWaveState();
}

class _HydrationWaveState extends State<HydrationWave>
    with TickerProviderStateMixin {
  late final AnimationController _waveController;
  late final AnimationController _entranceController;
  late final Animation<double> _entranceAnimation;
  AnimationController? _rippleController;
  double _rippleAmplitude = 0.0;

  @override
  void initState() {
    super.initState();
    // Continuous ambient wave animation
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // Entrance: water level rises from 0
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _entranceAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    );
    _entranceController.forward();
  }

  @override
  void dispose() {
    _waveController.dispose();
    _entranceController.dispose();
    _rippleController?.dispose();
    super.dispose();
  }

  void _onTap(WaterProvider water) {
    water.increment();

    // Trigger ripple: amplitude pulse 300ms
    _rippleController?.dispose();
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _rippleAmplitude = 1.0;
    _rippleController!.addListener(() {
      setState(() {
        _rippleAmplitude = 1.0 - _rippleController!.value;
      });
    });
    _rippleController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    final water = context.watch<WaterProvider>();
    final current = water.consumed;
    final goal = water.goal;
    final fillRatio = goal > 0 ? (current / goal).clamp(0.0, 1.0) : 0.0;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Semantics(
        button: true,
        label: AppLocalizations.of(context)!.glassesToday(current, goal),
        child: GestureDetector(
          onTap: () => _onTap(water),
          child: SizedBox(
          width: double.infinity,
          height: 140,
          child: Stack(
            children: [
              // Animated wave water fill
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: Listenable.merge([_waveController, _entranceAnimation]),
                  builder: (context, child) {
                    return CustomPaint(
                      painter: _WavePainter(
                        fillRatio: fillRatio * _entranceAnimation.value,
                        wavePhase: _waveController.value * 2 * math.pi,
                        rippleAmplitude: _rippleAmplitude,
                        waterColor: primaryColor,
                        isDark: isDark,
                      ),
                    );
                  },
                ),
              ),
              // Content overlay — always use theme text colors for readability
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.water_drop_rounded,
                        color: primaryColor,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.hydration,
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              AppLocalizations.of(context)!.glassesToday(current, goal),
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              AppLocalizations.of(context)!.tapToAddGlass,
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      // Percentage indicator
                      Text(
                        '${(fillRatio * 100).round()}%',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: primaryColor.withValues(alpha: 0.35),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  final double fillRatio;
  final double wavePhase;
  final double rippleAmplitude;
  final Color waterColor;
  final bool isDark;

  _WavePainter({
    required this.fillRatio,
    required this.wavePhase,
    required this.rippleAmplitude,
    required this.waterColor,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (fillRatio <= 0) return;

    final waterHeight = size.height * fillRatio;
    final waterTop = size.height - waterHeight;

    // Base amplitude (subtle ambient) + ripple amplitude (on tap)
    final baseAmplitude = 3.0;
    final totalAmplitude = baseAmplitude + rippleAmplitude * 8.0;

    // Draw wave path
    final path = Path();
    path.moveTo(0, size.height);

    // Draw bottom and up the left side to the wave start
    path.lineTo(0, waterTop);

    // Sine wave across the top of the water
    for (double x = 0; x <= size.width; x += 1) {
      final y = waterTop +
          math.sin((x / size.width) * 2 * math.pi + wavePhase) * totalAmplitude +
          math.sin((x / size.width) * 4 * math.pi + wavePhase * 1.5) * totalAmplitude * 0.3;
      path.lineTo(x, y);
    }

    // Close path along right and bottom
    path.lineTo(size.width, size.height);
    path.close();

    // Fill with water color — visible but not overwhelming text
    final fillPaint = Paint()
      ..color = waterColor.withValues(alpha: isDark ? 0.20 : 0.12)
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, fillPaint);

    // Draw a stronger wave crest line
    final crestPath = Path();
    for (double x = 0; x <= size.width; x += 1) {
      final y = waterTop +
          math.sin((x / size.width) * 2 * math.pi + wavePhase) * totalAmplitude +
          math.sin((x / size.width) * 4 * math.pi + wavePhase * 1.5) * totalAmplitude * 0.3;
      if (x == 0) {
        crestPath.moveTo(x, y);
      } else {
        crestPath.lineTo(x, y);
      }
    }

    final crestPaint = Paint()
      ..color = waterColor.withValues(alpha: isDark ? 0.5 : 0.35)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    canvas.drawPath(crestPath, crestPaint);
  }

  @override
  bool shouldRepaint(_WavePainter oldDelegate) => true;
}
