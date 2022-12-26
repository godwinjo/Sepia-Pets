//
//  PetDetailsViewModel.swift
//  PetList
//
//  Created by Godwin on 26/12/22.
//

import Foundation

protocol PetDetailsViewModeling {
    var urlRequest: URLRequest? { get }
}


final class PetDetailsViewModel {
    
    var petDetails: PetDetails?
    
    init(petDetails: PetDetails?) {
        self.petDetails = petDetails
    }
    
    func getUrlRequest(contentUrl: String?) -> URLRequest? {
        guard let contentUrl = contentUrl,
              let url = URL(string: contentUrl) else { return nil }
        let urlRequest = URLRequest(url: url)
        return urlRequest
    }
    
}

extension PetDetailsViewModel: PetDetailsViewModeling {
    var urlRequest: URLRequest? {
        getUrlRequest(contentUrl: petDetails?.contentUrl)
    }
}
