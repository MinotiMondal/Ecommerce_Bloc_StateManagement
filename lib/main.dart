import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/injection_container.dart' as di;
import 'presentation/bloc/cart/cart_bloc.dart';
import 'presentation/bloc/cart/cart_event.dart';
import 'presentation/bloc/product/product_bloc.dart';
import 'presentation/bloc/product/product_event.dart';
import 'presentation/bloc/settings/settings_cubit.dart';
import 'presentation/bloc/settings/settings_state.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/theme/app_theme.dart';
// import 'generated/l10n.dart';
import 'core/localization/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    as flutter_localizations;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await di.initHive();

  // Initialize dependencies
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => di.sl<ProductBloc>()..add(GetProductsEvent()),
            ),
            BlocProvider(
              create: (_) => di.sl<CartBloc>()..add(LoadCartEvent()),
            ),
            BlocProvider(create: (_) => di.sl<SettingsCubit>()),
          ],
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, settingsState) {
              print(
                'Building MaterialApp with locale: ${settingsState.locale.languageCode}',
              );
              return MaterialApp(
                title: 'Mini E-Commerce App',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: settingsState.themeMode,
                locale: settingsState.locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  flutter_localizations.GlobalMaterialLocalizations.delegate,
                  flutter_localizations.GlobalWidgetsLocalizations.delegate,
                  flutter_localizations.GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                home: const HomePage(),
              );
            },
          ),
        );
      },
    );
  }
}
