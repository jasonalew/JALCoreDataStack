//
//  JALTableViewController.m
//  CoreDataStack
//
//  Created by Jason Lew on 8/21/15.
//  Copyright (c) 2015 Jason Lew. All rights reserved.
//

#import "JALTableViewController.h"
#import "JALTableViewCell.h"
#import "JALDetailViewController.h"

@interface JALTableViewController ()<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation JALTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self performFetch];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addRecipe:(id)sender {
    [self performSegueWithIdentifier:@"recipeDetailSegue" sender:sender];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return [[self.fetchedResultsController sections]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    NSArray *sections = [self.fetchedResultsController sections];
    id<NSFetchedResultsSectionInfo>sectionInfo = sections[section];
    return [sectionInfo numberOfObjects];
}

// TODO: Configure thumbnail image.

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JALTableViewCell *cell = (JALTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"RecipeCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[JALTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecipeCell"];
    }
    // Configure the cell...
    NSManagedObject *obj = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.recipeName.text = [obj valueForKey:@"name"];
    cell.recipeDescription.text = [obj valueForKey:@"desc"];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections]objectAtIndex:section];
    return [sectionInfo name];
}

#pragma mark - Fetched Results Controller

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    [self performFetch];
    
    return _fetchedResultsController;
}

- (void)performFetch {
    // Get the recipes and order by name
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Recipe"];
    
    fetchRequest.fetchBatchSize = 20;
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"type.name" ascending:YES];
    NSSortDescriptor *nameSort = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptorArray = @[sort, nameSort];
    fetchRequest.sortDescriptors = sortDescriptorArray;
    
    self.fetchedResultsController = nil;
    NSFetchedResultsController *frc =
        [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest
                                           managedObjectContext:self.managedObjectContext
                                             sectionNameKeyPath:@"type.name"
                                                      cacheName:nil];
    _fetchedResultsController = frc;
    _fetchedResultsController.delegate = self;
    
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    if (error) {
        DLog(@"Unresolved error %@\n%@", error.localizedDescription, error.userInfo);
    }
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type {
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:sectionIndex];
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
        {
            NSManagedObject *obj = [self.fetchedResultsController objectAtIndexPath:indexPath];
            JALTableViewCell *cell = (JALTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            cell.recipeName.text = [obj valueForKey:@"name"];
            cell.recipeDescription.text = [obj valueForKey:@"description"];
            break;
        }
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"recipeDetailSegue"]) {
        
        // Pass the managed object context to the detailVC.
        JALDetailViewController *detailVC = segue.destinationViewController;
        detailVC.managedObjectContext = self.managedObjectContext;
        
        // If the segue is coming from an existing object at a table cell,
        // pass the Recipe managedObjectID.
        if ([sender isKindOfClass:[UITableViewCell class]]) {
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            NSManagedObjectID *objID = [[self.fetchedResultsController objectAtIndexPath:indexPath]objectID];
            detailVC.managedObjectID = objID;  
        }
    }
}


@end
