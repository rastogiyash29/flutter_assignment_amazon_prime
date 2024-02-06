import 'package:flutter/material.dart';
import 'package:flutter_assignment/bloc/home_bloc/home_bloc.dart';
import 'package:flutter_assignment/screens/amazon_music_screen.dart';
import 'package:flutter_assignment/screens/cart_screen.dart';
import 'package:flutter_assignment/screens/enquiry_form_screen.dart';
import 'package:flutter_assignment/screens/wishlist_screen.dart';
import 'package:flutter_assignment/widgets/product_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/music_bloc/music_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MusicPlayerBloc>().add(MusicPlayerLoadMusicEvent());
    context.read<HomeBloc>().add(HomeBlocRefreshProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.music_note,
            color: Colors.indigo,
          ),
          onPressed: () {
            Navigator.pushNamed(context, AmazonMusicScreen.routeName);
          },
        ),
        elevation: 5.0,
        shadowColor: Colors.black,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Yash Shop ',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500, color: Colors.teal.shade900),
            ),
          ],
        ),
        actions: [
          BlocBuilder<HomeBloc, HomeBlocState>(
            builder: (context, state) {
              return Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, EnquiryForm.routeName);
                    },
                    icon: Icon(Icons.question_mark,color: Colors.amber,),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, WishListScreen.routeName);
                    },
                    icon: Icon(
                      state.wishListedProducts.isEmpty
                          ? Icons.favorite_border
                          : Icons.favorite,
                      color: Colors.redAccent,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  state.wishListedProducts.isNotEmpty
                      ? Text(
                          state.wishListedProducts.length.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.redAccent),
                        )
                      : SizedBox(),
                ],
              );
            },
          ),
          BlocBuilder<HomeBloc, HomeBlocState>(
            builder: (context, state) {
              return Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, CartScreen.routeName);
                    },
                    icon: Icon(
                      state.inCartProducts.isEmpty
                          ? Icons.shopping_cart_outlined
                          : Icons.shopping_cart,
                      color: Colors.deepPurple,
                    ),
                  ),
                  state.inCartProducts.isNotEmpty
                      ? Text(
                          state.inCartProducts.length.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.deepPurple),
                        )
                      : SizedBox(),
                ],
              );
            },
          ),
          SizedBox(
            width: 10.0,
          ),
        ],
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: BlocConsumer(
          bloc: context.read<HomeBloc>(),
          builder: (context, state) {
            if (state is HomeBlocInitialState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HomeBlocInternetOffState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: Image(
                    image: AssetImage(''),
                  )),
                  ElevatedButton(onPressed: () {}, child: Text('Load Again')),
                ],
              );
            } else if (state is HomeBlocLoadingSuccessState) {
              List<Product> products = state.products;
              List<Product> cartItems = state.inCartProducts;
              List<Product> wishListItems = state.wishListedProducts;
              return ListView.builder(
                itemCount: products.length,
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
                            product: products[index])),
                  );
                },
              );
            } else if (state is HomeBlocLoadingFailureState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: Image(
                    image: AssetImage(''),
                  )),
                  ElevatedButton(onPressed: () {}, child: Text('Load Again')),
                ],
              );
            } else
              return Center(
                child: Text('Some Error occurred'),
              );
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
