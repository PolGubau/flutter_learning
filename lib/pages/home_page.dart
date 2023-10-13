import 'package:flutter/material.dart';
import 'package:flutter_application_1/data_manager.dart';

class HomePage extends StatelessWidget {
  final DataManager dataManager;
  const HomePage({super.key, required this.dataManager});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: const [
        Offer(
          title: 'Free Shipping',
          description: 'Free shipping on all orders',
        ),
        Offer(
          title: 'Free Shipping2',
          description: 'Free shipping on all orders 2',
        ),
        Offer(
          title: 'Free Shipping2',
          description: 'Free shipping on all orders 2',
        ),
        Offer(
          title: 'Free Shipping2',
          description: 'Free shipping on all orders 2',
        ),
        Offer(
          title: 'Free Shipping2',
          description: 'Free shipping on all orders 2',
        )
      ],
    );
  }
}

class Offer extends StatelessWidget {
  final String title;
  final String description;

  // Constructor
  const Offer({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        color: Colors.amber.shade100,
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/background.png'),
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineLarge,
                )),
                Center(child: Text(description)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
