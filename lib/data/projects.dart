import '../models/project_model.dart';

const _images = 'https://albinpk.github.io/assets/assets/images';

const _whatsAppImageMobile = '$_images/whatsapp/mobile';
const _whatsAppImageDesktop = '$_images/whatsapp/desktop';
const _bookMyShowImages = '$_images/bookmyshow';
const _todoImages = '$_images/todo';
const _portfolioImages = '$_images/portfolio';

const List<Project> projects = [
  // WhatsApp
  Project(
    title: 'WhatsApp UI',
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
    platforms: {Platforms.mobile, Platforms.desktop, Platforms.web},
    screenshots: [
      '$_whatsAppImageMobile/chat-room.gif',
      '$_whatsAppImageMobile/home.gif',
      '$_whatsAppImageMobile/settings.gif',
      '$_whatsAppImageMobile/status.gif',
      '$_whatsAppImageMobile/user-profile.gif',
      '$_whatsAppImageDesktop/home-dark.png',
      '$_whatsAppImageDesktop/home-light.png',
      '$_whatsAppImageDesktop/chat-room-dark.png',
      '$_whatsAppImageDesktop/chat-room-light.png',
      '$_whatsAppImageDesktop/new-chat-dark.png',
      '$_whatsAppImageDesktop/new-chat-light.png',
      '$_whatsAppImageDesktop/profile-settings-dark.png',
      '$_whatsAppImageDesktop/responsive-large.png',
      '$_whatsAppImageDesktop/responsive-small.png',
      '$_whatsAppImageDesktop/settings-dark.png',
      '$_whatsAppImageDesktop/status-list-dark.png',
      '$_whatsAppImageDesktop/status-screen-1.png',
      '$_whatsAppImageDesktop/status-screen-2.png',
      '$_whatsAppImageDesktop/theme-settings-light.png',
      '$_whatsAppImageDesktop/user-profile-dark.png',
      '$_whatsAppImageDesktop/user-profile-light.png',
    ],
    repoUrl:
        'https://github.com/albinpk/flutter-clones/tree/master/000-whatsapp#readme',
    liveDemoUrl: 'https://albinpk.github.io/flutter-clones',
  ),

  // BookMyShow
  Project(
    title: 'BookMyShow Tracker',
    description: 'When ticket sales for a particular movie or movies '
        'on bookmyshow.com begin, BookMyShow Tracker will let you know.',
    features: [
      Feature('Add a new movie to the movie list.'),
      Feature('Accept sharing from the official BookMyShow app.'),
      Feature('Extract the movie title from the URL automatically.'),
      Feature('Remove a movie from the list of movies.'),
      Feature('Turn tracking on or off for a specific movie.'),
      Feature('Turn off tracking for all movies.'),
      Feature('Change tracking frequency (interval).'),
      Feature('Display the last time it was checked.'),
      Feature('Visit a specific movie page on the official BookMyShow app.'),
    ],
    platforms: {Platforms.mobile},
    screenshots: [
      '$_bookMyShowImages/bookmyshow.gif',
      '$_bookMyShowImages/movie-form.png',
      '$_bookMyShowImages/bookmyshow.gif.png',
      '$_bookMyShowImages/sidebar.png',
    ],
    repoUrl:
        'https://github.com/albinpk/flutter-apps/tree/master/001-bookmyshow_tracker#readme',
  ),

  // Todo
  Project(
    title: 'Todo',
    description: 'A simple todo app in flutter.',
    features: [
      Feature('Create todo with description'),
      Feature('Mark completed todo'),
      Feature('Update todo'),
      Feature('Delete todo'),
      Feature('Dark theme support'),
      Feature('Responsive UI'),
    ],
    platforms: {Platforms.mobile, Platforms.desktop, Platforms.web},
    screenshots: [
      '$_todoImages/android/todo-home-page.gif',
      '$_todoImages/android/todo-form.png',
      '$_todoImages/android/todo-home-page.gif.png',
      '$_todoImages/android/todo-dark-mode.png',
      '$_todoImages/android/todo-swipe.png',
      '$_todoImages/linux/todo-home.png',
      '$_todoImages/linux/todo-home-resize.png',
      '$_todoImages/web/todo-home.png',
    ],
    repoUrl:
        'https://github.com/albinpk/flutter-apps/tree/master/000-todo#readme',
  ),

  // Portfolio
  Project(
    title: 'Portfolio',
    description: 'Personal portfolio (this website) hosted on Github Pages',
    features: [
      Feature('About me'),
      Feature('My projects', features: [
        Feature('Project details'),
        Feature('Project screenshots'),
        Feature('Project repository link'),
      ]),
    ],
    platforms: {Platforms.web},
    screenshots: [
      '$_portfolioImages/portfolio-theme-ripple.png',
      '$_portfolioImages/portfolio-home-light.png',
      '$_portfolioImages/portfolio-home-dark.png',
      '$_portfolioImages/portfolio-home-hover.png',
      '$_portfolioImages/portfolio-project.png',
    ],
    repoUrl: 'https://github.com/albinpk/albinpk.github.io',
  ),
];
