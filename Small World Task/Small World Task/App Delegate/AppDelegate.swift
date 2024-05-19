//
//  AppDelegate.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        setInitialController()
        return true
    }
    
    private func setInitialController(){
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let request: NetworkManagerProtocol = NetworkManager()
        let repo: MoviesListRepoProtocol = MoviesRepository(request: request)
        let useCase: MovieListUseCaseProtocol = MovieListUseCase(_repo: repo)
        let dVC = StoryBoards.main.instantiateViewController(withIdentifier: MoviesListVC.getIdentifier()) as! MoviesListVC
        dVC.viewModal = MoviesListViewModal(_delegate: dVC, _useCase: useCase)
        let navVC = UINavigationController(rootViewController: dVC)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()

    }

    

}

