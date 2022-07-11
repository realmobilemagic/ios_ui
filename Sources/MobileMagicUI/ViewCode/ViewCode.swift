//
//  ViewCode.swift
//  MobileMagic
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 23/03/21.
//  Copyright © 2021 MobileMagic. All rights reserved.
//

import Foundation

// MARK: - ViewCode Protocol
public protocol ViewCode {
    func buildViewHierarchy()
    func setupConstraints()
    func setupView()
    func setupAdditionalConfiguration()
}

// MARK: - Setup View method
public extension ViewCode {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}

// MARK: - Default implementation to make it `optional`
public extension ViewCode {
    func setupAdditionalConfiguration() {}
}
