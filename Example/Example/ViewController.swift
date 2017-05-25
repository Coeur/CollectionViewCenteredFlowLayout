//
//  ViewController.swift
//  Example
//
//  Created by Antoine Cœur on 09/05/2017.
//  Copyright © 2017 Giovanni Lodi. All rights reserved.
//

import UIKit

let kCellIdentifier = "CellIdentifier"
let kScrollDirectionIsHorizontal = false
let kShouldRefresh = false

class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCellIdentifier)
        
        if kScrollDirectionIsHorizontal {
            let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
            flowLayout?.scrollDirection = .horizontal
        }
        
        if kShouldRefresh {
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self.collectionView, selector: #selector(UICollectionView.reloadData), userInfo: nil, repeats: true)
            RunLoop.main.add(timer!, forMode: .defaultRunLoopMode)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 20 : 80
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier, for: indexPath)
        cell.contentView.layer.borderColor = #colorLiteral(red: 0.2039215686, green: 0.5960784314, blue: 0.8588235294, alpha: 1).cgColor
        cell.contentView.layer.borderWidth = 2
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if kScrollDirectionIsHorizontal {
            return CGSize(width: 60, height: CGFloat((arc4random() % 120) + 60))
        } else {
            return CGSize(width: CGFloat((arc4random() % 120) + 60), height: 60)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return section == 0 ? 15 : 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
