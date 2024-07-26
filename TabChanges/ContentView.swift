//
//  ContentView.swift
//  TabChanges
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2024/07/26.
//

import SwiftUI

struct ContentView1: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world! 1")
        }
        .padding()
    }
}
struct ContentView2: View {
    var body: some View {
        VStack {
            Image(systemName: "circle")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, circle! 2")
        }
        .padding()
    }
}
struct ContentView3: View {
    var body: some View {
        VStack {
            Image(systemName: "square")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, square! 3")
        }
        .padding()
    }
}

/// グローバルメニューのタブ
enum TabIndex: Hashable {
    /// ホーム
    case home
    /// 借入
    case loan
    /// 借入返済
    case loanReturn
    /// メニュー
    case menu
}


struct MainFooterTabView: View {
    @State var tabIndex: TabIndex = .home
    // First screen needs server data so will be loading at start. Hence, first state is "tabs disabled"
    @State var canChangeTabs = false

    private var tabSelection: Binding<TabIndex> {
        Binding(
            get: { self.tabIndex },
            set: { newValue in
                print("Attempting to set new value: \(newValue)")
                if self.canChangeTabs {
                    self.tabIndex = newValue
                    print("Set!")
                } else {
                    print("Skipped")
                }
            }
        )
    }

    var body: some View {
        TabView(selection: $tabIndex) {
            ContentView1()
                .tabItem {
                    Label {
                        Text("1")
                            .font(.system(size: 10, weight: .semibold))
                    } icon: {
                        Image(systemName: "globe")
                            .renderingMode(.template)
                    }
                }.tag(TabIndex.home)
            ContentView2()
                .tabItem {
                    Label {
                        Text("2")
                    } icon: {
                        Image(systemName: "circle")
                            .renderingMode(.template)
                    }
                }.tag(TabIndex.loan)
            ContentView3()
                .tabItem {
                    Label {
                        Text("3")
                    } icon: {
                        Image(systemName: "square")
                            .renderingMode(.template)
                    }
                }.tag(TabIndex.loanReturn)
        }
        .onReceive(
            // タブ切り替えを有効にする通知（NotificationCenter）を設定
            NotificationCenter.default.publisher(for: Notification.Name("enableTabChanging"))
        ) { notification in
            print("enableTabChanging canChangeTabs = true")
            canChangeTabs = true
        }
        .onReceive(
            // タブ切り替えを無効にする通知（NotificationCenter）を設定
            NotificationCenter.default.publisher(for: Notification.Name("disableTabChanging"))
        ) { notification in
            print("disableTabChanging canChangeTabs = false")
            canChangeTabs = false
        }
    }
}



#Preview {
    MainFooterTabView()
}