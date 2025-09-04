import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const CartItemWidget({
    super.key,
    required this.cartItem,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            // Product Image
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  imageUrl: cartItem.product.image,
                  fit: BoxFit.contain,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, color: Colors.grey),
                ),
              ),
            ),

            SizedBox(width: 12.w),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    cartItem.product.category,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$${cartItem.product.price.toStringAsFixed(2)} each',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Total: \$${cartItem.totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(width: 4.w),

            // Quantity Controls and Remove Button
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Remove Button
                SizedBox(
                  width: 32.w,
                  height: 32.h,
                  child: IconButton(
                    onPressed: onRemove,
                    icon: const Icon(Icons.delete_outline),
                    style: IconButton.styleFrom(
                      foregroundColor: Colors.red,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.zero,
                    ),
                    iconSize: 18.w,
                  ),
                ),

                SizedBox(height: 4.h),

                // Quantity Controls
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.outline.withOpacity(0.3),
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 28.w,
                        height: 28.h,
                        child: IconButton(
                          onPressed: cartItem.quantity > 1
                              ? () => onQuantityChanged(cartItem.quantity - 1)
                              : null,
                          icon: const Icon(Icons.remove),
                          style: IconButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: EdgeInsets.zero,
                          ),
                          iconSize: 14.w,
                        ),
                      ),
                      Container(
                        width: 24.w,
                        alignment: Alignment.center,
                        child: Text(
                          '${cartItem.quantity}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 28.w,
                        height: 28.h,
                        child: IconButton(
                          onPressed: () =>
                              onQuantityChanged(cartItem.quantity + 1),
                          icon: const Icon(Icons.add),
                          style: IconButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: EdgeInsets.zero,
                          ),
                          iconSize: 14.w,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
