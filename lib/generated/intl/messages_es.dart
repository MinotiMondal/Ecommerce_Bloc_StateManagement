// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for the es locale. All the
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
  String get localeName => 'es';

  static String m0(count) => "Artículos (${count})";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addToCart": MessageLookupByLibrary.simpleMessage("Agregar al Carrito"),
    "addedToCart": MessageLookupByLibrary.simpleMessage(
      "¡Agregado al carrito!",
    ),
    "addSomeProducts": MessageLookupByLibrary.simpleMessage(
      "Agrega algunos productos para comenzar",
    ),
    "appTitle": MessageLookupByLibrary.simpleMessage("Mini E-Commerce"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "clearAll": MessageLookupByLibrary.simpleMessage("Limpiar Todo"),
    "clearCart": MessageLookupByLibrary.simpleMessage("Limpiar Carrito"),
    "clearCartConfirmation": MessageLookupByLibrary.simpleMessage(
      "¿Estás seguro de que quieres eliminar todos los artículos de tu carrito?",
    ),
    "continueShopping": MessageLookupByLibrary.simpleMessage(
      "Continuar Comprando",
    ),
    "items": m0,
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "proceedToCheckout": MessageLookupByLibrary.simpleMessage(
      "Proceder al Pago",
    ),
    "productDetails": MessageLookupByLibrary.simpleMessage(
      "Detalles del Producto",
    ),
    "shoppingCart": MessageLookupByLibrary.simpleMessage("Carrito de Compras"),
    "total": MessageLookupByLibrary.simpleMessage("Total"),
    "yourCartIsEmpty": MessageLookupByLibrary.simpleMessage(
      "Tu carrito está vacío",
    ),
  };
}
