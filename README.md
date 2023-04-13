#  When backgrounding the SwiftUI app, the colorScheme environment briefly changes to .dark and back to .light, causing two unnecessary re-renders of the whole app

FB12116367

To reproduce, run the sample minimal project on iOS 16.4: https://github.com/tkafka/swiftUI-bug-colorSchemeWhenBackgroundingApp/blob/main/testColorSchemeWhenBackgrounding/ContentView.swift

When the app goes to background, the colorScheme environment (@Environment(\.colorScheme) var colorScheme) briefly changes to .dark and then back to .light, causing two re-renders of the whole app. In my case, I render computationaly heavy chart (cached into UIImage), which depends on current color scheme, the result of the current behavior is that I am doing two unnecesary re-renders when the user backgrounds the app.

When the app starts, the log is:
 ```
 body(): colorScheme=light
 body(): colorScheme=light
 onChange(of: scenePhase): scenePhase=active, colorScheme=light
 ```
 
 Then, put the app to the background (just swipe up to open homescreen):
 ```
 body(): colorScheme=light
 onChange(of: scenePhase): scenePhase=inactive, colorScheme=light
 ```
 ⚠️ here, the body redraws, because the colorScheme changes to dark
 ```
 body(): colorScheme=dark
 onChange(of: scenePhase): scenePhase=background, colorScheme=light
 ```
  ⚠️ and another redraw, as the colorScheme changes back to light
 ```
 body(): colorScheme=light
```
 
 Just to complete the image, this gets logged when foregrounding the app again:
 ```
 body(): colorScheme=light
 onChange(of: scenePhase): scenePhase=inactive, colorScheme=light
 body(): colorScheme=light
 onChange(of: scenePhase): scenePhase=active, colorScheme=light
```

