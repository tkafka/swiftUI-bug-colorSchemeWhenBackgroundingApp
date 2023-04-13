import SwiftUI

/**
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
 // here, the body redraws, because the colorScheme changes to dark
 body(): colorScheme=dark
 onChange(of: scenePhase): scenePhase=background, colorScheme=light
 // and another redraw, as the colorScheme changes back to light
 body(): colorScheme=light
```
 
 Just to complete the image, this gets logged when foregrounding the app again:
 ```
 body(): colorScheme=light
 onChange(of: scenePhase): scenePhase=inactive, colorScheme=light
 body(): colorScheme=light
 onChange(of: scenePhase): scenePhase=active, colorScheme=light
```
 
 */

struct ContentView: View {
	@Environment(\.colorScheme) var colorScheme
	@Environment(\.scenePhase) var scenePhase

	var body: some View {
		let _ = print("body(): colorScheme=\(colorScheme)")
		
		VStack {
			Image(systemName: "globe")
				.imageScale(.large)
				.foregroundColor(.accentColor)
			Text("Hello, world!")
		}
		.padding()
		.onChange(of: scenePhase) { newScenePhase in
			print("onChange(of: scenePhase): scenePhase=\(newScenePhase), colorScheme=\(colorScheme)")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
