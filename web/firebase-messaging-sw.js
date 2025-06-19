importScripts("https://www.gstatic.com/firebasejs/11.9.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/11.9.0/firebase-messaging-compat.js");
importScripts('firebase-config.js');


firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();


// Handle background messages
messaging.onBackgroundMessage(async (payload) => {
  console.log('Received background message:', payload);

  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: '/icons/Icon-192.png',
    badge: '/icons/Icon-192.png',
    data: payload.data,
    click_action: payload.notification.click_action,
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});

self.addEventListener('notificationclick', function (event) {
  console.log('Click background notification:', event.notification);
  try {
    const data = event.notification?.data || {};
    const targetUrl = data.url || '/';
  
    event.notification.close();
  
    event.waitUntil(
      clients.matchAll({ type: 'window', includeUncontrolled: true }).then((clientList) => {
        for (const client of clientList) {
          if ('focus' in client) {
            return client.focus();
          }
        }
        return clients.openWindow(targetUrl);
      })
    );
  } catch (e) { 
    console.error('posted message');
  }
});