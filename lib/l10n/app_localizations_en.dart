// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Mini E-Commerce';

  @override
  String get productDetails => 'Product Details';

  @override
  String get shoppingCart => 'Shopping Cart';

  @override
  String get addToCart => 'Add to Cart';

  @override
  String get addedToCart => 'Added to cart!';

  @override
  String get removeFromCart => 'Remove from cart';

  @override
  String get clearAll => 'Clear All';

  @override
  String get clearCart => 'Clear Cart';

  @override
  String get clearCartConfirmation =>
      'Are you sure you want to remove all items from your cart?';

  @override
  String get cancel => 'Cancel';

  @override
  String get checkout => 'Checkout';

  @override
  String get proceedToCheckout => 'Proceed to Checkout';

  @override
  String get checkoutDemo =>
      'This is a demo app. Checkout functionality would be implemented here.';

  @override
  String get ok => 'OK';

  @override
  String get continueShopping => 'Continue Shopping';

  @override
  String get yourCartIsEmpty => 'Your cart is empty';

  @override
  String get addSomeProducts => 'Add some products to get started';

  @override
  String get noProductsAvailable => 'No products available';

  @override
  String get total => 'Total';

  @override
  String totalPrice(String price) {
    return 'Total: $price';
  }

  @override
  String items(int count) {
    return 'Items ($count)';
  }

  @override
  String priceEach(String price) {
    return '\$$price each';
  }

  @override
  String get rating => 'Rating';

  @override
  String get description => 'Description';

  @override
  String get category => 'Category';

  @override
  String get quantity => 'Quantity';

  @override
  String get retry => 'Retry';

  @override
  String get errorLoadingProducts => 'Error loading products';

  @override
  String get pullToRefresh => 'Pull to refresh';
}
