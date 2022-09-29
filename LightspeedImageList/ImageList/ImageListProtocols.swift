//
//  ImageListViewController.swift
//  LightspeedImageList
//
//  Created by Lin Xu on 2022-09-28.
//

import Foundation

protocol ImageListViewModelProtocol {
    var viewDelegate: ImageListViewModelDelegate? { get set }
    var images: [LSImage] { get }

    func fetchImages()
}

protocol ImageListViewModelDelegate: AnyObject {
    func fetchImagesSuccess()
    func fetchImagesFailure()
}
