import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/product.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_event.dart';
import '../bloc/cart/cart_state.dart';
import '../pages/product_detail_page.dart';
import 'floating_cart_animation.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _showAnimation = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailPage(product: widget.product),
                ),
              );
            },
            borderRadius: BorderRadius.circular(12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8.w),
                    child: CachedNetworkImage(
                      imageUrl: widget.product.image,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                          width: 30.w,
                          height: 30.h,
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error, size: 40.w, color: Colors.grey),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            widget.product.title,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Icon(Icons.star, size: 14.w, color: Colors.amber),
                            SizedBox(width: 4.w),
                            Text(
                              widget.product.rating.rate.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.7),
                              ),
                            ),
                            Text(
                              ' (${widget.product.rating.count})',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '\$${widget.product.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                            SizedBox(width: 4.w),
                            SizedBox(
                              width: 28.w,
                              height: 28.h,
                              child: BlocListener<CartBloc, CartState>(
                                listener: (context, state) {
                                  if (state is CartItemAdded) {
                                    setState(() {
                                      _showAnimation = true;
                                    });
                                  }
                                },
                                child: IconButton(
                                  onPressed: () {
                                    context.read<CartBloc>().add(
                                      AddToCartEvent(widget.product),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.add_shopping_cart,
                                    size: 14.w,
                                  ),
                                  style: IconButton.styleFrom(
                                    backgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    foregroundColor: Colors.white,
                                  ),
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Floating animation overlay
        if (_showAnimation)
          Positioned(
            top: 20.h,
            left: 20.w,
            right: 20.w,
            child: FloatingCartAnimation(
              trigger: _showAnimation,
              onAnimationComplete: () {
                setState(() {
                  _showAnimation = false;
                });
              },
              child: CartItemAddedOverlay(productName: widget.product.title),
            ),
          ),
      ],
    );
  }
}
