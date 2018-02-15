//
//  AppDelegate.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 11..
//  Copyright © 2018. W.UP. All rights reserved.
//

import Alamofire
import CoreData
import Dip
import Dip_UI
import Foundation
import UIKit
import Common

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    enum DataSourceTag: String, DependencyTagConvertible {
        case local
        case remote
    }

    let test: CommonTest = CommonTest()
    
    let container = DependencyContainer { container in

        container.register(storyboardType: CharacterDetailViewController.self, tag: "characterDetail")
            .resolvingProperties { (container, viewController) in
                viewController.presenter = try container.resolve() as CharacterDetailMvpPresenter
            }
        container.register(storyboardType: CharactersViewController.self, tag: "characters")
            .resolvingProperties { (container, viewController) in
            viewController.presenter = try container.resolve() as CharactersMvpPresenter
        }
        container.register {
            CharacterDetailPresenter(useCaseHandler: $0, getCharacterUseCase: $1) as CharacterDetailMvpPresenter
        }
        container.register {
            GetCharacterUseCase(charactersDataSource: try container.resolve() as CharactersRepository)
        }
        container.register {
            CharactersPreseneter(useCaseHandler: $0, getCharactersUseCase: $1) as CharactersMvpPresenter
        }
        container.register {
            GetCharactersUseCase(charactersDataSource: try container.resolve() as CharactersRepository)
        }
        container.register(.singleton) {
            UseCaseHandler(useCaseScheduler: $0) as UseCaseHandler
        }
        container.register(.singleton) {
            UseCaseNSOperationQueueScheduler(workerQueue: OperationQueue(),
                                             mainQueue: OperationQueue.main) as UseCaseScheduler
        }
        container.register {
            CharactersRepository(localDataSource: try container.resolve(tag: DataSourceTag.local) as CharactersDataSource,
                                 remoteDataSource: try container.resolve(tag: DataSourceTag.remote) as CharactersDataSource)
        }
        container.register(tag: DataSourceTag.remote) {
            CharactersRemoteDataSource(manager: $0,
                                       publicApiKey: credentials.publicApiKey as String,
                                       privateApiKey: credentials.privateApiKey) as CharactersDataSource
        }
        container.register(tag: DataSourceTag.local) {
            CharactersLocalDataSource(persistentContainer: $0) as CharactersDataSource
        }
        container.register { SessionManager() }
        container.register { NSPersistentContainer(name: "CharacterModel") }
            .resolvingProperties { (_, persistentContainer)  in
                persistentContainer.loadPersistentStores(completionHandler: { (_, error) in
                    if let error = error as NSError? {
                        fatalError("Unresolved error \(error)")
                    }
                })
            }

        DependencyContainer.uiContainers = [container]
    }

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        if let splitViewController = self.window!.rootViewController as? UISplitViewController,
            let navigationController = splitViewController.viewControllers.last as? UINavigationController {
            navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
            splitViewController.delegate = self
        }

        return true
    }

    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? CharacterDetailViewController else {
            return false

        }
        if topAsDetailController.characterId == nil {
            // Return true to indicate that we have handled the collapse by doing nothing;
            // the secondary controller will be discarded.
            return true
        }
        return false
    }
}
