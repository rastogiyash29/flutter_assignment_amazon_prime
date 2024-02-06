import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_assignment/repositories/data_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class MusicPlayerEvent {}

final class MusicPlayerToggleSpecificMusicEvent extends MusicPlayerEvent {
  final int index;

  MusicPlayerToggleSpecificMusicEvent({required this.index});
}

final class MusicPlayerTogglePlayPauseButtonEvent extends MusicPlayerEvent {}

final class MusicPlayerNextEvent extends MusicPlayerEvent {}

final class MusicPlayerPrevEvent extends MusicPlayerEvent {}

final class MusicPlayerLoadMusicEvent extends MusicPlayerEvent {}

// music_player_bloc.dart

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  final DataRepository dataRepository = DataRepository();

  final AudioPlayer _audioPlayer = AudioPlayer();

  MusicPlayerBloc()
      : super(MusicPlayerInitalState(
            activeIndex: -1, music_files: [], playing: false)) {
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
    on<MusicPlayerTogglePlayPauseButtonEvent>((event, emit) async {
      if (state.music_files.isEmpty) {
        emit(MusicPlayerPlayingState(
            music_files: [], activeIndex: -1, playing: false));
      } else {
        if (state.activeIndex == -1) {
          await startAudioPlayer(0);
          emit(MusicPlayerPlayingState(
              music_files: playIndexedMusicFile(state.music_files, 0),
              activeIndex: 0,
              playing: true));
        } else {
          await toggleAudioPlayer();
          emit(MusicPlayerPlayingState(
              music_files: playIndexedMusicFile(
                  state.music_files, state.playing ? -1 : state.activeIndex),
              activeIndex: state.activeIndex,
              playing: !state.playing));
        }
      }
    });

    on<MusicPlayerNextEvent>((event, emit) async {
      int nextIndex = (state.activeIndex + 1) % state.music_files.length;
      await startAudioPlayer(nextIndex);
      emit(MusicPlayerPlayingState(
          playing: true,
          activeIndex: nextIndex,
          music_files: playIndexedMusicFile(state.music_files, nextIndex)));
    });

    on<MusicPlayerPrevEvent>((event, emit) async {
      int prevIndex = (state.activeIndex - 1 + state.music_files.length) %
          state.music_files.length;
      await startAudioPlayer(prevIndex);
      emit(MusicPlayerPlayingState(
          playing: true,
          activeIndex: prevIndex,
          music_files: playIndexedMusicFile(state.music_files, prevIndex)));
    });

    on<MusicPlayerToggleSpecificMusicEvent>((event, emit) async {
      if(state.activeIndex!=event.index){
        await startAudioPlayer(event.index);
      }else{
        await toggleAudioPlayer();
      }
      if (event.index < state.music_files.length && event.index > -1) {
        emit(MusicPlayerPlayingState(
            playing: state.activeIndex == event.index ? !state.playing : true,
            activeIndex: event.index,
            music_files: playIndexedMusicFile(
                state.music_files,
                state.activeIndex == event.index
                    ? state.playing
                        ? -1
                        : event.index
                    : event.index)));
      }
    });

    on<MusicPlayerLoadMusicEvent>((event, emit) async {
      var temp = dataRepository.fetchMusicWithAddresses();
      emit(MusicPlayerInitalState(
          activeIndex: -1, music_files: temp, playing: false));
    });
  }

  List<MusicFile> playIndexedMusicFile(List<MusicFile> list, int index) {
    List<MusicFile> newList = [];
    for (int i = 0; i < list.length; i++)
      newList.add(MusicFile(
          name: list[i].name, isPlaying: i == index, address: list[i].address));
    return newList;
  }

  Future<void> toggleAudioPlayer() async {
    if (_audioPlayer.state == PlayerState.playing) {
       await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }
  }

  Future<void> startAudioPlayer(int index) async {
    await _audioPlayer.stop();
    if (index != -1) {
      await _audioPlayer.play(AssetSource(state.music_files[index].address));
    }
  }

  @override
  Future<void> close() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    return super.close();
  }
}

abstract class MusicPlayerState {
  List<MusicFile> music_files = [];
  int activeIndex = -1;
  bool playing = false;

  MusicPlayerState(
      {required this.music_files,
      required this.activeIndex,
      required this.playing});
}

final class MusicPlayerInitalState extends MusicPlayerState {
  MusicPlayerInitalState(
      {required super.music_files,
      required super.activeIndex,
      required super.playing});
}

final class MusicPlayerLoadingState extends MusicPlayerState {
  MusicPlayerLoadingState(
      {required super.music_files,
      required super.activeIndex,
      required super.playing});
}

final class MusicPlayerPlayingState extends MusicPlayerState {
  MusicPlayerPlayingState(
      {required super.music_files,
      required super.activeIndex,
      required super.playing});
}

final class MusicFile {
  final String address;
  final String name;
  final bool isPlaying;

  MusicFile(
      {required this.name, required this.isPlaying, required this.address});
}
