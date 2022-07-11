//
//  ViewCodableTableViewController.swift
//  MobileMagic
//
//  Created by Evandro Harrison Hoffmann on 23/08/2021.
//

import UIKit

/// Remember to override `registerCells()`
open class ViewCodableTableViewController: UIViewController, ViewCode {
    open lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self as? UITableViewDelegate
        tableView.dataSource = self as? UITableViewDataSource
        tableView.backgroundColor = .clear
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorInset = .zero
        tableView.separatorColor = .clear
        return tableView
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerCells()
    }
    
    open func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    open func setupConstraints() {
        tableView.pinEdgesToSuperview()
    }
    
    /// Register custom cells
    open func registerCells() { }
}
