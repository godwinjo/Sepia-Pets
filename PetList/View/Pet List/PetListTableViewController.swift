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
        static let storyboardIdentifier = "PetDetailsViewController"
    }
    
    var viewModel: PetsListViewModeling?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PetListViewModel()
        viewModel?.checkThisWorkingHour(completion: { status in
            if !status {
                self.showAlert()
            }
        })
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "This not working hours", message: "Please use this only in working hours", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let petDetailsVc = self.storyboard?.instantiateViewController(withIdentifier: Constants.storyboardIdentifier) as? PetDetailsViewController,
              let petDetails = viewModel?.pets?[indexPath.row] else { return }
        let viewModel = PetDetailsViewModel(petDetails: petDetails)
        petDetailsVc.viewModel = viewModel
        navigationController?.pushViewController(petDetailsVc, animated: true)
    }

}
