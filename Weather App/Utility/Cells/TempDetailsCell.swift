//
//  TempDetailsCell.swift
//  Weather App
//
//  Created by Akshay  Chavan on 31/03/21.
//

import UIKit

class TempDetailsCell: UITableViewCell,UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet private weak var collectionView: UICollectionView!
    var dataArray:[CityViewModel]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        let nib = UINib(nibName: "WeatherCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CollectionCell")
                if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                    let viewController = UIApplication.shared.windows.first!.rootViewController!
                    flowLayout.itemSize = CGSize(width: viewController.view.bounds.width, height: self.collectionView.bounds.height)
                    flowLayout.minimumInteritemSpacing = 0
                    flowLayout.minimumLineSpacing = 0
                }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func reloadCollectionView()  {
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath as IndexPath) as! WeatherCollectionViewCell
        if let obj = dataArray?[indexPath.row] {
            cell.fiveDayViewModel = obj
        }
        return cell
    }
}

