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
#import "SearchViewController.h"

@implementation booksAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize navigationController;
@synthesize searchViewController;

@synthesize listContent;



- (IBAction)openNewMessageView {
    
    NewMessageView *settingDetail = [[NewMessageView alloc] initWithNibName:@"NewMessageView" bundle:nil];
    settingDetail.title = [NSString stringWithFormat:@"New Message"];
    [self.navigationController pushViewController:settingDetail animated:YES];
    [settingDetail release];
    
}


- (id)init {
	if (self = [super init]) {
		// 
	}
	return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    listContent = [[NSArray alloc] initWithObjects:
                            [Product productWithType:@"Device" name:@"iPhone"],
                            [Product productWithType:@"Device" name:@"iPod"],
                            [Product productWithType:@"Device" name:@"iPod touch"],
                            [Product productWithType:@"Desktop" name:@"iMac"],
                            [Product productWithType:@"Desktop" name:@"Mac Pro"],
                            [Product productWithType:@"Portable" name:@"iBook"],
                            [Product productWithType:@"Portable" name:@"MacBook"],
                            [Product productWithType:@"Portable" name:@"MacBook Pro"],
                            [Product productWithType:@"Portable" name:@"PowerBook"], nil];
    
    //SearchViewController *searchViewController = [[SearchViewController alloc] initWithNibName:@"SearchView" bundle:nil];
    
    
	searchViewController.listContent = listContent;
    
    //searchViewController.title = @"Products";
	//[listContent release];
    
    NSLog(@"Am setat array %d", [searchViewController.listContent count]);
	    
    // Override point for customization after app launch    
    
    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];
	
	return YES;
}


/*
 // Optional UITabBarControllerDelegate method
 - (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
 }
 */

/*
 // Optional UITabBarControllerDelegate method
 - (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
 }
 */
/*- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
	// Close the database here.
}*/

- (void)dealloc {

    [tabBarController release];
    [navigationController release];
    [window release];
    [super dealloc];
}

@end
