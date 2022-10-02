//
//  ImageListViewController.swift
//  LightspeedImageList
//
//  Created by Lin Xu on 2022-09-28.
//

import UIKit

class ImageListViewController: ViewController {

    // MARK: - Properties
    private enum Constants {
        static let tableViewCellId = "tableViewCellId"
    }

    private var viewModel: ImageListViewModelProtocol
    
    private var state: ViewState<Void> = .empty{
        didSet {
            switch state {
            case .loading:
                break
            case .empty:
                break
            case .error:
                break
            case .showingData:
                updateView()
            }
        }
    }

    // MARK: - UI

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            ImageListTableViewCell.self,
            forCellReuseIdentifier: Constants.tableViewCellId
        )

        return tableView
    }()
    
    // MARK: Life Cycle Methods

    init(_ viewModel: ImageListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.viewDelegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Methods

    override func setupUI() {
        navigationController?.buildImageListViewNavigation()

        view.buildImageListViewWith(tableView)
        
        title = "Images"

        let add = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(addImage))
        add.image = UIImage(systemName: "plus.app")
        add.tintColor = .purple
        navigationItem.rightBarButtonItem = add

        tableView.dataSource = self
    }

    // MARK: - Public Methods

    @objc
    func addImage() {
        viewModel.fetchImages()
    }
}

private extension ImageListViewController {
    // MARK: - Private Methods

    func updateView() {
        let newRowIndexPath: IndexPath = .init(row: viewModel.images.count - 1, section: 0)
        tableView.insertRows(
            at: [newRowIndexPath],
            with: .bottom
        )

        tableView.scrollToRow(
            at: newRowIndexPath,
            at: .bottom,
            animated: true
        )
    }
}

extension ImageListViewController: ImageListViewModelDelegate {
    // MARK: - ImageListViewModelDelegate

    func fetchImagesSuccess() {
        state = .showingData
    }
    
    func fetchImagesFailure() {
        
    }
}


extension ImageListViewController: UITableViewDataSource {
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.tableViewCellId,
            for: indexPath
        ) as? ImageListTableViewCell else {
            return UITableViewCell()
        }
        
        if let image = viewModel.images[safe: indexPath.row] {
            cell.setupCellWith(image)
        }

        return cell
    }
}
