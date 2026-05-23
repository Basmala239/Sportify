//
//  SportsViewController.swift
//  Sportify
//
//  Created by Esraa Ehab on 22/05/2026.
//

import UIKit

class SportsViewController: UIViewController , SportsViewProtocol{

    @IBOutlet weak var sportsCollectionView: UICollectionView!
    
    var presenter: SportsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SportsPresenter(view: self)
        setupCollectionView()
        presenter.viewDidLoad()
    }
    
    func setupCollectionView(){
        let nib =  UINib(nibName: "SportsCollectionViewCell", bundle: nil)
        sportsCollectionView.register(nib,forCellWithReuseIdentifier: "sportCell")
        
        sportsCollectionView.delegate = self
        sportsCollectionView.dataSource = self
        
        sportsCollectionView.delaysContentTouches = false
    }
    
    func reloadData() {
            sportsCollectionView.reloadData()
        }
}

extension SportsViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing : CGFloat = 16+16+16
        let width = (collectionView.bounds.width - totalSpacing)/2
        
        return CGSize(width: width, height: width * 1.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 16
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 16
        }
}


extension SportsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getSportsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportCell", for: indexPath) as! SportsCollectionViewCell
        let currentSport = presenter.getSportItem(at: indexPath.item)
        cell.configure(with: currentSport)
        return cell
    }
}
