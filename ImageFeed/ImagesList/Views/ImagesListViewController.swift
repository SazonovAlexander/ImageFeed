import UIKit
import Kingfisher


public protocol ImagesListViewControllerProtocol: AnyObject {
    var presenter: ImagesListPresenterProtocol? {get set}
    func updateTableViewAnimated(newPhotos: [Photo])
}


class ImagesListViewController: UIViewController & ImagesListViewControllerProtocol {

    var presenter: ImagesListPresenterProtocol?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .ypBlack
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        return tableView
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    private var photos: [Photo] = []
    private let placeholder = UIImage(named: "Loader")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func updateTableViewAnimated(newPhotos: [Photo]) {
        let oldCount = photos.count
            let newCount = newPhotos.count
            photos = newPhotos
            if oldCount != newCount {
                tableView.performBatchUpdates {
                    let indexPaths = (oldCount..<newCount).map { i in
                        IndexPath(row: i, section: 0)
                    }
                    tableView.insertRows(at: indexPaths, with: .automatic)
                } completion: { _ in }
            }
    }
}


//MARK: - Private methods
private extension ImagesListViewController {
    
    func setup() {
        addSubviews()
        activateConstraints()
        setupTableView()
        presenter?.getPhotos()
    }
    
    func addSubviews() {
        view.addSubview(tableView)
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ImagesListCell.self, forCellReuseIdentifier: ImagesListCell.reuseIdentifier)
    }
    
    func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        
        cell.imageCell.kf.setImage(with: URL(string: photos[indexPath.row].thumbImageURL),placeholder: placeholder, completionHandler: {[weak self] _ in
            guard let self else { return}
            DispatchQueue.main.async {
                cell.imageCell.kf.indicator?.stopAnimatingView()
                cell.imageCell.kf.indicatorType = .none
            }
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        })
        cell.imageCell.kf.indicatorType = .activity
        cell.imageCell.kf.indicator?.startAnimatingView()
        if let date = photos[indexPath.row].createdAt {
            cell.dateLabel.text = dateFormatter.string(from:  date)
        }
        else {
            cell.dateLabel.text = ""
        }
        let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let cellHeight = placeholder?.size.height ?? 100  + imageInsets.top + imageInsets.bottom
        cell.frame.size.height = cellHeight
        cell.setIsLiked(photos[indexPath.row].isLiked)
        cell.delegate = self
        
    }
    
    
}

//MARK: - UITableViewDelegate
extension ImagesListViewController: UITableViewDelegate {
    
    func tableView(
      _ tableView: UITableView,
      willDisplay cell: UITableViewCell,
      forRowAt indexPath: IndexPath
    ) {
        if indexPath.row == photos.count - 1 {
            presenter?.getPhotos()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        let imageWidth = photos[indexPath.row].size.width
        let scale = imageViewWidth / imageWidth
        let cellHeight = photos[indexPath.row].size.height * scale + imageInsets.top + imageInsets.bottom
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        let singleImageViewController = SingleImageViewController()
        singleImageViewController.imageUrl = photos[indexPath.row].largeImageURL
        singleImageViewController.modalPresentationStyle = .fullScreen
        singleImageViewController.modalTransitionStyle = .crossDissolve
        present(singleImageViewController, animated: true)
        
    }
}


//MARK: - UITableViewDataSource
extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
                
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        
        configCell(for: imageListCell, with: indexPath)

        return imageListCell
    }
    
}


extension ImagesListViewController: ImagesListCellDelegate {
    func imageListCellDidTapLike(_ cell: ImagesListCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let photo = photos[indexPath.row]
        presenter?.likePhoto(photo) { [weak self] in
            guard let self else { return }
            photos[indexPath.row] = Photo(id: photo.id,
                                          size: photo.size,
                                          createdAt: photo.createdAt, 
                                          welcomeDescription: photo.welcomeDescription,
                                          thumbImageURL: photo.thumbImageURL,
                                          largeImageURL: photo.largeImageURL,
                                          isLiked: !photo.isLiked)
            DispatchQueue.main.async {
                cell.setIsLiked(!photo.isLiked)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    
}
