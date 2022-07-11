//
//  File.swift
//  
//
//  Created by Evandro Harrison Hoffmann on 19/08/2021.
//

import UIKit

/// Remember to override `registerCells()`
open class VerticalCollectionViewController: UIViewController, ViewCode {
    open lazy var collectionView: UICollectionView = {
        var collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.delegate = self as? UICollectionViewDelegate
        collectionView.dataSource = self as? UICollectionViewDataSource
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerCells()
    }
    
    open func buildViewHierarchy() {
        view.addSubview(collectionView)
    }
    
    open func setupConstraints() {
        collectionView.pinEdgesToSuperview()
    }
    
    /// Register custom cells
    open func registerCells() { }
}
