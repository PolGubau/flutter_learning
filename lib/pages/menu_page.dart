import 'package:flutter/material.dart';
import 'package:trackup/data_manager.dart';
import 'package:trackup/data_model.dart';

class MenuPage extends StatelessWidget {
  final DataManager dataManager;
  const MenuPage({super.key, required this.dataManager});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dataManager.getMenu(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
          if (snapshot.hasData) {
            var categories = snapshot.data!;

            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        categories[index].name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true, // to avoid double scroll
                      physics: const ClampingScrollPhysics(),
                      itemCount: categories[index].products.length,
                      itemBuilder: (BuildContext context, int index2) {
                        var product = categories[index].products[index2];
                        return ProductItem(
                          product: product,
                          onAddToCart: (addedProduct) {
                            dataManager.cartAdd(addedProduct);
                          },
                        );
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

class ProductItem extends StatelessWidget {
  final Product product;

  final Function onAddToCart;

  const ProductItem(
      {super.key, required this.product, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            product.imageUrl,
            width: double.infinity,
            fit: BoxFit.cover,
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Text(
                        product.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14, bottom: 14),
                      child: Text("${product.price}€"),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    onAddToCart(product);
                  },
                  child: const Text('Add to cart'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
