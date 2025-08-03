import UIKit

protocol SearchViewProtocol: AnyObject {
    func showResults(_ results: [GitHubUserItem])
    func showError(_ message: String)
}

class SearchViewController: UIViewController, SearchViewProtocol {

    var presenter: SearchPresenterProtocol?
    private var results: [GitHubUserItem] = []
    private var allUsers: [GitHubUserItem] = []
    
    // UI ELEMANLARI
    private lazy var searchContainer: UIView = makeSearchContainer()
    private lazy var searchField: UITextField = makeSearchField()
    private lazy var searchButton: UIButton = makeSearchButton()
    
    // ***** LIFECYCLE ******
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter?.viewDidLoad()
        
        setupUI()
        setupActions()
    }
    
    private func setupUI() {
        setupSearchUI()
        setupCollectionView()
        
    }
    
    private func setupSearchUI() {
        view.addSubview(searchContainer)
        searchContainer.addSubview(searchField)
        searchContainer.addSubview(searchButton)

        NSLayoutConstraint.activate([
            searchContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            searchContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchContainer.heightAnchor.constraint(equalToConstant: 44),

            searchField.leadingAnchor.constraint(equalTo: searchContainer.leadingAnchor, constant: 8),
            searchField.centerYAnchor.constraint(equalTo: searchContainer.centerYAnchor),
            searchField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -8),

            searchButton.trailingAnchor.constraint(equalTo: searchContainer.trailingAnchor, constant: -8),
            searchButton.centerYAnchor.constraint(equalTo: searchContainer.centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            searchButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 60) / 2, height: 150)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .white
        cv.register(UserCell.self, forCellWithReuseIdentifier: "UserCell")
        return cv
    }()

    private func setupCollectionView() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchContainer.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    class UserCell: UICollectionViewCell {
        private let nameLabel = UILabel()
        private let heartIcon = UIImageView(image: UIImage(systemName: "heart"))

        override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.backgroundColor = .lightGray
            contentView.layer.cornerRadius = 12
            contentView.clipsToBounds = true

            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            heartIcon.translatesAutoresizingMaskIntoConstraints = false
            heartIcon.tintColor = .red

            contentView.addSubview(nameLabel)
            contentView.addSubview(heartIcon)

            NSLayoutConstraint.activate([
                heartIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                heartIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                heartIcon.widthAnchor.constraint(equalToConstant: 20),
                heartIcon.heightAnchor.constraint(equalToConstant: 20),

                nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }

        required init?(coder: NSCoder) { fatalError() }

        func configure(with user: GitHubUserItem) {
            nameLabel.text = user.login
        }
    }

    private func setupActions() {
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    // UI BUİLDERs
    
    private func makeSearchContainer() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.purple.cgColor
        return view
    }
    
    private func makeSearchField() -> UITextField {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Search....."
        tf.borderStyle = .none
        tf.textColor = .white
        return tf
    }
    
    private func makeSearchButton() -> UIButton {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("🔍", for: .normal)
        btn.backgroundColor = .yellow
        btn.tintColor = .black
        btn.layer.cornerRadius = 6
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.purple.cgColor
        return btn
    }
    
    private func makeTableView() -> UITableView {
           let tv = UITableView()
           tv.translatesAutoresizingMaskIntoConstraints = false
           tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
           tv.backgroundColor = .white
           return tv
       }
    
    // ACTIONS
    
    @objc private func searchButtonTapped() {
        guard let text = searchField.text, !text.isEmpty else {
            print("text boş")
            return
        }
        presenter?.performSearch(with: text)
    }
    
    // searchviewProtocol
    
    func showResults(_ results: [GitHubUserItem]) {
        self.results = results
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showError(_ message: String) {
        print("hatanız: \(message)")
    }
}
 // UITableViewDataSource
    
extension SearchViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return results.isEmpty ? allUsers.count : results.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCell", for: indexPath) as? UserCell else {
                return UICollectionViewCell()
            }
            let user = results.isEmpty ? allUsers[indexPath.row] : results[indexPath.row]
            cell.configure(with: user)
            return cell
        }
}

