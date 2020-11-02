//
//  FSTargetingManagerTest.swift
//  FlagshipTests
//
//  Created by Adel on 28/05/2020.
//  Copyright © 2020 FlagShip. All rights reserved.
//

import XCTest
@testable import Flagship

class FSTargetingManagerTest: XCTestCase {
    
    
    var targetingManager:FSTargetingManager!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
         targetingManager = FSTargetingManager()
        
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
 

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    func testisTargetingGroupIsOkay(){
        /// test with nil entry
         XCTAssertFalse(targetingManager.isTargetingGroupIsOkay(nil))
    }
    
    
    ///     func checkCondition(_ cuurentValue:Any, _ operation:FSoperator, _ audienceValue:Any)->Bool{

    func testCheckCondition(){
        
        XCTAssertTrue(targetingManager.checkCondition(12, .EQUAL, 12))
        XCTAssertFalse(targetingManager.checkCondition(12, .EQUAL, 121))

        
        XCTAssertTrue(targetingManager.checkCondition("aaaa", .EQUAL, "aaaa"))
        XCTAssertFalse(targetingManager.checkCondition("aaaa", .EQUAL, "aaaav"))
        
        
        XCTAssertTrue(targetingManager.isGreatherThan(type: Int.self, a: 13, b: 12))
        XCTAssertFalse(targetingManager.isGreatherThan(type: Int.self, a: 10, b: 12))

        
        XCTAssertTrue(targetingManager.isGreatherThanorEqual(type: Int.self, a: 12, b: 12))
        XCTAssertFalse(targetingManager.isGreatherThanorEqual(type: Int.self, a: 10, b: 12))
        
        XCTAssertTrue(targetingManager.isEqual(type: Int.self, a: 12, b: 12))
        XCTAssertFalse(targetingManager.isEqual(type: Int.self, a: 14, b: 12))
        
        XCTAssertTrue(targetingManager.isEqual(type: String.self, a: "abc", b: "abc"))
        
        do {
            
            try XCTAssertTrue(targetingManager.isCurrentValueContainAudience("121111111", "12111"))
            
            try XCTAssertFalse(targetingManager.isCurrentValueContainAudience("AZAZAZA", "12111"))

        }
        
    }
    
    
    func testcheckCondition(){
        
        //  func checkCondition(_ cuurentValue:Any, _ operation:FSoperator, _ audienceValue:Any)->Bool{
        
        for itemOperator in FSoperator.allCases {
            
            let ret = targetingManager.checkCondition(12, itemOperator, 12)
            
            let retBis = targetingManager.checkCondition("12", itemOperator, "12")
            
            let retTer = targetingManager.checkCondition("12", itemOperator, 12)
            
            let retFour = targetingManager.checkCondition(Date(), itemOperator, Data())
            
            let retDouble = targetingManager.checkCondition(0.123456789123456789, itemOperator, 0.923456789123456789)
            
            let retDoubleBis = targetingManager.checkCondition(0.923456789123456789, itemOperator, 0.123456789123456789)

            



            
            switch itemOperator
            {
            case .EQUAL:
                XCTAssertTrue(ret)
                XCTAssertTrue(retBis)
                XCTAssertFalse(retTer)
                XCTAssertFalse(retFour)
                XCTAssertFalse(retDouble)
                XCTAssertFalse(retDoubleBis)




                break
            case .GREATER_THAN:
                XCTAssertFalse(ret)
                XCTAssertFalse(retBis)
                XCTAssertFalse(retTer)
                XCTAssertFalse(retFour)
                XCTAssertFalse(retDouble)
                XCTAssertTrue(retDoubleBis)




                break
            case .GREATER_THAN_OR_EQUALS:
                XCTAssertTrue(ret)
                XCTAssertTrue(retBis)
                XCTAssertFalse(retTer)
                XCTAssertFalse(retFour)
                XCTAssertFalse(retDouble)
                XCTAssertTrue(retDoubleBis)





                break
            case .NOT_EQUAL:
                XCTAssertFalse(ret)
                XCTAssertFalse(retBis)
                XCTAssertTrue(retTer)
                XCTAssertFalse(retFour)
                XCTAssertTrue(retDouble)
                XCTAssertTrue(retDoubleBis)



                break
            case .LOWER_THAN:
                XCTAssertFalse(ret)
                XCTAssertFalse(retBis)
                XCTAssertFalse(retTer)
                XCTAssertFalse(retFour)
                XCTAssertTrue(retDouble)
                XCTAssertFalse(retDoubleBis)



                break
            case .LOWER_THAN_OR_EQUALS:
                
                XCTAssertTrue(retBis)
                XCTAssertTrue(ret)
                XCTAssertFalse(retTer)
                XCTAssertFalse(retFour)
                XCTAssertTrue(retDouble)
                XCTAssertFalse(retDoubleBis)



                break
            case .CONTAINS:
                
                XCTAssertTrue(retBis)
                XCTAssertFalse(ret)
                XCTAssertFalse(retTer)
                XCTAssertFalse(retFour)
                XCTAssertFalse(retDouble)
                XCTAssertFalse(retDoubleBis)



                break
            case .NOT_CONTAINS:
                 XCTAssertFalse(retBis)
                 XCTAssertFalse(ret)
                 XCTAssertFalse(retTer)
                 XCTAssertFalse(retFour)
                 XCTAssertFalse(retDouble)
                 XCTAssertFalse(retDoubleBis)


                break
            case .Unknown:
                break
                
            }
            
        }
    }
    
    
    func testSsCurrentValueIsGreaterThanAudience(){
        
        do{
            
            let ret = try  targetingManager.isCurrentValueIsGreaterThanAudience("val", "val_audience")
            
            XCTAssertFalse(ret)
            
            let retbis = try  targetingManager.isCurrentValueIsGreaterThanAudience(12, 10)
            
            XCTAssertTrue(retbis)
            
            
            let retTer = try  targetingManager.isCurrentValueIsGreaterThanAudience(Data(), Date())

             XCTAssertFalse(retTer)

        }catch{
            
           
        }
    }
    
