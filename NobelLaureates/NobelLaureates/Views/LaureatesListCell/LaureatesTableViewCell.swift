//
//  LaureatesTableViewCell.swift
//  NobelLaureates
//
//  Created by Karandeep Singh Bhatia on 12/12/20.
//

import UIKit
struct LaureatsDataModel {
  let laureateName: String
  let awardCategory: String
  let awardYear: String
  let country: String
}
class LaureatesTableViewCell: UITableViewCell {

  // MARK: - Properties
  @IBOutlet weak var backgroundContainerView: UIView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var awardCategoryLabel: UILabel!
  @IBOutlet weak var awardYearLabel: UILabel!
  @IBOutlet weak var countryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
      backgroundContainerView.layer.borderWidth = 0.5
      backgroundContainerView.layer.borderColor = UIColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func configure(_ vm: LaureatsDataModel) {
    self.nameLabel.text = vm.laureateName
    self.awardCategoryLabel.text = vm.awardCategory
    self.awardYearLabel.text = vm.awardYear
    self.countryLabel.text = vm.country
  }

  func dropShadow(scale: Bool = true) {
     layer.masksToBounds = false
     layer.shadowColor = UIColor.black.cgColor
     layer.shadowOpacity = 0.5
     layer.shadowOffset = CGSize(width: -1, height: 1)
     layer.shadowRadius = 1

     layer.shadowPath = UIBezierPath(rect: bounds).cgPath
     layer.shouldRasterize = true
     layer.rasterizationScale = scale ? UIScreen.main.scale : 1
   }
}
