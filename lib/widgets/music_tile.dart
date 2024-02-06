import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/music_bloc/music_bloc.dart';

class MusicTile extends StatefulWidget {
  final MusicFile musicFile;
  final int index;
  final bool isActive;

  MusicTile({required this.isActive, required this.musicFile, super.key, required this.index});

  @override
  State<MusicTile> createState() => _MusicTileState();
}

class _MusicTileState extends State<MusicTile> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0, bottom: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey),
          boxShadow: [
            BoxShadow(offset: Offset(2, 2), blurRadius: 2,color: widget.isActive?Colors.indigo: Colors.grey),
          ]),
      width: double.maxFinite,
      child: Row(
        children: [
          IconButton(
            iconSize: w / 8,
            onPressed: () {
              context.read<MusicPlayerBloc>().add(
                  MusicPlayerToggleSpecificMusicEvent(index: widget.index));
            },
            icon: Icon(
              widget.musicFile.isPlaying
                  ? Icons.pause_circle
                  : Icons.play_circle,
              color: widget.musicFile.isPlaying
                  ? Colors.indigo.shade700
                  : Colors.redAccent,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Text(
              widget.musicFile.name,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: widget.musicFile.isPlaying
                        ? Colors.indigo.shade700
                        : Colors.grey.shade900,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
