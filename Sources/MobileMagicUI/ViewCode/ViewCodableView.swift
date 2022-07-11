//
//  ViewCodableView.swift
//  MobileMagic
//
//  Created by Evandro Harrison Hoffmann on 18/08/2021.
//

import UIKit

/// Override `buildViewHierarchy()` and `setupConstraints()`
open class ViewCodableView: UICollectionViewCell, ViewCode {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func buildViewHierarchy() { }
    
    open func setupConstraints() { }
}
