//
//  RACExampleUITests.m
//  RACExampleUITests
//
//  Created by 海啸 on 2017/11/11.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface RACExampleUITests : XCTestCase

@end

@implementation RACExampleUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testMovieAndAdd {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"7 MVVM\u5e94\u7528\u4e00"] tap];
    sleep(5);
    [app.navigationBars[@"7 MVVM\u5e94\u7528\u4e00"].buttons[@"RAC Example"] tap];
    [tablesQuery.staticTexts[@"2 \u52a0\u6cd5\u8ba1\u6570\u5668"] tap];

    XCUIElement *number0TextField = app.textFields[@"Number 0"];
    [number0TextField tap];
    
    XCUIElement *moreKey = app/*@START_MENU_TOKEN@*/.keys[@"more"]/*[[".keyboards",".keys[@\"more, numbers\"]",".keys[@\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/;
    [moreKey tap];
    [moreKey tap];
    [number0TextField typeText:@"4"];
    
    XCUIElement *number1TextField = app.textFields[@"Number 1"];
    [number1TextField tap];
    [moreKey tap];
    [moreKey tap];
    [number1TextField typeText:@"6"];
    
    XCUIElement *number2TextField = app.textFields[@"Number 2"];
    [number2TextField tap];
    [moreKey tap];
    [moreKey tap];
    [number2TextField typeText:@"8"];
    sleep(2);
    [app.navigationBars[@"2 \u52a0\u6cd5\u8ba1\u6570\u5668"].buttons[@"RAC Example"] tap];
    
}

@end
