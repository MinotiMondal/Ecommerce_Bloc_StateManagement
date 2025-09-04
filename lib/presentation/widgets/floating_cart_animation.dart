import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_constants.dart';
// import '../../generated/l10n.dart';
import '../../core/localization/app_localizations.dart';

class FloatingCartAnimation extends StatefulWidget {
  final Widget child;
  final bool trigger;
  final VoidCallback? onAnimationComplete;

  const FloatingCartAnimation({
    super.key,
    required this.child,
    required this.trigger,
    this.onAnimationComplete,
  });

  @override
  State<FloatingCartAnimation> createState() => _FloatingCartAnimationState();
}

class _FloatingCartAnimationState extends State<FloatingCartAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppConstants.slowAnimationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.easeInOut),
      ),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -3.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onAnimationComplete?.call();
        _controller.reset();
      }
    });
  }

  @override
  void didUpdateWidget(FloatingCartAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.trigger && !oldWidget.trigger) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}

class CartItemAddedOverlay extends StatelessWidget {
  final String productName;

  const CartItemAddedOverlay({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
     //   color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
     //      Icon(Icons.check_circle, color: Colors.white, size: 20.w),
     //      SizedBox(width: 8.w),
     //      Flexible(
     //        child: Text(
     //          AppLocalizations.of(context).addedToCart,
     //          style: TextStyle(
     //            color: Colors.white,
     //            fontSize: 14.sp,
     //            fontWeight: FontWeight.w500,
     //          ),
     //          overflow: TextOverflow.ellipsis,
     //        ),
     //      ),
        ],
      ),
    );
  }
}
