
import UIKit

protocol SearchViewProtocol: AnyObject {
    func showResults(_ results: [String])
}

class SearchViewController: UIViewController, SearchViewProtocol {

    var presenter: SearchPresenterProtocol?
    private var results: [String] = []
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private let searchContainer: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .black
            view.tintColor = .blue
            view.layer.cornerRadius = 8
            view.layer.borderColor = UIColor.purple.cgColor
            return view
        }()

    private let searchField: UITextField = {
            let tf = UITextField()
            tf.translatesAutoresizingMaskIntoConstraints = false
            tf.placeholder = "Search..."
            tf.borderStyle = .none
            return tf
        }()

    
    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "search......."
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    private let searchButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Search", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("🔍", for: .normal)
        
        btn.backgroundColor = .yellow
        btn.tintColor = .yellow
        btn.layer.cornerRadius = 6
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.purple.cgColor
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter?.viewDidLoad()
        setupSearchUI()
        setupTableView()
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
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    @objc private func searchButtonTapped() {
        guard let text = searchBar.text else { return }
        presenter?.performSearch(with: text)
    }
    
    func showResults(_ results: [String]) {
        self.results = results
        tableView.reloadData()
    }
}

    
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = results[indexPath.row]
        return cell
    }
}

