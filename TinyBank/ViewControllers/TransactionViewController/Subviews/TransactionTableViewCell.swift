//
//  TransactionTableViewCell.swift
//  TinyBank
//
//  Created by Callum Boddy on 05/07/2018.
//  Copyright © 2018 Callum Boddy. All rights reserved.
//

import UIKit
import Kingfisher

class TransactionTableViewCell: UITableViewCell {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var categoryLabel: UILabel!
    @IBOutlet private var iconImageView: UIImageView!

    static let reuseIdentifier = "TransactionTableViewCell"

    struct State {
        let title: String
        let price: String?
        let category: String
        let iconURL: URL?
    }

    func render(state: State, aniamted: Bool = false) {
        titleLabel.text = state.title
        priceLabel.text = state.price ?? ""
        categoryLabel.text = state.category
        iconImageView.kf.setImage(with: state.iconURL)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = iconImageView.frame.size.height / 2
    }
}
