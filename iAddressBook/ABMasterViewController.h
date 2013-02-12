//
//  ABMasterViewController.h
//  iAddressBook
//
//  Created by Farooq Ahmed on 2/11/13.
//  Copyright (c) 2013 Arbisoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ABDetailViewController;
@class ABAddContactViewController;

#import <CoreData/CoreData.h>

@interface ABMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, UISearchDisplayDelegate> {
    NSMutableArray *filteredListContent_;
}

@property (strong, nonatomic) ABDetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
