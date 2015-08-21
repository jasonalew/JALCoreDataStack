//
//  RecipeIngredient.h
//  CoreDataStack
//
//  Created by Jason Lew on 8/21/15.
//  Copyright (c) 2015 Jason Lew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Recipe;

@interface RecipeIngredient : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * quantity;
@property (nonatomic, retain) NSString * unitOfMeasure;
@property (nonatomic, retain) Recipe *recipesIngredient;

@end
