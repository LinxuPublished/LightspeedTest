//
//  ImageListTableViewCell.swift
//  LightspeedImageList
//
//  Created by Lin Xu on 2022-09-28.
//

import UIKit

class ImageListTableViewCell: UITableViewCell {

    // MARK: - UI Properties
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    private let lsImageView: UIImageView = {
        let lsImageView = UIImageView()
        lsImageView.contentMode = .scaleAspectFit
        lsImageView.translatesAutoresizingMaskIntoConstraints = false
        return lsImageView
    }()

    // MARK: - Properties

    private enum Constants {
        static let imageHeight: CGFloat = 80
        static let imageWidth: CGFloat = 150
    }

    private var imageUrl: String? {
        didSet {
            guard let imageUrl = imageUrl, let url = URL(string: imageUrl) else {
                var config = defaultContentConfiguration()
                config.image = nil
                contentConfiguration = config
                return
            }

            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        let resizedImage = image.resizeImageTo(CGSize(width: Constants.imageWidth, height: Constants.imageHeight))
                        DispatchQueue.main.async {
                            self?.lsImageView.image = resizedImage
                        }
                    }
                }
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        lsImageView.image = nil
    }

    func setupCellWith(_ image: LSImage) {
        titleLabel.text = image.author
        imageUrl = image.downloadUrl
    }
}

private extension ImageListTableViewCell {
    // MARK: - Private methods
    
    func setupUI() {
        contentView.addSubview(lsImageView)
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            lsImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            lsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            lsImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            lsImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth),

            titleLabel.topAnchor.constraint(equalTo: lsImageView.bottomAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
