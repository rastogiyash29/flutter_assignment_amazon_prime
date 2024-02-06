import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc/home_bloc.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';
import 'home_screen.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  static const routeName = '/wish_list';

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 5.0,
        shadowColor: Colors.black,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'WishList',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.redAccent.shade700),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.settings.name==HomeScreen.routeName);
            },
            icon: Icon(
              Icons.home_filled,
              color: Colors.lightBlueAccent,
            ),
          ),

        ],
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: BlocConsumer<HomeBloc, HomeBlocState>(
          builder: (context, state) {
            if (state.wishListedProducts.length > 0) {
              List<Product> products = state.products;
              List<Product> cartItems = state.inCartProducts;
              List<Product> wishListItems = state.wishListedProducts;
              return ListView.builder(
                itemCount: wishListItems.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10.0),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade400,
                              offset: Offset(1, 2),
                              blurRadius: 2)
                        ]),
                    child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: ProductCard(
                            inCart: cartItems.contains(products[index]),
                            inWishList: wishListItems.contains(products[index]),
                            product: wishListItems[index])),
                  );
                },
              );
            } else {
              return Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.cyanAccent.shade100,
                            shadowColor: Colors.black,
                            elevation: 2.0 // This is the new background color
                            ),
                        label: Text(
                          'WishList is Empty,\nShop Now!',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(),
                        ),
                        icon: Icon(
                          Icons.shop,
                          size: 40,
                        ),
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.settings.name==HomeScreen.routeName);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
