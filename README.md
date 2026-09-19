# Ukraine Alarm Map Clean 1.4.0

Home Assistant app with Ingress sidebar panel for the official Ukraine Alarm Map.

- Uses Home Assistant Ingress; no public port forwarding is required.
- Keeps the interactive official map and its legend.
- Hides the site header, threat list, statistics, banner and other page chrome.
- Proxies the official Centrifugo WebSocket through the same Ingress session so live alarm updates continue to work.
- The sidebar panel is enabled automatically by the app.


Version 1.4.0: fixes the Ingress WebSocket URL. The browser now builds the WebSocket endpoint from the actual Home Assistant Ingress path (including the HA port), while nginx proxies that connection to the official Centrifugo endpoint. The previous version generated an invalid browser URL because `$host` omitted the HA port. Also removes the harmless duplicate MIME warning.


Version 1.4.11: lets the official site control the Threats button positioning/animation instead of overriding its geometry; refreshes the Ingress sidebar registration on start and removes the panel on a normal stop. restores the original interactive Threats panel behavior. The `.general-aside` is no longer forcibly hidden, so the site's own JavaScript can open/close it when the arrow is clicked.


## 1.4.11
- Lets the original `.general-button` CSS control its position and slide animation.
- Refreshes the sidebar registration on startup so `panel_icon: mdi:map-legend` is re-applied.
- Unregisters the sidebar panel on a normal add-on stop, preventing a dead Ingress error panel.

## 1.4.8
- Restored the original `.info` layout inside region popups by scoping the custom legend positioning to `.map > .info`.
- Sidebar panel icon is `mdi:map-legend`.
