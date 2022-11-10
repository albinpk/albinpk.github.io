'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "ca77fbafdf73afa5b33e70ef24271c5f",
"/": "ca77fbafdf73afa5b33e70ef24271c5f",
"assets/assets/icons/linkedin.svg": "4b5476b5d6ab2c7296f7fb721e52b5df",
"assets/assets/icons/envelope-solid.svg": "5bfa2284f5b4d8260e59dda2c40d7a02",
"assets/assets/icons/github.svg": "aff72238a3d98e8327925dbaa5ab54dd",
"assets/assets/images/whatsapp/desktop/user-profile-light.png": "69e02357d5fa56558c0bf29210c971be",
"assets/assets/images/whatsapp/desktop/new-chat-light.png": "c3a172760c85530386e6507ee6f4929d",
"assets/assets/images/whatsapp/desktop/theme-settings-light.png": "3864e5287a31dcd449ae351a80a60cbb",
"assets/assets/images/whatsapp/desktop/chat-room-dark.png": "63645e25078a5a511da9141d6c11a325",
"assets/assets/images/whatsapp/desktop/home-light.png": "3e0d8679026516c7d7c31c13835056d4",
"assets/assets/images/whatsapp/desktop/responsive-large.png": "4f03b192c1b71312daffe00990d18e4b",
"assets/assets/images/whatsapp/desktop/status-screen-2.png": "44f1ae1b4f1fae9935571f29d8162fed",
"assets/assets/images/whatsapp/desktop/profile-settings-dark.png": "1b592e87805e445b8c2eca7bc3ef5c9f",
"assets/assets/images/whatsapp/desktop/home-dark.png": "9cedf3a90652377c260335c39be63836",
"assets/assets/images/whatsapp/desktop/responsive-small.png": "4dc4a3970aa8fb77470dbdc1df92497b",
"assets/assets/images/whatsapp/desktop/chat-room-light.png": "a7c740292a74df583fb3e9c2460eb5a9",
"assets/assets/images/whatsapp/desktop/settings-dark.png": "2a417fd1fac69f0af0de77b232d3ee32",
"assets/assets/images/whatsapp/desktop/user-profile-dark.png": "9061b7c02fad82a7a6985ac1ae30e3c9",
"assets/assets/images/whatsapp/desktop/status-screen-1.png": "12fa71123142235ee1099ec8b7994e4b",
"assets/assets/images/whatsapp/desktop/status-list-dark.png": "012a3abdc0d589b01a36ed426b8091f8",
"assets/assets/images/whatsapp/desktop/new-chat-dark.png": "ec3c0d356809fcbce6a8e84353a83cb9",
"assets/assets/images/whatsapp/mobile/settings.gif": "a674d6b756b7a37fbf1a28bf2d81ae8e",
"assets/assets/images/whatsapp/mobile/user-profile.gif": "0faf8d8a110bf79403b3e9ec481210fa",
"assets/assets/images/whatsapp/mobile/chat-room.gif.png": "6253256774f5ddbeb6b4ff0bdf385406",
"assets/assets/images/whatsapp/mobile/home.gif": "a68557f4a5671dc916507675966e4d6c",
"assets/assets/images/whatsapp/mobile/status.gif.png": "ac7ad22887eef247e75eb4328223f15c",
"assets/assets/images/whatsapp/mobile/settings.gif.png": "75d554f7f8825e59aecba22746de4284",
"assets/assets/images/whatsapp/mobile/user-profile.gif.png": "244328ef1a70dcd4ca9a0bac8d7af82a",
"assets/assets/images/whatsapp/mobile/home.gif.png": "73644026de7f6db199072e2b21da5257",
"assets/assets/images/whatsapp/mobile/status.gif": "bfe7e8d789ad52d6109a9cf9bdd3fc39",
"assets/assets/images/whatsapp/mobile/chat-room.gif": "52f0873dd8346ee8849fc5ca4c4a66c4",
"assets/assets/images/todo/android/todo-home-page.gif.png": "b1a6362a7d44a62f0223dda5d619313f",
"assets/assets/images/todo/android/todo-dark-mode.png": "bcecaab88b8e905af3785757c132012e",
"assets/assets/images/todo/android/todo-home-page.gif": "4a5115c535d037446fe57b2631197753",
"assets/assets/images/todo/android/todo-form.png": "782ef22528614f330913c2aca958eebc",
"assets/assets/images/todo/android/todo-swipe.png": "2602f3bef8dd1af3cbd3b33c7b695ef9",
"assets/assets/images/todo/linux/todo-home-resize.png": "59d7d3f953e8cabf0112c50e0ad2f093",
"assets/assets/images/todo/linux/todo-home.png": "be8cbcfbecab77abbc40205120b26708",
"assets/assets/images/todo/web/todo-home.png": "551c0fb7ed11cb3d9b2fcf4a284828a2",
"assets/assets/images/bookmyshow/movie-form.png": "a52eb9949e32dda82e80ce77175065fe",
"assets/assets/images/bookmyshow/bookmyshow.gif.png": "115eccde596b38388dc118c21bcdd13c",
"assets/assets/images/bookmyshow/bookmyshow.gif": "7a9d5b37139f385fa8f8de28ced36b11",
"assets/assets/images/bookmyshow/sidebar.png": "5ad8023094ad2cdee57872767000d092",
"assets/assets/images/portfolio/portfolio-home-light.png": "92928f4dc976aadb375f7ec5bec82799",
"assets/assets/images/portfolio/portfolio-project.png": "eb7c21e70f636588eb79c472521b6dcd",
"assets/assets/images/portfolio/portfolio-theme-ripple.png": "142e2eaf832e9367e36dc58415475a2a",
"assets/assets/images/portfolio/portfolio-home-hover.png": "9401ab0e97454854342d2f24487e89f7",
"assets/assets/images/portfolio/portfolio-home-dark.png": "01f39917471861b5434f6ce568d4a3a1",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/NOTICES": "c00fbed3ae84df0e08ea4b7bb3730462",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/AssetManifest.json": "e48fd38dc9df8e4db1a6600c4a210c6e",
"assets/shaders/ink_sparkle.frag": "6ddca61f03944b33ce9eb6974f399db8",
"version.json": "7e7dfee7a48944c2f5c04cbf7c120d5b",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.js": "8a8de792c973deb54779ad62e5e3bb6d",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"manifest.json": "0c9c66ee82f16d8b9133e77aec7e2ed5"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
