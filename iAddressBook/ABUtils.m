//
//  ABUtils.m
//  iAddressBook
//
//  Created by Farooq Ahmed on 2/11/13.
//  Copyright (c) 2013 Arbisoft. All rights reserved.
//

#import "ABUtils.h"
#import "ABAppDelegate.h"

@implementation ABUtils

+ (NSManagedObjectContext *)currentManagedContext
{
    ABAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate managedObjectContext]) {
        return [delegate managedObjectContext];
    }
    return nil;
}

@end
