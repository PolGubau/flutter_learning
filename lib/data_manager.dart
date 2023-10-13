import 'package:flutter_application_1/data_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DataManager {
  List<Category>? _menu;

  List<ItemsInCart>? cart = [];

  cartAdd(Product p) {
    bool found = false;
    for (var item in cart!) {
      if (item.product.id == p.id) {
        item.quantity++;
        found = true;
        break;
      }
      if (!found) {
        cart!.add(ItemsInCart(product: p, quantity: 1));
      }
    }
  }

  cartRemove(Product p) {
    cart!.removeWhere((element) => element.product.id == p.id);
  }

  cartClear() {
    cart!.clear();
  }

  double cardTotal() {
    double total = 0;
    for (var item in cart!) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  fetchMenu() async {
    try {
      const url = 'https://firtman.github.io/coffeemasters/api/menu.json';
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        _menu = [];
        var decodedData = jsonDecode(response.body) as List<dynamic>;
        for (var json in decodedData) {
          _menu?.add(Category.fromJson(json));
        }
      } else {
        throw Exception("Error loading data");
      }
    } catch (e) {
      throw Exception("Error loading data");
    }
  }

  Future<List<Category>> getMenu() async {
    if (_menu == null) {
      await fetchMenu();
    }
    return _menu!;
  }
}
