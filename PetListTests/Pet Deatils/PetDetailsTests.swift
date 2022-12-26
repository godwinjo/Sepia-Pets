//
//  PetDetailsTests.swift
//  PetListTests
//
//  Created by Godwin on 27/12/22.
//

import XCTest
@testable import PetList

class PetDetailsTests: XCTestCase {
    
    var viewModel: PetDetailsViewModel?

    override func setUpWithError() throws {
        initiateViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func initiateViewModel() {
        let petDetails = PetDetails(title: "Cat",
                                    contentUrl: "https://en.wikipedia.org/wiki/Cat",
                                    imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Cat_poster_1.jpg/1200px-Cat_poster_1.jpg",
                                    dateAdded: "2018-06-06T08:36:16.027Z"
        )
        viewModel = PetDetailsViewModel(petDetails: petDetails)
    }
    
    func testGetUrlRequestSuccess() {
        let contntUrl = "https://en.wikipedia.org/wiki/Cat"
        let urlrequest = viewModel?.getUrlRequest(contentUrl: contntUrl)
        XCTAssertNotNil(urlrequest)
    }
    
    func testGetUrlRequestFailure() {
        let contntUrl = ""
        let urlrequest = viewModel?.getUrlRequest(contentUrl: contntUrl)
        XCTAssertNil(urlrequest)
    }

}
