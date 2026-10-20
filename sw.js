// Service worker : reçoit les notifications push du CRM et ouvre le CRM au clic.
self.addEventListener("install", () => self.skipWaiting());
self.addEventListener("activate", e => e.waitUntil(self.clients.claim()));

self.addEventListener("push", e => {
  let data = {};
  try { data = e.data ? e.data.json() : {}; } catch (_) {}
  e.waitUntil(self.registration.showNotification(data.title || "CRM MAXIS", {
    body: data.body || "Ouvre le CRM pour traiter la demande.",
    icon: "/android-chrome-192.png",
    badge: "/favicon-32.png",
    tag: "demande-" + (data.id || Date.now()),
    data: { url: "/" }
  }));
});

self.addEventListener("notificationclick", e => {
  e.notification.close();
  e.waitUntil(self.clients.matchAll({ type: "window", includeUncontrolled: true }).then(list => {
    const win = list.find(c => new URL(c.url).origin === self.location.origin);
    if (win) return win.focus();
    return self.clients.openWindow(e.notification.data?.url || "/");
  }));
});
