//
//  Type.h
//  CoreDataStack
//
//  Created by Jason Lew on 8/21/15.
//  Copyright (c) 2015 Jason Lew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Recipe;

@interface Type : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *recipesType;
@end

@interface Type (CoreDataGeneratedAccessors)

- (void)addRecipesTypeObject:(Recipe *)value;
- (void)removeRecipesTypeObject:(Recipe *)value;
- (void)addRecipesType:(NSSet *)values;
- (void)removeRecipesType:(NSSet *)values;

@end
