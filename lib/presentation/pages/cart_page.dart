import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../generated/l10n.dart';
import '../../core/localization/app_localizations.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_event.dart';
import '../bloc/cart/cart_state.dart';
import '../widgets/cart_item_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(LoadCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).shoppingCart,
          style: TextStyle(fontSize: 18.sp),
        ),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoaded && state.items.isNotEmpty) {
                return TextButton(
                  onPressed: () {
                    _showClearCartDialog(context);
                  },
                  child: Text(AppLocalizations.of(context).clearAll),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CartLoading) {
            return const LoadingWidget();
          } else if (state is CartLoaded) {
            if (state.items.isEmpty) {
              return _buildEmptyCart();
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16.w),
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      return CartItemWidget(
                        cartItem: state.items[index],
                        onQuantityChanged: (newQuantity) {
                          final updatedItem = state.items[index].copyWith(
                            quantity: newQuantity,
                          );
                          context.read<CartBloc>().add(
                            UpdateCartItemEvent(updatedItem),
                          );
                        },
                        onRemove: () {
                          context.read<CartBloc>().add(
                            RemoveFromCartEvent(state.items[index].product.id),
                          );
                        },
                      );
                    },
                  ),
                ),
                _buildCartSummary(state),
              ],
            );
          } else if (state is CartError) {
            return ErrorWidgetCustom(
              message: state.message,
              onRetry: () {
                context.read<CartBloc>().add(LoadCartEvent());
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80.w,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16.h),
          Text(
            AppLocalizations.of(context).yourCartIsEmpty,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            AppLocalizations.of(context).addSomeProducts,
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[500]),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context).continueShopping),
          ),
        ],
      ),
    );
  }

  Widget _buildCartSummary(CartLoaded state) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).items(state.totalItems),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                Text(
                  '\$${state.totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).total,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  '\$${state.totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showCheckoutDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
                child: Text(
                  AppLocalizations.of(context).proceedToCheckout,
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Clear Cart'),
          content: const Text(
            'Are you sure you want to remove all items from your cart?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<CartBloc>().add(ClearCartEvent());
              },
              child: const Text('Clear All'),
            ),
          ],
        );
      },
    );
  }

  void _showCheckoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Checkout'),
          content: const Text(
            'This is a demo app. Checkout functionality would be implemented here.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
