//
//  ViewCodableTableViewCell.swift
//  MobileMagic
//
//  Created by Evandro Harrison Hoffmann on 23/08/2021.
//

import UIKit

/// Override `buildViewHierarchy()` and `setupConstraints()`
open class ViewCodableTableViewCell: UITableViewCell, Reusable, ViewCode {
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func buildViewHierarchy() { }
    
    open func setupConstraints() { }
}
