import 'package:flutter/material.dart';
import 'dart:math' show pi;

import 'package:hikayati_app/core/app_theme.dart';

class PlayButton extends StatefulWidget {
  final bool initialIsPlaying;
  final Icon playIcon;
  final Icon pauseIcon;
  final VoidCallback onPressed;

  PlayButton({
    required this.onPressed,
    this.initialIsPlaying = false,
    this.playIcon = const Icon(Icons.play_arrow),
    this.pauseIcon = const Icon(Icons.pause),
  }) : assert(onPressed != null);

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> with TickerProviderStateMixin {
  static const _kToggleDuration = Duration(milliseconds: 200);
  static const _kRotationDuration = Duration(seconds: 1);

  late bool isPlaying;

  // rotation and scale animations
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  double _rotation = 0;
  double _scale = 0.95;

  bool get _showWaves => !_scaleController.isDismissed;

  void _updateRotation() => _rotation = _rotationController.value * 1 * pi;
  void _updateScale() => _scale = (_scaleController.value * 0.2) + 0.85;

  @override
  void initState() {
    isPlaying = widget.initialIsPlaying;
    _rotationController =
    AnimationController(vsync: this, duration: _kRotationDuration)
      ..addListener(() => setState(_updateRotation))
      ..repeat();

    _scaleController =
    AnimationController(vsync: this, duration: _kToggleDuration)
      ..addListener(() => setState(_updateScale));

    super.initState();
  }

  void _onToggle() {
    setState(() => isPlaying = !isPlaying);

    if (_scaleController.isCompleted) {
      _scaleController.reverse();
    } else {
      _scaleController.forward();
    }

    widget.onPressed();
  }

  Widget _buildIcon(bool isPlaying) {
    return SizedBox.expand(
      key: ValueKey<bool>(isPlaying),
      child: IconButton(
        icon: isPlaying ? widget.pauseIcon : widget.playIcon,
        onPressed: _onToggle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 30, minHeight: 30,),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_showWaves) ...[
            Blob(color: Color(0xffffffff), scale: _scale*1, rotation: _rotation),
            Blob(color: Color(0xfff6e4a0), scale: _scale*1, rotation: _rotation * 2 - 80),
            Blob(color: Color(0xfff8ceb7), scale: _scale*1, rotation: _rotation * 3 - 80),
          ],
          Container(
            constraints: BoxConstraints.expand(),
            child: AnimatedSwitcher(
              child: _buildIcon(isPlaying),
              duration: _kToggleDuration,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.primaryColor,width: 2),
              shape: BoxShape.rectangle

              ,borderRadius: BorderRadius.all(Radius.circular(15)),
              color: isPlaying?Colors.white:Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }
}

class Blob extends StatelessWidget {
  final double rotation;
  final double scale;
  final Color color;

  const Blob({required this.color, this.rotation = 0, this.scale = 1});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Transform.rotate(
        angle: rotation,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(20)
            ),
          ),
        ),
      ),
    );
  }
}