// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Mini E-Commerce';

  @override
  String get productDetails => 'Detalles del Producto';

  @override
  String get shoppingCart => 'Carrito de Compras';

  @override
  String get addToCart => 'Agregar al Carrito';

  @override
  String get addedToCart => '¡Agregado al carrito!';

  @override
  String get removeFromCart => 'Eliminar del carrito';

  @override
  String get clearAll => 'Limpiar Todo';

  @override
  String get clearCart => 'Limpiar Carrito';

  @override
  String get clearCartConfirmation =>
      '¿Estás seguro de que quieres eliminar todos los artículos de tu carrito?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get checkout => 'Finalizar Compra';

  @override
  String get proceedToCheckout => 'Proceder al Pago';

  @override
  String get checkoutDemo =>
      'Esta es una aplicación de demostración. La funcionalidad de pago se implementaría aquí.';

  @override
  String get ok => 'OK';

  @override
  String get continueShopping => 'Continuar Comprando';

  @override
  String get yourCartIsEmpty => 'Tu carrito está vacío';

  @override
  String get addSomeProducts => 'Agrega algunos productos para comenzar';

  @override
  String get noProductsAvailable => 'No hay productos disponibles';

  @override
  String get total => 'Total';

  @override
  String totalPrice(String price) {
    return 'Total: $price';
  }

  @override
  String items(int count) {
    return 'Artículos ($count)';
  }

  @override
  String priceEach(String price) {
    return '\$$price cada uno';
  }

  @override
  String get rating => 'Calificación';

  @override
  String get description => 'Descripción';

  @override
  String get category => 'Categoría';

  @override
  String get quantity => 'Cantidad';

  @override
  String get retry => 'Reintentar';

  @override
  String get errorLoadingProducts => 'Error al cargar productos';

  @override
  String get pullToRefresh => 'Desliza para actualizar';
}
