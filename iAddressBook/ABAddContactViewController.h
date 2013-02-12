//
//  ABAddContactViewController.h
//  iAddressBook
//
//  Created by Farooq Ahmed on 2/11/13.
//  Copyright (c) 2013 Arbisoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABAddContactViewController : UIViewController <UITextFieldDelegate, NSFetchedResultsControllerDelegate> {
    
    IBOutlet UITextField *first_name;
    IBOutlet UITextField *last_name;
    IBOutlet UITextField *company;
    IBOutlet UITextField *mobile;
    IBOutlet UITextField *email;
    
    BOOL isChangesMade_;
}

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
