//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Abhishek J  on 06/05/24.
//

import SwiftUI

@main
struct NewsAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NewsCollectionView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
