//
//  booksAppDelegate.m
//  books
//
//  Created by Andreea Ingrid Funie on 01/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import "booksAppDelegate.h"
#import "CollectionViewController.h"
#import "WantedViewController.h"
#import "NavigationController.h"
#import "NewMessageView.h"
#import "SearchViewController.h"
#import "Product.h"
#import "JSON.h"
#import "ZBarReader.h"

@implementation booksAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize navigationController;
@synthesize searchViewController;

@synthesize username;

@synthesize listContent;
@synthesize jsonArray;



- (IBAction)openNewMessageView {
    
    NewMessageView *settingDetail = [[NewMessageView alloc] initWithNibName:@"NewMessageView" bundle:nil];
    settingDetail.title = [NSString stringWithFormat:@"New Message"];
    //[self.navigationController pushViewController:settingDetail animated:YES];
    [self.navigationController presentModalViewController:settingDetail animated:YES];
    [settingDetail release];
    
}


- (id)init {
	if (self = [super init]) {
		// 
	}
	return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
       
    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];
	
	return YES;
}

- (void)dealloc {

    [tabBarController release];
    [navigationController release];
    [window release];
    [super dealloc];
}

- (IBAction) searchBarcode
{
    
    ZBarReader *settingDetail = [[ZBarReader alloc] initWithNibName:@"ZBarReader" bundle:nil];
    settingDetail.title = [NSString stringWithFormat:@"Barcode Reader"];
    //[self.navigationController pushViewController:settingDetail animated:YES];
    settingDetail.searchView = searchViewController;
    
    [self.navigationController presentModalViewController:settingDetail animated:YES];
    [settingDetail release];
    
    }


@end
