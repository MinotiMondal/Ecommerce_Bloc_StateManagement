// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for the en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(count) => "Items (${count})";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addToCart": MessageLookupByLibrary.simpleMessage("Add to Cart"),
    "addedToCart": MessageLookupByLibrary.simpleMessage("Added to cart!"),
    "addSomeProducts": MessageLookupByLibrary.simpleMessage(
      "Add some products to get started",
    ),
    "appTitle": MessageLookupByLibrary.simpleMessage("Mini E-Commerce"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "clearAll": MessageLookupByLibrary.simpleMessage("Clear All"),
    "clearCart": MessageLookupByLibrary.simpleMessage("Clear Cart"),
    "clearCartConfirmation": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to remove all items from your cart?",
    ),
    "continueShopping": MessageLookupByLibrary.simpleMessage(
      "Continue Shopping",
    ),
    "items": m0,
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "proceedToCheckout": MessageLookupByLibrary.simpleMessage(
      "Proceed to Checkout",
    ),
    "productDetails": MessageLookupByLibrary.simpleMessage("Product Details"),
    "shoppingCart": MessageLookupByLibrary.simpleMessage("Shopping Cart"),
    "total": MessageLookupByLibrary.simpleMessage("Total"),
    "yourCartIsEmpty": MessageLookupByLibrary.simpleMessage(
      "Your cart is empty",
    ),
  };
}
