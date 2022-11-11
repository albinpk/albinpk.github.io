import '../models/project_model.dart';

const _assetsImageMobile = 'assets/images/mobile';
const _assetsImageDesktop = 'assets/images/desktop';

const List<Project> projects = [
  Project(
    title: 'WhatsApp UI clone',
    description: 'WhatsApp UI clone in Flutter.',
    features: [
      Feature('Chats', features: [
        Feature('Recent chats list (home screen)'),
        Feature('Chat room screen'),
        Feature('User profile screen (with animated user dp)'),
        Feature('Sent message (with automatic reply)'),
        Feature('Message status (pending, delivered, read,..)'),
        Feature('Chat search bar'),
      ]),
      Feature('New chat list'),
      Feature('Status', features: [
        Feature('Status list'),
        Feature('Recent and viewed updates'),
        Feature('Status screen (with animated progress bar)'),
        Feature('Status screen navigation (with tap and swipe gestures)'),
      ]),
      Feature('Settings', features: [
        Feature('Settings screen'),
        Feature('Profile settings screen'),
        Feature('Theme settings (with light and dark mode)'),
      ]),
    ],
    screenshots: [
      '$_assetsImageMobile/chat-room.gif',
      '$_assetsImageMobile/home.gif',
      '$_assetsImageMobile/settings.gif',
      '$_assetsImageMobile/status.gif',
      '$_assetsImageMobile/user-profile.gif',
      '$_assetsImageDesktop/home-dark.png',
      '$_assetsImageDesktop/home-light.png',
      '$_assetsImageDesktop/chat-room-dark.png',
      '$_assetsImageDesktop/chat-room-light.png',
      '$_assetsImageDesktop/new-chat-dark.png',
      '$_assetsImageDesktop/new-chat-light.png',
      '$_assetsImageDesktop/profile-settings-dark.png',
      '$_assetsImageDesktop/responsive-large.png',
      '$_assetsImageDesktop/responsive-small.png',
      '$_assetsImageDesktop/settings-dark.png',
      '$_assetsImageDesktop/status-list-dark.png',
      '$_assetsImageDesktop/status-screen-1.png',
      '$_assetsImageDesktop/status-screen-2.png',
      '$_assetsImageDesktop/theme-settings-light.png',
      '$_assetsImageDesktop/user-profile-dark.png',
      '$_assetsImageDesktop/user-profile-light.png',
    ],
    repoUrl:
        'https://github.com/albinpk/flutter-clones/tree/master/000-whatsapp#readme',
  ),
  Project(
    title: 'BookMyShow Tracker',
    description: 'When ticket sales for a particular movie or movies '
        'on bookmyshow.com begin, BookMyShow Tracker will let you know.',
    features: [],
    screenshots: [],
    repoUrl:
        'https://github.com/albinpk/flutter-apps/tree/master/001-bookmyshow_tracker#readme',
  ),
];
