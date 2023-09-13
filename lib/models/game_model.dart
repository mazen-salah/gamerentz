enum Platform { pc, ps4, ps5, xbox, ios, android, nintendo }

Platform setPlatformFromString(String platformString) {
  switch (platformString) {
    case 'pc':
      return Platform.pc;
    case 'ps4':
      return Platform.ps4;
    case 'ps5':
      return Platform.ps5;
    case 'xbox':
      return Platform.xbox;
    case 'ios':
      return Platform.ios;
    case 'android':
      return Platform.android;
    case 'nintendo':
      return Platform.nintendo;
    default:
      return Platform.ps4;
  }
}

class Game {
  final String id;
  final String title;
  final String imageUrl;
  final String coverUrl;
  final String description;
  final List<dynamic> screenshots;
  final Platform platform;

  Game({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.coverUrl,
    required this.description,
    required this.screenshots,
    required this.platform,
  });
}
