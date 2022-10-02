//
//  View+Entensions.swift
//  LightspeedImageList
//
//  Created by Lin Xu on 2022-09-28.
//

import UIKit

extension UIView {
    func buildImageListViewWith(_ tableView: UITableView) {
        backgroundColor = .white

        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension UINavigationController {
    func buildImageListViewNavigation() {
        navigationBar.prefersLargeTitles = true

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .lightText
        appearance.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationBar.compactAppearance = appearance
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        
        navigationBar.tintColor = .black
    }
}
