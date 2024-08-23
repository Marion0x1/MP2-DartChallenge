import 'dart:math';

class Song {
  String title;
  String artist;
  int duration;

  Song(this.title, this.artist, this.duration);

  String getDetails() {
    int minutes = duration ~/ 60;
    int seconds = duration % 60;
    return '$title by $artist (${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')})';
  }
}

class Playlist {
  String name;
  List<Song> songs;

  Playlist(this.name) : songs = [];

  void addSong(Song song) {
    songs.add(song);
  }

  String getDetails() {
    String details = 'Playlist: $name\n';
    for (var song in songs) {
      details += '${song.getDetails()}\n';
    }
    return details;
  }

  int getTotalDuration() {
    return songs.fold(0, (sum, song) => sum + song.duration);
  }

  void sortByArtist() {
    songs.sort((a, b) => a.artist.compareTo(b.artist));
  }
}

class MusicFestival {
  String name;
  List<Playlist> playlists;

  MusicFestival(this.name) : playlists = [];

  void addPlaylist(Playlist playlist) {
    playlists.add(playlist);
  }

  String getDetails() {
    String details = 'Total Festival Duration: ${getTotalDuration()} seconds\n\n';
    return details;
  }

  int getTotalDuration() {
    return playlists.fold(0, (sum, playlist) => sum + playlist.getTotalDuration());
  }

  String getRandomSongs() {
    var random = Random();
    String details = 'Random Songs:\n';

    for (var playlist in playlists) {
      if (playlist.songs.isNotEmpty) {
        var randomSong = playlist.songs[random.nextInt(playlist.songs.length)];
        details += '${playlist.name} Stage: ${randomSong.getDetails()}\n';
      }
    }

    return details;
  }

  String getMainStageSortedByArtist() {
    var mainStagePlaylist = playlists.firstWhere((playlist) => playlist.name == 'Main Stage', orElse: () => Playlist('Main Stage'));

    mainStagePlaylist.sortByArtist();

    return 'Main Stage playlist sorted by artist:\n${mainStagePlaylist.getDetails()}';
  }
}

void main() {

  var song1 = Song('Muli', 'Ace Banzuelo', 275);
  var song2 = Song('Gusto Ko Nang Bumitaw', 'Morissette', 259);
  var song3 = Song('Pagsamo', 'Arthur Nery', 242);
  var song4 = Song('Ikaw Lang', 'NOBITA', 270);
  var song5 = Song('Paubaya', 'Moira Dela Torre', 276);
  var song6 = Song('Binibini', 'Zack Tabudlo', 235);
  var song7 = Song('Sigurado', 'Zack Tabudlo', 250);

  var mainStage = Playlist('Main Stage');
  mainStage.addSong(song1);
  mainStage.addSong(song4);
  mainStage.addSong(song5);
  mainStage.addSong(song6);
  mainStage.addSong(song7);

  var indieStage = Playlist('Indie Stage');
  indieStage.addSong(song2);
  indieStage.addSong(song3);

  var electronicStage = Playlist('Electronic Stage');
  electronicStage.addSong(song7);

  var festival = MusicFestival('OPM Music Festival');
  festival.addPlaylist(mainStage);
  festival.addPlaylist(indieStage);
  festival.addPlaylist(electronicStage);

  print(festival.getDetails());
  print(festival.getRandomSongs());
  print(festival.getMainStageSortedByArtist());
}
