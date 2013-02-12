//
//  ABDetailViewController.m
//  iAddressBook
//
//  Created by Farooq Ahmed on 2/11/13.
//  Copyright (c) 2013 Arbisoft. All rights reserved.
//

#import "ABDetailViewController.h"
#import "ABUtils.h"

@interface ABDetailViewController ()
- (void)configureView;
- (void)updateObject;

@end

@implementation ABDetailViewController

- (void)dealloc
{
    [_detailItem release];
    [mobile release];
    [email release];
    [name release];
    [company release];
    [super dealloc];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release];
        _detailItem = [newDetailItem retain];

        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        firstName = [[self.detailItem valueForKey:@"first_name"] description];
        lastName = [[self.detailItem valueForKey:@"last_name"] description];
        NSString *completeName = [NSString stringWithFormat:@"%@ %@",firstName,lastName];
        
        [name setText:completeName];
        [company setText:[[self.detailItem valueForKey:@"company"] description]];
        [mobile setText:[[self.detailItem valueForKey:@"mobile"] description]];
        [email setText:[[self.detailItem valueForKey:@"email"] description]];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self
                                               action:@selector(editBtnAction)] autorelease];

    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Info", @"Info");
    }
    return self;
}


- (void)updateObject
{
    NSManagedObjectContext *context = [ABUtils currentManagedContext];
//    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];    
    NSManagedObject *object = self.detailItem;
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [object setValue:firstName forKey:@"first_name"];
    [object setValue:lastName forKey:@"last_name"];
    [object setValue:company.text forKey:@"company"];
    [object setValue:mobile.text forKey:@"mobile"];
    [object setValue:email.text forKey:@"email"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}


- (void)editBtnAction
{
    [self updateObject];
}


- (IBAction)favouriteBtnAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"This person has been added into your favourites." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    [alert release];
}

- (IBAction)shareBtnAction:(id)sender {
    
    NSString *shareText = [NSString stringWithFormat:@"Name: %@\nMobile: %@"
                           ,name.text,mobile.text];
    UIImage *shareImage = [UIImage imageNamed:@"default_pic.png"];
    NSArray *itemsToShare = @[shareText, shareImage];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll]; //or whichever you don't need
    [self presentViewController:activityVC animated:YES completion:nil];
    [activityVC release];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
