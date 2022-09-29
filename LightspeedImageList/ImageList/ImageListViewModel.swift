//
//  ImageListViewModel.swift
//  LightspeedImageList
//
//  Created by Lin Xu on 2022-09-28.
//

import Foundation

class ImageListViewModel {
    
    // MARK: - Public Properties
    
    weak var viewDelegate: ImageListViewModelDelegate?

    var images: [LSImage] = []

    // MARK: - Private Properties

    private let lsApi: LSAPI

    init(_ lsApi: LSAPI) {
        self.lsApi = lsApi
    }
}

extension ImageListViewModel: ImageListViewModelProtocol {
    // MARK: - ImageListViewModelProtocol

    func fetchImages() {
        lsApi.getImages { [weak self] result in
            switch result {
            case .success(let images):
                self?.processingImages(images)
                DispatchQueue.main.async {
                    self?.viewDelegate?.fetchImagesSuccess()
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.viewDelegate?.fetchImagesFailure()
                }
            }
        }
    }
}

private extension ImageListViewModel {
    // MARK: - Private Methods
    
    private func processingImages(_ images: [LSImage]) {
        if let randomImages = images.randomElement() {
            self.images.append(randomImages)
        }
    }
}
