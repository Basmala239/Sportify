//
//  CustemTableViewCell.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 20/05/2026.
//
import UIKit
import SDWebImage

class CustemTableViewCell: UITableViewCell {

    @IBOutlet weak var leaguesImage: UIImageView!
    @IBOutlet weak var leaguesTitle: UILabel!
    @IBOutlet weak var leaguesCountry: UILabel!
    @IBOutlet weak var leaguesView: UIView!
    @IBOutlet weak var imgView: UIView!
    
    private let placeholderImage = UIImage(named: "leaguse_placeholder")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        leaguesView.layer.cornerRadius = 20.0
        leaguesView.clipsToBounds = true
        
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4.0
        contentView.layer.shadowOpacity = 0.05
        contentView.layer.masksToBounds = false
        
       backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .appBackground
        backgroundView.layer.cornerRadius = 20.0
        self.backgroundView = backgroundView
    }
    
    override func layoutSubviews() {
        self.contentView.layoutIfNeeded()
        super.layoutSubviews()
        
        imgView.layer.cornerRadius = imgView.frame.size.width / 2
        leaguesImage.layer.cornerRadius = leaguesImage.frame.size.width / 2
        leaguesImage.clipsToBounds = true
        
        let shadowRect = contentView.bounds.insetBy(dx: 4, dy: 2)
        contentView.layer.shadowPath = UIBezierPath(roundedRect: shadowRect, cornerRadius: 20.0).cgPath
        leaguesView.addCustomCardBorders(color: .appPrimary, thickness: 3.0, radius: 20.0)
    }
    
    func configure(with favorite: Favorite) {
        leaguesTitle.text = favorite.name
        leaguesCountry.text = favorite.countary
        loadImage(from: favorite.image)
    }
    
    func configure(with league: League) {
        leaguesTitle.text = league.leagueName
        leaguesCountry.text = league.countryName ?? "No Country name".localized
        loadImage(from: league.leagueLogo)
    }
    
    private func loadImage(from urlString: String?) {
        leaguesImage.sd_cancelCurrentImageLoad()
        
        leaguesImage.contentMode = .scaleAspectFit
        leaguesImage.tintColor = .systemGray3
        
        guard let urlString = urlString,
              let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            leaguesImage.image = placeholderImage
            return
        }
        
        leaguesImage.sd_setImage(with: url, placeholderImage: placeholderImage) { [weak self] (image, error, cacheType, url) in
            guard let self = self else { return }
            if error != nil {
                self.leaguesImage.image = self.placeholderImage
            } else {
                self.leaguesImage.contentMode = .scaleAspectFill
            }
        }
    }
}
