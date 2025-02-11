//
//  InfoView.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/28/23.
//

import SwiftUI

struct InfoView: View {
    @AppStorage("ocid") private var ocid: String = ""
    
    @State private var path: [String] = []
    
    var body: some View {
        VStack {
            StateDrivenNavigationView()
        }
    }
}

// 1. 기본 NavigationStack View
struct BasicNavigationStackView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome to the Home Screen")
                    .font(.title)
                
                NavigationLink("Go to Detail", value: "Detail Screen")
                    .padding()
                    .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Home")
            .navigationDestination(for: String.self) { destination in
                Text(destination)
                    .font(.largeTitle)
                    .navigationTitle("Detail")
            }
        }
    }
}

// 2. Path를 이용한 동적 탐색
struct PathNavigationView: View {
    @State private var path: [String] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Text("Dynamic Naivgation")
                    .font(.title)
                
                Button("Go to Screen 1") {
                    path.append("Screen 1")
                }
                .padding()
                .buttonStyle(.borderedProminent)
                
                Button("Go to Screen 2") {
                    path.append("Screen 2")
                }
                .padding()
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Home")
            .navigationDestination(for: String.self) { destination in
                VStack {
                    Text("You are on \(destination)")
                        .font(.largeTitle)
                    
                    Button("Go Back") {
                        path.removeLast()
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}

struct CustomNavigationView: View {
    struct Item: Identifiable, Hashable {
        let id = UUID()
        let name: String
        let description: String
    }
    
    @State private var path: [Item] = []
    let items = [
        Item(name: "Item 1", description: "This is the first item."),
        Item(name: "Item 2", description: "This is the second item."),
        Item(name: "Item 3", description: "This is the third item.")
    ]
    
    var body: some View {
        NavigationStack(path: $path) {
            List(items) { item in
                NavigationLink(value: item) {
                    Text(item.name)
                }
            }
            .navigationTitle("Items")
            .navigationDestination(for: Item.self) { item in
                VStack {
                    Text(item.name)
                        .font(.title)
                    
                    Text(item.description)
                        .padding()
                    
                    Button("Go Back") {
                        path.removeLast()
                    }
                }
            }
        }
    }
}

struct StateDrivenNavigationView: View {
    @State private var path: [Int] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                ForEach(1..<4) { number in
                    Button("Go to Scrren \(number)") {
                        path.append(number)
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationTitle("State Navigation")
            .navigationDestination(for: Int.self) { number in
                VStack {
                    Text("Screen \(number)")
                        .font(.largeTitle)
                    
                    Button("Go Back") {
                        path.removeLast()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}
