// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of(context, S);
  }

  /// `Mini E-Commerce`
  String get appTitle {
    return Intl.message(
      'Mini E-Commerce',
      name: 'appTitle',
      desc: 'The title of the application',
      args: [],
    );
  }

  /// `Product Details`
  String get productDetails {
    return Intl.message(
      'Product Details',
      name: 'productDetails',
      desc: 'Title for product details page',
      args: [],
    );
  }

  /// `Shopping Cart`
  String get shoppingCart {
    return Intl.message(
      'Shopping Cart',
      name: 'shoppingCart',
      desc: 'Title for shopping cart page',
      args: [],
    );
  }

  /// `Add to Cart`
  String get addToCart {
    return Intl.message(
      'Add to Cart',
      name: 'addToCart',
      desc: 'Button text to add item to cart',
      args: [],
    );
  }

  /// `Added to cart!`
  String get addedToCart {
    return Intl.message(
      'Added to cart!',
      name: 'addedToCart',
      desc: 'Message when item is added to cart',
      args: [],
    );
  }

  /// `Clear All`
  String get clearAll {
    return Intl.message(
      'Clear All',
      name: 'clearAll',
      desc: 'Button text to clear all items from cart',
      args: [],
    );
  }

  /// `Clear Cart`
  String get clearCart {
    return Intl.message(
      'Clear Cart',
      name: 'clearCart',
      desc: 'Dialog title for clearing cart',
      args: [],
    );
  }

  /// `Are you sure you want to remove all items from your cart?`
  String get clearCartConfirmation {
    return Intl.message(
      'Are you sure you want to remove all items from your cart?',
      name: 'clearCartConfirmation',
      desc: 'Confirmation message for clearing cart',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: 'Cancel button text',
      args: [],
    );
  }

  /// `Proceed to Checkout`
  String get proceedToCheckout {
    return Intl.message(
      'Proceed to Checkout',
      name: 'proceedToCheckout',
      desc: 'Button text for proceeding to checkout',
      args: [],
    );
  }

  /// `Continue Shopping`
  String get continueShopping {
    return Intl.message(
      'Continue Shopping',
      name: 'continueShopping',
      desc: 'Button text to continue shopping',
      args: [],
    );
  }

  /// `Your cart is empty`
  String get yourCartIsEmpty {
    return Intl.message(
      'Your cart is empty',
      name: 'yourCartIsEmpty',
      desc: 'Message when cart is empty',
      args: [],
    );
  }

  /// `Add some products to get started`
  String get addSomeProducts {
    return Intl.message(
      'Add some products to get started',
      name: 'addSomeProducts',
      desc: 'Subtitle when cart is empty',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: 'Total label', args: []);
  }

  /// `Items ({count})`
  String items(int count) {
    return Intl.message(
      'Items ($count)',
      name: 'items',
      desc: 'Items count label',
      args: [count],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: 'OK button text', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
