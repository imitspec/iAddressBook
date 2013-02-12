//
//  ABAddContactViewController.m
//  iAddressBook
//
//  Created by Farooq Ahmed on 2/11/13.
//  Copyright (c) 2013 Arbisoft. All rights reserved.
//

#import "ABAddContactViewController.h"
#import "CoreData/CoreData.h"
#import "ABUtils.h"

@interface ABAddContactViewController ()
- (void)insertNewObject;
- (BOOL)fieldValidation;

@end

@implementation ABAddContactViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"New Contact", @"New Contact");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.managedObjectContext = [ABUtils currentManagedContext];
    isChangesMade_ = NO;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStylePlain target:self action:@selector(doneBtnAction)];
    
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelBtnAction)] autorelease];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

- (BOOL)fieldValidation
{
    BOOL isValid = YES;
    NSString *err = @"unknown error";
    if ([first_name.text isEqualToString:@""]) {
        isValid = NO;
        err= @"First Name is Required";
    }
    else if ([last_name.text isEqualToString:@""]) {
        isValid = NO;
        err= @"Last Name is Required";
    }
    else if ([company.text isEqualToString:@""]) {
        isValid = NO;
        err= @"Company Name is Required";
    }
    else if ([mobile.text isEqualToString:@""]) {
        isValid = NO;
        err= @"Mobile No. is Required";
    }
    else if ([email.text isEqualToString:@""]) {
        isValid = NO;
        err= @"Email is Required";
    }
    
    if (!isValid) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:err delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        [alert release];
    }
    
    return isValid;
}

- (void)cancelBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneBtnAction
{
    isChangesMade_ = [self fieldValidation];
    if (isChangesMade_) {
        [self insertNewObject];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CoreData Actions

- (void)insertNewObject
{
    NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [newManagedObject setValue:first_name.text forKey:@"first_name"];
    [newManagedObject setValue:last_name.text forKey:@"last_name"];
    [newManagedObject setValue:company.text forKey:@"company"];
    [newManagedObject setValue:mobile.text forKey:@"mobile"];
    [newManagedObject setValue:email.text forKey:@"email"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}


#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Contact" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"first_name" ascending:NO] autorelease];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Contact"] autorelease];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}

#pragma mark - UITextFieldDelegate method(s)
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)dealloc {
    [first_name release];
    [last_name release];
    [company release];
    [mobile release];
    [email release];
    [_fetchedResultsController release];
    [_managedObjectContext release];
    
    [super dealloc];
}
@end
