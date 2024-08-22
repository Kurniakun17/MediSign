//
//  ProfileCoordinator.swift
//  DeafHealth
//
//  Created by Anthony on 22/08/24.
//

import SwiftUI

class ProfileCoordinator: ObservableObject {
    @Published var navigationPath = NavigationPath()
    
    func start() -> some View {
        NavigationStack(path: Binding(get: {
            self.navigationPath
        }, set: {
            self.navigationPath = $0
        })) {
            ProfileViewControllerWrapper()
                .environmentObject(self)
        }
    }
    
    func push(page: ProfilePage) {
        navigationPath.append(page)
    }
    
    func pop() {
        navigationPath.removeLast()
    }
}

enum ProfilePage: Hashable {
    case userProfile
    case editProfile
}

// Wrapper for ProfileViewController
struct ProfileViewControllerWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> ProfileViewController {
        return ProfileViewController()
    }
    
    func updateUIViewController(_ uiViewController: ProfileViewController, context: Context) {
        // Update the view controller if needed
    }
}

#Preview {
    ProfileViewControllerWrapper()
}
