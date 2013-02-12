//
//  ABNewContactViewController.m
//  iAddressBook
//
//  Created by Farooq Ahmed on 2/11/13.
//  Copyright (c) 2013 Arbisoft. All rights reserved.
//

#import "ABNewContactViewController.h"

@interface ABNewContactViewController ()

@end

@implementation ABNewContactViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [upperTable release];
    [lowerTable release];
    [super dealloc];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger tableSec = 0;
    if ([tableView isEqual:upperTable]) {
        tableSec = 1;
    }
    else if ([tableView isEqual:lowerTable]) {
        tableSec = 3;
    }
    return tableSec;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger tableRows = 0;
    if ([tableView isEqual:upperTable]) {
        tableRows = 3;
    }
    else if ([tableView isEqual:lowerTable]) {
        tableRows = 1;
    }
    return tableRows;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSInteger indexPathRow = [indexPath row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if ([tableView isEqual:upperTable]) {
        UITextField *textField = [[[UITextField alloc] initWithFrame:CGRectMake(0, 0, 160, 21)] autorelease];
        if (indexPathRow == 0) {
            [textField setPlaceholder:@"First"];
        }
        else if (indexPathRow == 1) {
            [textField setPlaceholder:@"Last"];
        }
        else if (indexPathRow == 2) {
            [textField setPlaceholder:@"Company"];
        }
        cell.accessoryView = textField;
    }
    else if ([tableView isEqual:lowerTable]) {
        cell.accessoryView = [[[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 21)] autorelease];
    }

    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
//        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
//        
//        NSError *error = nil;
//        if (![context save:&error]) {
//            // Replace this implementation with code to handle the error appropriately.
//            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//            abort();
//        }
//    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (!self.detailViewController) {
//        self.detailViewController = [[[ABDetailViewController alloc] initWithNibName:@"ABDetailViewController" bundle:nil] autorelease];
//    }
//    NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
//    self.detailViewController.detailItem = object;
//    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

@end
