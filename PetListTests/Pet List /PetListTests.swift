//
//  PetListTests.swift
//  PetListTests
//
//  Created by Godwin on 26/12/22.
//

import XCTest
@testable import PetList

class PetListTests: XCTestCase {
    
    var viewModel: PetListViewModel!

    override func setUpWithError() throws {
        viewModel = PetListViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testgetUrlFromFileSuccess() {
        let fileName = "pets_list"
        let extensionName = ".json"
        let url = viewModel.getUrlFromFile(fileName: fileName, extensionName: extensionName)
        XCTAssertNotNil(url)
    }
    
    func testgetUrlFromFileFailure() {
        let fileName = "pets"
        let extensionName = ".json"
        let data = viewModel.getUrlFromFile(fileName: fileName, extensionName: extensionName)
        XCTAssertNil(data)
    }
    
    func testGetDataFromUrlSuccess() {
        let fileName = "pets_list"
        let extensionName = ".json"
        guard let url = viewModel.getUrlFromFile(fileName: fileName, extensionName: extensionName) else { return }
        let data = viewModel?.getDataFromUrl(url: url)
        XCTAssertNotNil(data)
    }
    
    func testGetDataFromUrlFailure() {
        guard let url = URL(string: "http://abc/abc") else { return }
        let data = viewModel.getDataFromUrl(url: url)
        XCTAssertNil(data)
    }
    
    func testDownloadImageFromUrlSuccess() {
        guard let imageUrl = viewModel.pets?[0].imageUrl else { return }
        let image = viewModel.downloadImageFromUrl(imageUrl: imageUrl)
        XCTAssertNotNil(image)
    }
    
    func testDownloadImageFromUrlFailure() {
        let imageUrl = "http://abc/abc"
        let image = viewModel.downloadImageFromUrl(imageUrl: imageUrl)
        XCTAssertNil(image)
    }
    
    func testGetPetListSuccess() {
        let expectation = self.expectation(description: "getting items from json file")
        viewModel.getPetsList( fileName: "pets_list", extensionName: ".json", completion: { pet in
            XCTAssertNotNil(pet)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 1) { (error) in
            if let eror = error {
                print(eror)
            }
        }
    }
    
    func testGetPetListFailure() {
        let expectation = self.expectation(description: "getting items from json file")
        viewModel.getPetsList( fileName: "pets", extensionName: ".json", completion: { pet in
            XCTAssertNil(pet)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 1) { (error) in
            if let eror = error {
                print(eror)
            }
        }
    }
    
    func testGetConfigDetailsSuccess() {
        let expectation = self.expectation(description: "getting items from json file")
        viewModel.getPetsList( fileName: "config", extensionName: ".json", completion: { pet in
            XCTAssertNotNil(pet)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 1) { (error) in
            if let eror = error {
                print(eror)
            }
        }
    }
    
    func testGetConfigDetailsFailure() {
        let expectation = self.expectation(description: "getting items from json file")
        viewModel.getPetsList( fileName: "conf", extensionName: ".json", completion: { pet in
            XCTAssertNil(pet)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 1) { (error) in
            if let eror = error {
                print(eror)
            }
        }
    }
    
    func testChekIfCurrentTimeIsBetweenSuccess() {
        let startTime = "9:00"
        let endTime = "18:00"
        let value = viewModel.checkIfCurrentTimeIsBetween(startTime: startTime, endTime: endTime)
        XCTAssertTrue(value)
    }
    
    func testChekIfCurrentTimeIsBetweeenFailure() {
        let startTime = "9:00"
        let endTime = ""
        let value = viewModel.checkIfCurrentTimeIsBetween(startTime: startTime, endTime: endTime)
        XCTAssertFalse(value)
    }
    
    func testGetStartAndEntTimeSuccess() {
        let workHours = "M-F 9:00 - 18:00"
        let (startTime, endTime) = viewModel.getStartAndEntTime(workHours: workHours) ?? ("", "")
        XCTAssertNotNil((startTime, endTime))
    }
    
    func testGetStartAndEntTimeFailure() {
        let workHours = "M-F 9:00 - "
        let (startTime, endTime) = viewModel.getStartAndEntTime(workHours: workHours) ?? ("", "")
        XCTAssertTrue(startTime.isEmpty)
        XCTAssertTrue(endTime.isEmpty)
    }
    
    func testCheckIsThisWorkingHourSuccess() {
        let expectation = self.expectation(description: "getting items from json file")
        viewModel.checkIsThisWorkingHour { status in
            XCTAssertNotNil(status)
            XCTAssertTrue(status)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1) { (error) in
            if let eror = error {
                print(eror)
            }
        }
    }

}
