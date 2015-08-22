//
//  CoreDataStackTests.m
//  CoreDataStackTests
//
//  Created by Jason Lew on 8/17/15.
//  Copyright (c) 2015 Jason Lew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "JALCoreDataStack.h"
#import "Recipe.h"
#import "RecipeIngredient.h"
#import "Type.h"

@interface CoreDataStackTests : XCTestCase

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectContext *privateContext;

@end

@implementation CoreDataStackTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    JALCoreDataStack *coreDataStack = [[JALCoreDataStack alloc]initWithInMemoryStore];
    self.managedObjectContext = coreDataStack.managedObjectContext;
    self.privateContext = coreDataStack.privateContext;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.managedObjectContext = nil;
    self.privateContext = nil;
    [super tearDown];
}

//- (void)testExample {
//    // This is an example of a functional test case.
//    XCTAssert(YES, @"Pass");
//}
//
//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

- (void)testCoreDataStack {
    Recipe *recipe = [NSEntityDescription insertNewObjectForEntityForName:@"Recipe"
                                                   inManagedObjectContext:self.managedObjectContext];
    XCTAssertNotNil(recipe, @"Couldn't create the object");
    
    Type *type = [NSEntityDescription insertNewObjectForEntityForName:@"Type"
                                               inManagedObjectContext:self.managedObjectContext];
    recipe.type = type;
    recipe.type.name = @"Desserts";
    
    XCTAssertEqual(recipe.type.name, @"Desserts");
}

@end
