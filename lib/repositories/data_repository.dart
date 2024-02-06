import 'package:flutter_assignment/bloc/music_bloc/music_bloc.dart';

import '../bloc/home_bloc/home_bloc.dart';
import '../services/network_helper.dart';

class DataRepository {
  final NetworkHelper _networkHelper = NetworkHelper();

  Future<List<Product>> fetchProducts() async {
    var data = await _networkHelper.getData('https://dummyjson.com/products');
    List<Product> products =
        (data['products'] as List).map((i) => Product.fromJson(i)).toList();
    return products;
  }

  List<MusicFile> fetchMusicWithAddresses() {
    return <MusicFile>[
      MusicFile(name: 'Closer', isPlaying: false, address: 'audios/closer.mp3'),
      MusicFile(name: 'Perfect', isPlaying: false, address: 'audios/perfect.mp3'),
    ];
  }
}
