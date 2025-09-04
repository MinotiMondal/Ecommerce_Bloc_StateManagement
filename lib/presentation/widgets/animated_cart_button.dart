import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_constants.dart';

class AnimatedCartButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final bool isLoading;

  const AnimatedCartButton({
    super.key,
    required this.onPressed,
    this.text = 'Add to Cart',
    this.icon = Icons.add_shopping_cart,
    this.isLoading = false,
  });

  @override
  State<AnimatedCartButton> createState() => _AnimatedCartButtonState();
}

class _AnimatedCartButtonState extends State<AnimatedCartButton>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _iconController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: AppConstants.fastAnimationDuration,
      vsync: this,
    );
    _iconController = AnimationController(
      duration: AppConstants.defaultAnimationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));

    _iconAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _iconController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  void _onTap() {
    _scaleController.forward().then((_) {
      _scaleController.reverse();
      _iconController.forward().then((_) {
        _iconController.reverse();
      });
    });
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_scaleAnimation, _iconAnimation]),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: ElevatedButton.icon(
            onPressed: widget.isLoading ? null : _onTap,
            icon: widget.isLoading
                ? SizedBox(
                    width: 16.w,
                    height: 16.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  )
                : Transform.scale(
                    scale: _iconAnimation.value,
                    child: Icon(widget.icon, size: 18.w),
                  ),
            label: Text(widget.text),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 12.h,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.r),
              ),
            ),
          ),
        );
      },
    );
  }
}
