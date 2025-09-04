import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import '../../data/datasources/cart_local_datasource.dart';
import '../../data/datasources/product_local_datasource.dart';
import '../../data/datasources/product_remote_datasource.dart';
import '../../data/models/hive_adapters.dart';
import '../../data/repositories/cart_repository_impl.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/cart_usecases.dart';
import '../../domain/usecases/get_product.dart';
import '../../domain/usecases/get_products.dart';
import '../../presentation/bloc/cart/cart_bloc.dart';
import '../../presentation/bloc/product/product_bloc.dart';
import '../../presentation/bloc/settings/settings_cubit.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Product
  // Bloc
  sl.registerFactory(() => ProductBloc(getProducts: sl(), getProduct: sl()));

  // Bloc - Cart
  sl.registerFactory(
    () => CartBloc(
      getCartItems: sl(),
      addToCart: sl(),
      removeFromCart: sl(),
      updateCartItem: sl(),
      clearCart: sl(),
    ),
  );

  // Cubit - Settings
  sl.registerLazySingleton(() => SettingsCubit());

  // Use cases
  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerLazySingleton(() => GetProduct(sl()));
  sl.registerLazySingleton(() => GetCartItems(sl()));
  sl.registerLazySingleton(() => AddToCart(sl()));
  sl.registerLazySingleton(() => RemoveFromCart(sl()));
  sl.registerLazySingleton(() => UpdateCartItem(sl()));
  sl.registerLazySingleton(() => ClearCart(sl()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
}

Future<void> initHive() async {
  await Hive.initFlutter();

  // Register adapters manually since we're not using generated ones yet
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(RatingModelAdapter());
  Hive.registerAdapter(CartItemModelAdapter());
}
