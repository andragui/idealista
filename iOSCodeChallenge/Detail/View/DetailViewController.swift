//
//  DetailViewController.swift
//  iOSCodeChallenge
//
//  Created by Andres Aguirre Juarez on 30/9/21.
//

import UIKit

protocol DetailViewControllerProtocol: class {
    func configureView(_ viewModel: DetailViewModel)
    func configureError(_ title: String, message: String)
}

class DetailViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var principalLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favouriteButton: StarButton!
    
    private let presenter: DetailPresenterProtocol
    private var multimediaIndex: Int = 0
    private var viewModel: DetailViewModel?
    
    init(presenter: DetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "DetailViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func favouriteButtonPressed(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        viewModel.toggleFavourite()
        presenter.favouritePressed()
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    func configureView(_ viewModel: DetailViewModel) {
        self.viewModel = viewModel
        self.title = viewModel.propertyTitle
        self.principalLabel.text = viewModel.price
        self.descriptionLabel.text = viewModel.descriptionLabel
        self.favouriteButton.setOn(viewModel.isFavourite)
        guard let multimedia = viewModel.multimedia else {
            imageView.image = #imageLiteral(resourceName: "error")
            return
        }
        Helpers.getSpecificImage(imageUrl: multimedia.images[multimediaIndex].url) { image, error in
            if let image = image {
                self.imageView.image = image
            } else {
                self.imageView.image = #imageLiteral(resourceName: "error")
            }
        }
    }
    
    func configureError(_ title: String, message: String) {
        self.title = title
        self.principalLabel.text = message
        self.imageView.image = #imageLiteral(resourceName: "error")
    }
}

private extension DetailViewController {
    func setupView() {
        self.title = ""
        self.descriptionLabel.text = ""
        self.principalLabel.text = ""
        self.principalLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.addTapGesture()
    }
    
    func addTapGesture() {
        self.imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTapItemView))
        tap.numberOfTapsRequired = 2
        self.imageView.addGestureRecognizer(tap)
    }
    
    @objc func didTapItemView() {
        guard let viewModel = self.viewModel,
              let multimedia = viewModel.multimedia else { return }
        let numberOfImages = multimedia.images.count
        if self.multimediaIndex + 1 >= numberOfImages {
            self.multimediaIndex = 0
        } else {
            self.multimediaIndex += 1
        }
        self.configureView(viewModel)
    }
}
