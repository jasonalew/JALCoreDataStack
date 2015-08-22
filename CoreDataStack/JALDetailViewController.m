//
//  JALDetailViewController.m
//  CoreDataStack
//
//  Created by Jason Lew on 8/21/15.
//  Copyright (c) 2015 Jason Lew. All rights reserved.
//

#import "JALDetailViewController.h"
#import "Recipe.h"
#import "Type.h"
#import "AppDelegate.h"
#import "JALCoreDataStack.h"


@interface JALDetailViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *typeTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;

@end

@implementation JALDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [self addRecipe];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addRecipe {
    Recipe *newRecipe = [NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext:self.managedObjectContext];
    newRecipe.name = self.nameTextField.text;
    newRecipe.desc = self.descriptionTextField.text;
    Type *newType = [NSEntityDescription insertNewObjectForEntityForName:@"Type" inManagedObjectContext:self.managedObjectContext];
    newType.name = self.typeTextField.text;
    [newType addRecipesTypeObject:newRecipe];
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    JALCoreDataStack *coreDataStack = appDelegate.coreDataStack;
    [coreDataStack saveContext:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
