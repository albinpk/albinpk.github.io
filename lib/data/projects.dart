import '../models/project_model.dart';

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
    screenshots: [],
    repoUrl:
        'https://github.com/albinpk/flutter-clones/tree/master/000-whatsapp#readme',
  ),
  Project(
    title: 'BookMyShow Tracker',
    description: 'When ticket sales for a particular movie or movies'
        'on bookmyshow.com begin, BookMyShow Tracker will let you know.',
    features: [],
    screenshots: [],
    repoUrl:
        'https://github.com/albinpk/flutter-apps/tree/master/001-bookmyshow_tracker#readme',
  ),
];
