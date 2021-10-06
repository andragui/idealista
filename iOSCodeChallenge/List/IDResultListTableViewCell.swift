import UIKit

protocol IDResultListTableViewCellProtocol: class {
    func isFavouriteTapped(_ cell: IDResultListTableViewCell)
}

class IDResultListTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var isFavouriteButton: StarButton!
    
    var entity: PropertyEntity?
    weak var delegate: IDResultListTableViewCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .white
        selectionStyle = .none
        separatorInset = .zero
    }
    
    @IBAction func isFavouriteButtonPressed(_ sender: Any) {
        guard let entity = entity else { return }
        entity.isFavourite.toggle()
        delegate?.isFavouriteTapped(self)
    }
    
    func fill(withEntity entity: PropertyEntity, delegate: IDResultListTableViewCellProtocol?) {
        self.entity = entity
        self.delegate = delegate
        self.titleLabel.text = Helpers.typeOfProperty(forOperation: entity.operation, andPropertyType: entity.propertyType)
        self.subtitleLabel.text = String(format: "%@ €", String(entity.price ?? 0))
        isFavouriteButton.setOn(entity.isFavourite)
        Helpers.getImage(multimedia: entity.multimedia) { image, error in
            if let image = image {
                self.photo.image = image
            }
        }
    }
}
