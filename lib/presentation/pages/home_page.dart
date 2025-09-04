import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../generated/l10n.dart';
import '../../core/localization/app_localizations.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_state.dart';
import '../bloc/product/product_bloc.dart';
import '../bloc/product/product_event.dart';
import '../bloc/product/product_state.dart';
import '../bloc/settings/settings_cubit.dart';
import '../../presentation/bloc/settings/settings_state.dart';
import '../widgets/product_grid.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import 'cart_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, settingsState) {
        print(
          'HomeView rebuilding with locale: ${settingsState.locale.languageCode}',
        );
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations(settingsState.locale).appTitle,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            actions: [
              // Theme toggle button
              IconButton(
                onPressed: () {
                  context.read<SettingsCubit>().toggleTheme();
                },
                icon: Icon(
                  Theme.of(context).brightness == Brightness.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
              ),
              // Language toggle button
              IconButton(
                onPressed: () {
                  print('Language button pressed');
                  try {
                    context.read<SettingsCubit>().toggleLanguage();
                    print('toggleLanguage called successfully');
                  } catch (e) {
                    print('Error calling toggleLanguage: $e');
                  }
                },
                icon: const Icon(Icons.language),
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  int itemCount = 0;
                  if (state is CartLoaded) {
                    itemCount = state.totalItems;
                  }

                  return Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartPage(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.shopping_cart),
                      ),
                      if (itemCount > 0)
                        Positioned(
                          right: 6,
                          top: 6,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 18.w,
                              minHeight: 18.h,
                            ),
                            child: Text(
                              '$itemCount',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const LoadingWidget();
              } else if (state is ProductsLoaded) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<ProductBloc>().add(RefreshProductsEvent());
                  },
                  child: ProductGrid(products: state.products),
                );
              } else if (state is ProductError) {
                return ErrorWidgetCustom(
                  message: state.message,
                  onRetry: () {
                    context.read<ProductBloc>().add(GetProductsEvent());
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}