    func testIsCurrentValueIsGreaterThanOrEqualAudience(){
        
        do{
            
            let ret = try  targetingManager.isCurrentValueIsGreaterThanOrEqualAudience("val", "val_audience")
            
            XCTAssertFalse(ret)
            
            let ret1 = try  targetingManager.isCurrentValueIsGreaterThanOrEqualAudience("val", "val")

            XCTAssertTrue(ret1)
            
            
            let retbis = try  targetingManager.isCurrentValueIsGreaterThanOrEqualAudience(12, 10)
            
            XCTAssertTrue(retbis)
            
            let ret2 = try  targetingManager.isCurrentValueIsGreaterThanOrEqualAudience(12, 12)

            XCTAssertTrue(ret2)

            
            
            let retTer = try  targetingManager.isCurrentValueIsGreaterThanOrEqualAudience(Data(), Date())

             XCTAssertFalse(retTer)

        }catch{
            
           
        }
    }
    
    
    func testIsCurrentValueContainAudience(){
        
        do{
            
            let ret = try  targetingManager.isCurrentValueContainAudience("val", "val_audience")
            
            XCTAssertFalse(ret)
            
            let ret1 = try  targetingManager.isCurrentValueContainAudience("val", "val")

            XCTAssertTrue(ret1)
            
            
            let retTer = try  targetingManager.isCurrentValueContainAudience("value", "val")
            
            XCTAssertTrue(retTer)
            
            
            
            
            do {
                
                try  targetingManager.isCurrentValueContainAudience(12, 10)
                
            }catch{
                
                XCTAssertEqual(error as! FStargetError, FStargetError.unknownType)
            }
            
            do {
                try  targetingManager.isCurrentValueContainAudience(12, "12")
                
            }catch{
                
                XCTAssertEqual(error as! FStargetError, FStargetError.unknownType)

            }
            
            
        }catch{
            
        }
        
    }
    
    
    func testGetCurrentValueFromCtx(){
        
        Flagship.sharedInstance.visitorId = "alias"
        
        if let ret = targetingManager.getCurrentValueFromCtx(FS_USERS) as? String{
            
            XCTAssertTrue(ret == "alias")
        }
    }

    
    func testCheckTargetGroupIsOkay(){
        
        /// read the data from the file and fill the campaigns
        do {
            
            let testBundle = Bundle(for: type(of: self))

            guard let path = testBundle.url(forResource: "targetings", withExtension: "json") else { return  }
            
            let data = try Data(contentsOf: path, options:.alwaysMapped)
            
            let targetObject = try JSONDecoder().decode(FSTargeting.self, from: data)
            
            print(targetObject)
            
            
            Flagship.sharedInstance.visitorId = "alias"   /// Visitor id

            Flagship.sharedInstance.updateContext("basketNumber", 100) /// belong to first group
            
            Flagship.sharedInstance.updateContext("basketNumberBis", 200)  /// belong to second group
            
            Flagship.sharedInstance.updateContext("testkey6", "gamaa")  /// belong to second group
            
            Flagship.sharedInstance.updateContext("testkey7", "abbc")  /// belong to second group
            
            Flagship.sharedInstance.updateContext("testkey8", "yahoo.fr")  /// belong to second group
            
            Flagship.sharedInstance.updateContext("testkey9", 12)  /// belong to second group


            
            if let item = targetObject.targetingGroups.first {
                
                let ret = targetingManager.checkTargetGroupIsOkay(item)
                
                XCTAssertFalse(ret)
            }
            
            if let itemBis = targetObject.targetingGroups.last {
                
                let retBis = targetingManager.checkTargetGroupIsOkay(itemBis)
                
                XCTAssertTrue(retBis)
            }
            
        }catch{
            
            print("error")
        }
    }

}
