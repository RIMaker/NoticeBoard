//
//  SceneDelegate.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 24.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let featureFactory = FeatureFactoryImpl()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.backgroundColor = .white
        window?.overrideUserInterfaceStyle = .light
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        
        setupAppearance()
        
        
        let splashVC = featureFactory.makeView(for: .splash)
        window?.rootViewController = splashVC
                
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.window?.rootViewController = self?.featureFactory.makeView(for: .main)
        }
    }
    
    private func setupAppearance() {
        let navigationBarTitleAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor: NBColor.NavigationBar.textColor,
        ]
        UINavigationBar.appearance().titleTextAttributes = navigationBarTitleAttributes
        UINavigationBar.appearance().barTintColor = NBColor.NavigationBar.backgroundColor
    }



}

