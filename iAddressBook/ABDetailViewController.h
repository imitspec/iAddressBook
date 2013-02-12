//
//  ABDetailViewController.h
//  iAddressBook
//
//  Created by Farooq Ahmed on 2/11/13.
//  Copyright (c) 2013 Arbisoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABDetailViewController : UIViewController<UITextFieldDelegate> {
    
    NSString *firstName;
    NSString *lastName;
    
    IBOutlet UILabel *name;
    IBOutlet UILabel *company;
    IBOutlet UITextField *mobile;
    IBOutlet UITextField *email;
}

@property (strong, nonatomic) id detailItem;
- (IBAction)favouriteBtnAction:(id)sender;
- (IBAction)shareBtnAction:(id)sender;

@end
