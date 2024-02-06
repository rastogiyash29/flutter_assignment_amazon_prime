import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/bloc/music_bloc/music_bloc.dart';
import 'package:flutter_assignment/screens/wishlist_screen.dart';
import 'package:flutter_assignment/widgets/music_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc/home_bloc.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';
import 'home_screen.dart';

class AmazonMusicScreen extends StatefulWidget {
  const AmazonMusicScreen({super.key});

  static const routeName = '/amazon_music';

  @override
  State<AmazonMusicScreen> createState() => _AmazonMusicScreenState();
}

class _AmazonMusicScreenState extends State<AmazonMusicScreen> {
  late MusicPlayerBloc musicPlayerBloc;

  AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    musicPlayerBloc=context.read<MusicPlayerBloc>();
    // musicPlayerBloc.add(MusicPlayerLoadMusicEvent());
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
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
              'Amazon Music ',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500, color: Colors.teal.shade900),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popUntil(context,
                  (route) => route.settings.name == HomeScreen.routeName);
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
        child: BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
          builder: (context, state) {
            bool disableButton = state.music_files.isEmpty;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: IconButton(
                        iconSize: w * 0.18,
                        onPressed: disableButton ||state.activeIndex==-1 ? null : () {
                          musicPlayerBloc.add(MusicPlayerPrevEvent());
                        },
                        icon: Icon(
                          Icons.skip_previous,
                          color: disableButton ||state.activeIndex==-1? Colors.grey : Colors.indigo,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        iconSize: w * 0.25,
                        onPressed: disableButton ? null : () {
                          musicPlayerBloc.add(MusicPlayerTogglePlayPauseButtonEvent());
                        },
                        icon: Icon(
                          state.activeIndex==-1?Icons.play_arrow: state.playing?Icons.pause_circle: Icons.play_circle,
                          color: disableButton ? Colors.grey : Colors.indigo,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        iconSize: w * 0.18,
                        onPressed: disableButton ||state.activeIndex==-1? null : () {
                          musicPlayerBloc.add(MusicPlayerNextEvent());
                        },
                        icon: Icon(
                          Icons.skip_next,
                          color: disableButton ||state.activeIndex==-1? Colors.grey : Colors.indigo,
                        ),
                      ),
                    ),
                  ],
                ),
                BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
                  builder: (context, state) {
                    return Expanded(
                      child: Container(
                        color: Colors.grey.shade200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: state.music_files
                              .map((e) => MusicTile(
                            isActive: state.activeIndex==state.music_files.indexOf(e),
                                    musicFile: e,
                                    index: state.music_files.indexOf(e),
                                  ))
                              .toList(),
                        ),
                      ),
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
