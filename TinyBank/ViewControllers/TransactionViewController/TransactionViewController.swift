//
//  ViewController.swift
//  TinyBank
//
//  Created by Callum Boddy on 05/07/2018.
//  Copyright © 2018 Callum Boddy. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var transactions: [Transaction] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        TransactionCient().fetch { (result) in
            if let transactions = try? result.value() {
                self.transactions = transactions
            }
        }
    }

    @IBAction func didSelectEditBarButtonItem(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
}

extension TransactionViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.transactions.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension TransactionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.reuseIdentifier, for: indexPath) as? TransactionTableViewCell else {
            fatalError()
        }

        let transaction = transactions[indexPath.row]
        let price = PriceFormatter.format(value: transaction.amount.value, currencyISO: transaction.amount.currencyISO)
        let state = TransactionTableViewCell.State(title: transaction.description, price: price, category: transaction.categoryIdentifier.description, iconURL: transaction.product.imageURL)
        cell.render(state: state)

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return transactions.count
    }
}

