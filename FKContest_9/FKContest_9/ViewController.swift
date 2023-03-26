//
//  ViewController.swift
//  FKContest_9
//
//  Created by Arthur Narimanov on 3/26/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemYellow
        return collection
    }()
    
    private var cellSize: CGSize {
        return CGSize(width: view.bounds.width - 80, height: view.bounds.width)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Collections"
        
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.frame = view.frame
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.backgroundColor = .systemBlue
        cell.layer.cornerRadius = 16
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: collectionView.layoutMargins.left, bottom: 0, right: collectionView.layoutMargins.right)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let itemWidth = cellSize.width + scrollView.layoutMargins.left
        let inertialTargetX = targetContentOffset.pointee.x
        let offsetFromPreviousPage = (inertialTargetX + scrollView.layoutMargins.left).truncatingRemainder(dividingBy: itemWidth)
        let pagedX: CGFloat
        if offsetFromPreviousPage > ceil(itemWidth / 3) {
            pagedX = ceil(inertialTargetX + itemWidth - offsetFromPreviousPage -
                          scrollView.layoutMargins.left)
        } else {
            pagedX = ceil(inertialTargetX - offsetFromPreviousPage) - scrollView.layoutMargins.left
        }
        
        targetContentOffset.pointee = CGPoint(x: pagedX, y: targetContentOffset.pointee.y)
    }
}
