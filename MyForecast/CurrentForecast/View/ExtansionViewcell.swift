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
        let times = updatedWeatherHourly.first?.time
        if let count = times?.count {
            return count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        
        let weather = updatedWeatherHourly.first
        cell.myHour.text = weather?.time[indexPath.row]
        cell.myRain.text = weather?.precipitation[indexPath.row]
        cell.myTemp.text = weather?.temperature2M[indexPath.row]
        cell.myWindSpeed.text = weather?.windspeed10M[indexPath.row]
        cell.myImage.image = UIImage(named: weather?.iconImage[indexPath.row] ?? "")

        return cell
    }
}
