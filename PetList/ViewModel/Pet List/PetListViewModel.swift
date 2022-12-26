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
    func checkThisWorkingHour(completion: @escaping ((Bool)-> ()))
}

final class PetListViewModel {
    
    private enum Constants {
        static let fileNamePets = "pets_list"
        static let fileNameConfig = "config"
        static let jsonExtension = ".json"
        static let pattern = "^[A-Z]-[A-Z]\\s{1}(\\d{1,2}:\\d{2})\\s{1}-\\s{1}(\\d{1,2}:\\d{2})$"
    }
    
    var pet: Pet?
    
    func checkIsThisWorkingHour(completion: ((Bool)-> ())? = nil)  {
        getConfigDetails(fileName: Constants.fileNameConfig, extensionName: Constants.jsonExtension) { config in
            guard let workHours = config?.settings?.workHours,
                  let (startTime, endTime) = self.getStartAndEntTime(workHours: workHours)else { return }
            
            if self.checkIfCurrentTimeIsBetween(startTime: startTime, endTime: endTime) {
                completion?(true)
                self.getPetsList(fileName: Constants.fileNamePets, extensionName: Constants.jsonExtension) { pet in
                    guard let pet = pet else { return }
                    self.pet = pet
                }
            }
            else {
                completion?(false)
            }
        }
    }
    
    func getStartAndEntTime(workHours: String)-> (startTime: String, endTime: String)? {
        let regex = try? NSRegularExpression(pattern: Constants.pattern)
        if let match = regex?.matches(in: workHours, range: .init(workHours.startIndex..., in: workHours)).first,
            match.numberOfRanges == 3 {
            let start = match.range(at: 1)
            let end = match.range(at: 2)
            guard let startRange = Range(start, in: workHours),
                  let endRange = Range(end, in: workHours) else { return nil }
            let startTime = (workHours[startRange])
            let endTime = (workHours[endRange])
            return (String(startTime), String(endTime))
        }
        return nil
    }
    
    func checkIfCurrentTimeIsBetween(startTime: String, endTime: String) -> Bool {
        guard let start = Formatter.today.date(from: startTime),
              let end = Formatter.today.date(from: endTime) else {
            return false
        }
        return DateInterval(start: start, end: end).contains(Date())
    }
    
    func getConfigDetails(fileName: String, extensionName: String, completion: ((Config?)-> ())? = nil) {
        guard let sourcesUrl = getUrlFromFile(fileName: fileName, extensionName: extensionName),
              let configData = getDataFromUrl(url: sourcesUrl) else {
            completion?(nil)
            return
        }
        let decoder = JSONDecoder()
        do {
            let config = try decoder.decode(Config.self, from: configData)
            completion?(config)
        } catch let error {
            print(error.localizedDescription)
            completion?(nil)
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
    func checkThisWorkingHour(completion: @escaping ((Bool) -> ())) {
        checkIsThisWorkingHour(completion: completion)
    }
    
    var pets: [PetDetails]? {
        pet?.pets
    }
    
    func getImageFromUrl(imageUrl: String) -> UIImage? {
        downloadImageFromUrl(imageUrl: imageUrl)
    }
}
