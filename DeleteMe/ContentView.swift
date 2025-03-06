//
//  ContentView.swift
//  DeleteMe
//
//  Created by Damian Jardim on 3/4/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack{
            VStack{
                NavigationLink("Show Detail View"){
                    DetailView()
                }
                
                NavigationLink("Settings View"){
                    SettingsView()
                }
                
                NavigationLink("Ex1"){
                    Ex1()
                }
                
                NavigationLink("ButtonViewExamples"){
                    ButtonViewExamples()
                }
                
                
                
                
                Text("")
            }
            .navigationTitle("Navigation")
        }
    }
}

struct Ex1: View{
    
    @State private var scaleAmount = 1.0
    let scaleIncrement = 0.1
    let maxScaleAmount = 1.5
    let minScaleAmount = 0.5
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack(spacing: 20.0){
                
                Text("John Doe")
                    .fontWeight(.bold)
                    .italic()
                    .shadow(color: .gray.opacity(0.5), radius: 3, x: 2, y: 2)
                
                Spacer()
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200, alignment: Alignment.center)
                    .foregroundStyle(.yellow)
                    .scaleEffect(scaleAmount)
                
                Spacer()
                
                HStack(spacing: 15) {
                    Button("Increase") {
                        scaleAmount += scaleIncrement
                    }
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity) // Each button takes equal space
                    
                    Button("Decrease") {
                        if scaleAmount > 0.5 {
                            scaleAmount -= scaleIncrement
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity) // Each button takes equal space
                }.border(.red)
                
                
            }
            
        }
    }
}

/***********************************************************************************/

struct ProfileHeader: View{
    var body: some View{
        Text("ProfileHeader")
    }
}

struct DetailView: View{
    @EnvironmentObject var userData:UserData
    
    var body: some View {
        Text("Detail View - name: \(userData.name)")
    }
}

struct ButtonViewExamples: View {
    var body: some View {
        VStack{
            HStack {
                Button {
                    print("button clicked")
                } label: {
                    Text("increase")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                
                Button {
                    print("button clicked")
                } label: {
                    Text("decrease")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }.padding()
        }
    }
}

struct ButtonViewExamples2: View {
    var body: some View {
        VStack {
            HStack(spacing: 10) { // Adds spacing between buttons
                Button {
                    print("Increase button clicked")
                } label: {
                    Text("Increase")
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .buttonStyle(.borderedProminent)
                
                Button {
                    print("Decrease button clicked")
                } label: {
                    Text("Decrease")
                    //                        .font(.largeTitle)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [.purple, .pink]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .clipShape(Circle())
                }
                
            }
            .padding(.horizontal) // Ensures buttons don’t touch screen edges
        }
    }
}

struct ButtonExample: View {
    @State private var message = "Tap the button"
    @State private var isDisabled: Bool = false
    
    func reset() {
        message = "Tap the button"
        isDisabled = false
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(message)
                .font(.title)
                .padding()
            
            Button("Tap Me") {
                message = "Button Pressed!"
                print("Button Pressed")
                isDisabled = true
                
                // Automatically re-enable after 3 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    isDisabled = false
                    message = "Tap the button"
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .disabled(isDisabled)
            .opacity(isDisabled ? 0.5 : 1.0) // Visual feedback
            
            // Manual Reset Button
            Button("Reset") {
                reset()
            }
            .buttonStyle(.bordered)
            .padding()
        }
    }
}


struct DispatchQueueImmediate : View{
    
    var body: some View{
        VStack(){
            
            Text("Dispatch Queue Immediate")
            Button{
                DispatchQueue.main.async{
                    print("Dispatch Queue Immediate")
                }
            } label: {
                Text("Dispatch")
            }
        }.padding()
    }
}


struct DispatchQueueDelay : View{
    var body: some View {
        VStack(){
            
            Text("Dispatch Queue Delay")
            Button{
                DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                    print("Dispatch Queue Delay")
                }
            } label: {
                Text("Dispatch")
            }
        }.padding()
    }
}

struct DispatchQueueGlobalBackground : View{
    var body: some View {
        VStack(){
            
            Text("Dispatch Queue Global Background")
            Button{
                DispatchQueue.global(qos: .background).async {
                    print("I am working in the background...")
                }
            
            } label: {
                Text("Dispatch")
            }
        }.padding()
    }
}

struct DispatchQueueEx: View {
    var body: some View {
        VStack {
            Button {
                print("Task 0 started (before async calls)")
                
                DispatchQueue.global(qos: .background).async {
                    print("Task 1 started (background queue)")
                }
                
                DispatchQueue.main.async {
                    print("Task 2 started (main queue)")
                }
                
                DispatchQueue.global(qos: .background).async {
                    print("Task 3 started (background queue)")
                }
                
                DispatchQueue.main.async {
                    print("Task 4 started (main queue)")
                }
                
                print("Task 5 started (after async calls)")

            } label: {
                Text("DispatchQueueEx - Start")
            }
        }
    }
}






#Preview {
//    ButtonViewExamples2()
//    ButtonViewExamples()
//    DispatchQueueImmediate()
//    DispatchQueueDelay()
//    DispatchQueueGlobalBackground()
//    DispatchQueueEx()
}


/*
 notes on dispatch - main and async - and delay
 
 - immediates go first since they are not async
 - background queue items execution on nnot predictable - they system decides when to execute them - not the code
 - main - FIFO unless there is a delay - in that case the delay executes last
 
 
 1 yes, 0 and 5 are immedately started
 2. yes, 4 is always executed before 2, because of the delay
 3. task 4 runs before task 3 due to the delay
 
 1. yes 0 -> 5 are executed first
 2. (1 -> 3) -> 2  task 2 will always come after 1 and 3
 3. ? i dont know ? but since tasks 2 is part of task 1 i would say 4 would execute first.
 */
