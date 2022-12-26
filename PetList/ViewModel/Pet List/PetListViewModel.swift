//
//  PetListViewModel.swift
//  PetList
//
//  Created by Godwin on 26/12/22.
//

import Foundation
import UIKit

protocol PetsListViewModeling {
    var pets: [PetDetails]? { get }
    
    func getImageFromUrl(imageUrl: String) -> UIImage?
}

final class PetListViewModel {
    
    private enum Constants {
        static let fileNamePets = "pets_list"
        static let jsonExtension = ".json"
        static let dataConversionErrorMessage = "Could't convert to data"
    }
    
    var pet: Pet?
    
    init() {
        getPetsList(fileName: Constants.fileNamePets, extensionName: Constants.jsonExtension) { pet in
            guard let pet = pet else { return }
            self.pet = pet
        }
    }
    
    func getPetsList(fileName: String, extensionName:String, completion: ((Pet?)-> ())? = nil ) {
        guard let sourcesUrl = getUrlFromFile(fileName: fileName, extensionName: extensionName),
              let petData = getDataFromUrl(url: sourcesUrl) else {
            completion?(nil)
            return
        }
        let decoder = JSONDecoder()
        do {
            let petsDetails = try decoder.decode(Pet.self, from: petData)
            completion?(petsDetails)
        } catch let error {
            print(error.localizedDescription)
            completion?(nil)
        }
    }
}

extension PetListViewModel {

    func getUrlFromFile(fileName: String, extensionName: String) -> URL? {
        guard let sourcesUrl = Bundle.main.url(forResource: fileName, withExtension: extensionName) else {
            return nil
        }
        return sourcesUrl
    }
    
    func getDataFromUrl(url: URL) -> Data? {
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        return data
    }
    
    func downloadImageFromUrl(imageUrl: String) -> UIImage? {
        guard let url = URL(string: imageUrl), let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {
            return nil
        }
        return image
    }
    
    
}

extension PetListViewModel: PetsListViewModeling {
    var pets: [PetDetails]? {
        pet?.pets
    }
    
    func getImageFromUrl(imageUrl: String) -> UIImage? {
        downloadImageFromUrl(imageUrl: imageUrl)
    }
}
