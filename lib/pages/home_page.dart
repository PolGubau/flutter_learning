import 'package:flutter/material.dart';
import 'package:trackup/data_manager.dart';
import 'package:trackup/data_model.dart';

class OrderAlert extends StatelessWidget {
  const OrderAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Your Order"),
      content: const Text("Your order is being prepared. Thanks!"),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'))
      ],
    );
  }
}

class OrderItem extends StatelessWidget {
  final ItemsInCart item;
  final Function onRemove;
  const OrderItem({Key? key, required this.item, required this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("${item.quantity}x"),
                )),
            Expanded(
                flex: 6,
                child: Text(
                  item.product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
            Expanded(
                flex: 2,
                child: Text(
                    "\$${(item.product.price * item.quantity).toStringAsFixed(2)}")),
            Expanded(
                flex: 1,
                child: IconButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      onRemove(item.product);
                    },
                    icon: const Icon(Icons.delete)))
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final DataManager dataManager;
  const HomePage({Key? key, required this.dataManager}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    if (widget.dataManager.cart?.isEmpty ?? true) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text("Your order is empty"),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: widget.dataManager.cart?.length,
                itemBuilder: (context, index) {
                  var item = widget.dataManager.cart![index];
                  return OrderItem(
                      item: item,
                      onRemove: (product) {
                        setState(() {
                          widget.dataManager.cartRemove(product);
                        });
                      });
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Total: \$${widget.dataManager.cardTotal().toStringAsFixed(2)}"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(foregroundColor: Colors.green),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => const OrderAlert());
                      setState(() {
                        // we update the cart within setState so the current widget will get re-rendered
                        widget.dataManager.cartClear();
                      });
                    },
                    child: const Text("Send Order")),
              ),
            )
          ],
        ),
      );
    }
  }
}
