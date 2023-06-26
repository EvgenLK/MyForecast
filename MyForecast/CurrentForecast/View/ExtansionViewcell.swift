//
//  ExtansionViewcell.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 26.06.2023.
//

import Foundation
import UIKit

extension CurentWeather: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height/2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  updatedWeatherHourly.count
//        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
            let weather = updatedWeatherHourly[indexPath.row]

//        cell.myTemp.text = "not"
        cell.configure(with: weather)
        return cell
    }
}
