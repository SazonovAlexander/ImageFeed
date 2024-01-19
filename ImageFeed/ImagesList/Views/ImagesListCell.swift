import UIKit
import Kingfisher

final class ImagesListCell: UITableViewCell {

    static let reuseIdentifier = "ImagesListCell"
    
    lazy var imageCell: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var dateLabel: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "27 августа 2022"
        label.textColor = .ypWhite
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    weak var delegate: ImagesListCellDelegate? 
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
            imageCell.kf.cancelDownloadTask()
        }
    
    func setIsLiked(_ isLiked: Bool) {
        if isLiked {
            likeButton.setImage(UIImage.activeLike, for: .normal)
        }
        else {
            likeButton.setImage(UIImage.noActiveLike, for: .normal)
        }
    }
    
}


private extension ImagesListCell {
    func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(imageCell)
        contentView.addSubview(likeButton)
        contentView.addSubview(dateLabel)
        
        
        likeButton.addTarget(self, action: #selector(Self.likeButtonClicked), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            likeButton.heightAnchor.constraint(equalToConstant: 44),
            likeButton.widthAnchor.constraint(equalToConstant: 44),
            contentView.trailingAnchor.constraint(equalTo: imageCell.trailingAnchor, constant: 16),
            imageCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: imageCell.bottomAnchor, constant: 4),
            imageCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            imageCell.trailingAnchor.constraint(equalTo: likeButton.trailingAnchor),
            imageCell.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            contentView.trailingAnchor.constraint(greaterThanOrEqualTo: dateLabel.trailingAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: imageCell.leadingAnchor, constant: 8),
            likeButton.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor),
            likeButton.topAnchor.constraint(equalTo: imageCell.topAnchor)
        ])
    }
    
    @objc
    func likeButtonClicked() {
        delegate?.imageListCellDidTapLike(self)
    }
}
