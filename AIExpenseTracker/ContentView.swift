//
//  ContentView.swift
//  AIExpenseTracker
//
//  Created by MyeongJin Kim on 7/16/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var vm = LogListViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        #if os(macOS)
        splitView
        #elseif os(visionOS)
        tabView
        #else
        switch horizontalSizeClass {
        case .compact: tabView
        default: splitView
        }
        #endif
    }
    
    var tabView: some View {
        TabView {
            NavigationStack {
                LogListContainerView(vm: $vm)
            }
            .tabItem {
                Label("Expenses", systemImage: "tray")
            }
            
//            NavigationStack {
//                Text("AI Assistant")
//            }
//            .tabItem {
//                Label("Assistant", systemImage: "waveform")
//            }.tag(1)
        }
    }
    
    var splitView: some View {
        NavigationSplitView {
            List {
                NavigationLink(destination: LogListContainerView(vm: $vm)) {
                    Label("Expenses", systemImage: "tray")
                }
//                NavigationLink(destination: Text("AI Assistant")) {
//                    Label("Assistant", systemImage: "waveform")
//                }
            }
        } detail: {
            LogListContainerView(vm: $vm)
        }
        .navigationTitle("XCA AI Expense Tracker")
    }
}



#Preview {
    ContentView()
}
