import UIKit

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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


private extension ImagesListCell {
    func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(imageCell)
        addSubview(likeButton)
        addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            likeButton.heightAnchor.constraint(equalToConstant: 44),
            likeButton.widthAnchor.constraint(equalToConstant: 44),
            trailingAnchor.constraint(equalTo: imageCell.trailingAnchor, constant: 16),
            imageCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bottomAnchor.constraint(equalTo: imageCell.bottomAnchor, constant: 4),
            imageCell.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            imageCell.trailingAnchor.constraint(equalTo: likeButton.trailingAnchor),
            imageCell.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            trailingAnchor.constraint(greaterThanOrEqualTo: dateLabel.trailingAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: imageCell.leadingAnchor, constant: 8),
            likeButton.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            likeButton.topAnchor.constraint(equalTo: imageCell.topAnchor)
        ])
    }
}
