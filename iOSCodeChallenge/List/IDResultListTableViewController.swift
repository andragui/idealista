import UIKit

class IDResultListTableViewController: UITableViewController {
    private let resultListURL = URL(string: "https://www.mocky.io/v3/364d4f62-c183-4f12-ba16-49bfc5c820ab")!
    private var entitiesList: PropertyEntities?
    private var detailCoordinator: DetailCoordinatorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "idealista"
        
        let nib = UINib(nibName: String(describing: IDResultListTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "IDResultListTableViewCell")
        tableView.estimatedRowHeight = 240.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        self.detailCoordinator = DetailCoordinator()
        addRefreshControl()
        fetchResults()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func fetchResults() {
        var urlRequest = URLRequest(url: resultListURL)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let data = data, error == nil {
                let jsonDecoder = JSONDecoder()
                if let results = try? jsonDecoder.decode(IDResultsDTO.self, from: data) {
                    DispatchQueue.main.async {
                        self.didObtain(results: results)
                        self.refreshControl?.endRefreshing()
                    }
                }
            } else if let _ = error {}
        }.resume()
    }
    
    private func didObtain(results: IDResultsDTO) {
        self.entitiesList = PropertyEntities(results)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let entitiesList = entitiesList else { return 0 }
        return entitiesList.propertyEntities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IDResultListTableViewCell", for: indexPath) as? IDResultListTableViewCell,
              let entitySelected = entitiesList?.propertyEntities[indexPath.row] else { return UITableViewCell() }
        cell.fill(withEntity: entitySelected, delegate: self)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let propertyEntity = self.entitiesList?.propertyEntities[indexPath.row],
              let viewController = self.detailCoordinator?.start(configuration: PropertyDetailConfiguration(propertyEntity: propertyEntity), delegate: self) else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

private extension IDResultListTableViewController {
    @objc func refresh(_ sender: AnyObject) {
       fetchResults()
    }
    
    func addRefreshControl() {
        refreshControl = UIRefreshControl()
        guard let refreshControl = refreshControl else { return }
        refreshControl.attributedTitle = NSAttributedString(string: "Limpiando los favoritos...")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
    }
}

extension IDResultListTableViewController: IDResultListTableViewCellProtocol {
    func isFavouriteTapped(_ cell: IDResultListTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        tableView.reloadRows(at: [indexPath], with: .right)
    }
}

extension IDResultListTableViewController : DetailViewDelegateProtocol {
    func favouritePressed() {
        tableView.reloadData()
    }
}
