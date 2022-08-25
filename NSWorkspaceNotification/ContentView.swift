//
//  ContentView.swift
//  NSWorkspaceNotification
//
//  Created by Mateusz Szlosek on 06/04/2022.
//

import SwiftUI
import Combine

class ViewModel: ObservableObject {
    @Published var info: String = "WAITING FOR REFRESH"
    private var cancellable: AnyCancellable?

    init() {
        updateSpaceID()
        cancellable = NSWorkspace.shared.notificationCenter
            .publisher(for: NSWorkspace.activeSpaceDidChangeNotification)
            .sink { [weak self] _ in
                self?.updateSpaceID()
            }
    }

    func updateSpaceID() {
        let currentSpace = CGSGetActiveSpace(CGSMainConnectionID())
        print(currentSpace)
        info = "SPACE ID: \(currentSpace)"
    }
}

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    var body: some View {
        Text(viewModel.info)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
