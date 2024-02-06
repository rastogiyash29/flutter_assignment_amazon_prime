import 'package:flutter/material.dart';
import 'package:flutter_assignment/bloc/home_bloc/home_bloc.dart';
import 'package:flutter_assignment/bloc/music_bloc/music_bloc.dart';
import 'package:flutter_assignment/screens/amazon_music_screen.dart';
import 'package:flutter_assignment/screens/cart_screen.dart';
import 'package:flutter_assignment/screens/enquiry_form_screen.dart';
import 'package:flutter_assignment/screens/home_screen.dart';
import 'package:flutter_assignment/screens/splash_screen.dart';
import 'package:flutter_assignment/screens/wishlist_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(),
          ),
          BlocProvider<MusicPlayerBloc>(
            create: (context) => MusicPlayerBloc(),
          ),
        ],
        child: MaterialApp(
          initialRoute: SplashScreen.routeName,
          routes: {
            HomeScreen.routeName: (context) => HomeScreen(),
            AmazonMusicScreen.routeName: (context) => AmazonMusicScreen(),
            CartScreen.routeName: (context) => CartScreen(),
            WishListScreen.routeName: (context) => WishListScreen(),
            SplashScreen.routeName: (context) => SplashScreen(),
            EnquiryForm.routeName: (context) => EnquiryForm(),
          },
          title: 'ChatGPT',
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              color: Colors.white,
              iconTheme: IconThemeData(size: 30.0, color: Colors.black),
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 17.0),
            ),
            iconTheme: iconThemeData.copyWith(color: Colors.black),
            iconButtonTheme: IconButtonThemeData(
              style: ButtonStyle(
                  iconColor: MaterialStateProperty.all(Colors.black),
                  shadowColor: MaterialStateProperty.all(Colors.grey)),
            ),
            scaffoldBackgroundColor: Colors.white,
            textTheme: const TextTheme(
              bodyMedium: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
              bodySmall: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              bodyLarge: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              titleMedium: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.w400,
              ),
            ),
            hintColor: Colors.grey,
            inputDecorationTheme: inputDecorationTheme,
            drawerTheme:
                drawerThemeData.copyWith(backgroundColor: Colors.white),
          ),
          darkTheme: ThemeData(
            appBarTheme: appBarTheme,
            iconTheme: iconThemeData,
            iconButtonTheme: IconButtonThemeData(
              style: ButtonStyle(
                  iconColor: MaterialStateProperty.all(Colors.white),
                  shadowColor: MaterialStateProperty.all(Colors.white)),
            ),
            scaffoldBackgroundColor: Colors.black,
            textTheme: textTheme,
            hintColor: Colors.grey,
            inputDecorationTheme: inputDecorationTheme,
            drawerTheme: drawerThemeData,
          ),
          // home: HomeScreen(),
        ));
  }

  TextTheme textTheme = const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.white,
      fontSize: 17,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontSize: 28,
      fontWeight: FontWeight.w400,
    ),
  );

  IconThemeData iconThemeData = IconThemeData(color: Colors.white);

  InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.grey),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 30),
      focusColor: Colors.grey,
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.grey),
      ),
      hintStyle: TextStyle(color: Colors.grey),
      suffixIconColor: Colors.grey);

  AppBarTheme appBarTheme = AppBarTheme(
    color: Colors.black,
    iconTheme: IconThemeData(size: 30.0, color: Colors.white),
    titleTextStyle: TextStyle(
        color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17.0),
  );

  DrawerThemeData drawerThemeData = DrawerThemeData(
    backgroundColor: Colors.black,
    scrimColor: Colors.grey.withOpacity(0.18),
  );
}
