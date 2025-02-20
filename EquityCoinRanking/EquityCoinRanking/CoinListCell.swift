//
//  CoinListCell.swift
//  EquityCoinRanking
//
//  Created by Kag Manoj on 19/2/25.
//

import UIKit
import SDWebImageSVGCoder

class CoinListCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgCoin: UIImageView!
    @IBOutlet weak var imgFavorite: UIImageView!
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblChange: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        isUserInteractionEnabled = true // ✅ Ensure interaction is enabled
        contentView.isUserInteractionEnabled = true // ✅ Enable content view interaction
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: CoinListCell.self), bundle: nil)
    }
    
    func configure(with coin: CoinList, isFavorite: Bool) {
        lblName.text = coin.name
        // Format price to 2 decimal places
        imgFavorite.isHidden = !isFavorite
        imgFavorite.image = UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal) // ✅ Heart icon
        lblPrice.text = coin.price.formattedPrice()
        
        lblChange.text = "\(coin.change)%"
        lblChange.layer.cornerRadius = 5
        lblChange.clipsToBounds = true
        // Change background color based on value
        if let changeValue = Double(coin.change) {
            lblChange.backgroundColor = changeValue >= 0 ? UIColor.theme.green : UIColor.theme.red
        } else {
            lblChange.backgroundColor = .lightGray // Default case
        }
        if let url = URL(string: coin.iconUrl) {
            let c = url.absoluteString
            if c.fileExtension().lowercased() == "svg" {
                imgCoin.sd_setImage(with: url,
                                    placeholderImage: nil,
                                    context: [.imageCoder: CustomSVGDecoder(fallbackDecoder: SDImageSVGCoder.shared)])
            } else {
                imgCoin.sd_setImage(with: url)
            }
        }
    }
}
