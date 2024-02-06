import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/data_repository.dart';

sealed class HomeBlocEvent {}

final class HomeBlocRefreshProductsEvent extends HomeBlocEvent {}

final class HomeBlocToggleProductInWishListEvent extends HomeBlocEvent {
  final Product product;

  HomeBlocToggleProductInWishListEvent({required this.product});
}

final class HomeBlocToggleProductInCartEvent extends HomeBlocEvent {
  final Product product;

  HomeBlocToggleProductInCartEvent({required this.product});
}

class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  final DataRepository repository=DataRepository();

  HomeBloc() : super(HomeBlocInitialState()) {
    on<HomeBlocRefreshProductsEvent>((event, emit) async {
      try{
        List<Product> allProducts=await repository.fetchProducts();
        emit(HomeBlocLoadingSuccessState(products: allProducts,inCartProducts: state.inCartProducts,wishListedProducts: state.wishListedProducts));
      }catch(e){
        emit(HomeBlocLoadingFailureState(error: 'Try Again!'),);
      }
    });

    on<HomeBlocToggleProductInCartEvent>((event, emit) async {
      if (state.inCartProducts.contains(event.product)) {
        state.inCartProducts.remove(event.product);
      } else {
        state.inCartProducts.add(event.product);
      }
      // Emit new state with updated cart
      emit(HomeBlocLoadingSuccessState(products: state.products,inCartProducts: state.inCartProducts,wishListedProducts: state.wishListedProducts));
    });

    on<HomeBlocToggleProductInWishListEvent>((event, emit) async {
      if (state.wishListedProducts.contains(event.product)) {
        state.wishListedProducts.remove(event.product);
      } else {
        state.wishListedProducts.add(event.product);
      }
      // Emit new state with updated wishlist
      emit(HomeBlocLoadingSuccessState(products: state.products,inCartProducts: state.inCartProducts,wishListedProducts: state.wishListedProducts));
    });
  }
}

sealed class HomeBlocState {
  List<Product> products = [];
  List<Product> wishListedProducts = [];
  List<Product> inCartProducts = [];

  HomeBlocState();

  HomeBlocState.loadVariables(
      {required this.products,
      required this.wishListedProducts,
      required this.inCartProducts});
}

final class HomeBlocInitialState extends HomeBlocState {}

final class HomeBlocLoadingSuccessState extends HomeBlocState {
  HomeBlocLoadingSuccessState(
      {required List<Product> products,
      required List<Product> wishListedProducts,
      required List<Product> inCartProducts})
      : super.loadVariables(
            products: products,
            wishListedProducts: wishListedProducts,
            inCartProducts: inCartProducts);
}

final class HomeBlocLoadingFailureState extends HomeBlocState {
  final String error;

  HomeBlocLoadingFailureState({required this.error});
}

final class HomeBlocInternetOffState extends HomeBlocState {}

final class HomeBlocLoadingState extends HomeBlocState {}

class Product {
  int id, price, stock;
  double discountPercentage, rating;
  String title, description, brand, category, thumbnail;
  List<String> images = [];

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.discountPercentage,
      required this.rating,
      required this.stock,
      required this.brand,
      required this.category,
      required this.thumbnail,
      required this.images});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      discountPercentage: json['discountPercentage'].toDouble(),
      rating: json['rating'].toDouble(),
      stock: json['stock'],
      brand: json['brand'],
      category: json['category'],
      thumbnail: json['thumbnail'],
      images: List<String>.from(json['images'].map((x) => x)),
    );
  }
}
