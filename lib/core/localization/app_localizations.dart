import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    final localizations = Localizations.of(context, AppLocalizations);
    if (localizations != null) {
      print(
        'AppLocalizations.of() returning locale: ${localizations.locale.languageCode}',
      );
      return localizations;
    }
    // Fallback to English if not found
    print('AppLocalizations.of() fallback to English');
    return AppLocalizations(const Locale('en'));
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [Locale('en'), Locale('es')];

  String get appTitle {
    print('Getting appTitle for locale: ${locale.languageCode}');
    switch (locale.languageCode) {
      case 'es':
        return 'Mini E-Commerce (ES)';
      default:
        return 'Mini E-Commerce (EN)';
    }
  }

  String get productDetails {
    switch (locale.languageCode) {
      case 'es':
        return 'Detalles del Producto';
      default:
        return 'Product Details';
    }
  }

  String get shoppingCart {
    print('Getting shoppingCart for locale: ${locale.languageCode}');
    switch (locale.languageCode) {
      case 'es':
        return 'Carrito de Compras';
      default:
        return 'Shopping Cart';
    }
  }

  String get addToCart {
    print('Getting addToCart for locale: ${locale.languageCode}');
    switch (locale.languageCode) {
      case 'es':
        return 'Agregar al Carrito';
      default:
        return 'Add to Cart';
    }
  }

  String get addedToCart {
    switch (locale.languageCode) {
      case 'es':
        return '¡Agregado al carrito!';
      default:
        return 'Added to cart!';
    }
  }

  String get clearAll {
    switch (locale.languageCode) {
      case 'es':
        return 'Limpiar Todo';
      default:
        return 'Clear All';
    }
  }

  String get clearCart {
    switch (locale.languageCode) {
      case 'es':
        return 'Limpiar Carrito';
      default:
        return 'Clear Cart';
    }
  }

  String get clearCartConfirmation {
    switch (locale.languageCode) {
      case 'es':
        return '¿Estás seguro de que quieres eliminar todos los artículos de tu carrito?';
      default:
        return 'Are you sure you want to remove all items from your cart?';
    }
  }

  String get cancel {
    switch (locale.languageCode) {
      case 'es':
        return 'Cancelar';
      default:
        return 'Cancel';
    }
  }

  String get proceedToCheckout {
    switch (locale.languageCode) {
      case 'es':
        return 'Proceder al Pago';
      default:
        return 'Proceed to Checkout';
    }
  }

  String get continueShopping {
    switch (locale.languageCode) {
      case 'es':
        return 'Continuar Comprando';
      default:
        return 'Continue Shopping';
    }
  }

  String get yourCartIsEmpty {
    switch (locale.languageCode) {
      case 'es':
        return 'Tu carrito está vacío';
      default:
        return 'Your cart is empty';
    }
  }

  String get addSomeProducts {
    switch (locale.languageCode) {
      case 'es':
        return 'Agrega algunos productos para comenzar';
      default:
        return 'Add some products to get started';
    }
  }

  String get total {
    switch (locale.languageCode) {
      case 'es':
        return 'Total';
      default:
        return 'Total';
    }
  }

  String items(int count) {
    switch (locale.languageCode) {
      case 'es':
        return 'Artículos ($count)';
      default:
        return 'Items ($count)';
    }
  }

  String get ok {
    switch (locale.languageCode) {
      case 'es':
        return 'OK';
      default:
        return 'OK';
    }
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.any(
      (supportedLocale) => supportedLocale.languageCode == locale.languageCode,
    );
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return true;
  }
}
