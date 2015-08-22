//
//  RecipeImage.h
//  CoreDataStack
//
//  Created by Jason Lew on 8/22/15.
//  Copyright (c) 2015 Jason Lew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Recipe;

@interface RecipeImage : NSManagedObject

@property (nonatomic, retain) NSData * imageMain;
@property (nonatomic, retain) Recipe *recipe;

@end
