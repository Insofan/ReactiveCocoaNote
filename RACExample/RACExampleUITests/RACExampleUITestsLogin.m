//
//  RACExampleUITestsLogin.m
//  RACExampleUITests
//
//  Created by 海啸 on 2017/11/11.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface RACExampleUITestsLogin : XCTestCase

@end

@implementation RACExampleUITestsLogin

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

- (void)testLogin {
    // Use recording to get started writing UI tests.
    
    XCUIApplication *app = [[XCUIApplication alloc] init];

    [app.tables.staticTexts[@"3 \u767b\u5f55\u754c\u9762"] tap];
    XCUIElement *element = [[[[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"3 \u767b\u5f55\u754c\u9762"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element;
    XCUIElement *textField = [[element childrenMatchingType:XCUIElementTypeTextField] elementBoundByIndex:0];
    [textField tap];
    [textField typeText:@"Insofan"];
    sleep(1);
    
    XCUIElement *textField2 = [[element childrenMatchingType:XCUIElementTypeTextField] elementBoundByIndex:1];
    [textField2 tap];
    [textField2 typeText:@"I'm happy"];
    sleep(2);
    [app.buttons[@"Login"] tap];
   
}

@end
