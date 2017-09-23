//
//  UICollectionView+Layout.swift
//  HoodBook
//
//  Created by SOTSYS198 on 08/05/17.
//  Copyright © 2017 SOTSYS198. All rights reserved.
//

import Foundation

import UIKit

extension UICollectionViewLayout{

    func getLayout(atView: UIView) -> UICollectionViewFlowLayout {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: atView.bounds.width / 2, height: atView.bounds.height / 3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        
        return layout
    }


}
