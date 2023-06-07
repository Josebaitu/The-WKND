//
//  ClothesTableViewController.swift
//  The-WKND
//
//  Created by Eneko Díaz Romero on 7/6/23.
//

import UIKit

class ClothesTableViewController: UITableViewController {

    let api = URL(string: "https://some-api-of-your.choice")
    var clothes = [Clothing]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        getClothes()
    }

    func getClothes() {
        // Note this is just a placeholder:
        clothes = [
            .init(id: "1", imageURL: URL(string: "https://picsum.photos/200")!, name: "Shirt"),
            .init(id: "2", imageURL: URL(string: "https://picsum.photos/200")!, name: "Skirt"),
            .init(id: "3", imageURL: URL(string: "https://picsum.photos/200")!, name: "Jacket")
        ]
        tableView.reloadData()
        // TODO: make network request to get clothes
        // When request finishes, convert the response into [Clothing] array
        // and reload table data with tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension ClothesTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clothes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let clothing = clothes[indexPath.row]
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "clothingCell"),
            let imageData = try? Data(contentsOf: clothing.imageURL)
        else {
            return UITableViewCell()
        }
        var content = cell.defaultContentConfiguration()
        content.image = UIImage(data: imageData)
        content.text = clothing.name
        cell.contentConfiguration = content
        return cell
    }
}
