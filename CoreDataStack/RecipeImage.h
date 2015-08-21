//
//  RecipeImage.h
//  CoreDataStack
//
//  Created by Jason Lew on 8/21/15.
//  Copyright (c) 2015 Jason Lew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Recipe;

@interface RecipeImage : NSManagedObject

@property (nonatomic, retain) NSData * imageMain;
@property (nonatomic, retain) NSSet *recipesImage;
@end

@interface RecipeImage (CoreDataGeneratedAccessors)

- (void)addRecipesImageObject:(Recipe *)value;
- (void)removeRecipesImageObject:(Recipe *)value;
- (void)addRecipesImage:(NSSet *)values;
- (void)removeRecipesImage:(NSSet *)values;

@end
