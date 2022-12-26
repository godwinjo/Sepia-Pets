//
//  PetListTableViewController.swift
//  PetList
//
//  Created by Godwin on 26/12/22.
//

import UIKit

final class PetListTableViewController: UITableViewController {
    
    private enum Constants {
        static let cellIdentifier = "PetTableViewCell"
    }
    
    var viewModel: PetsListViewModeling?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PetListViewModel()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.pets?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? PetTableViewCell,
              let petDetails = viewModel?.pets?[indexPath.row] else {
            return UITableViewCell()
        }
        let image = viewModel?.getImageFromUrl(imageUrl: petDetails.imageUrl ?? "")
        cell.setValues(petDetails: petDetails, image: image)
        return cell
    }

}
