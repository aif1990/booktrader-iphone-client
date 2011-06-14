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

@implementation booksAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize navigationController;
@synthesize searchViewController;

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
    
    
    /*NSURL *url = [NSURL URLWithString:@"http://abstractbinary.org:6543/books/search?query=ana&Search=Search&format=json"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:5];
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    NSString *responseString = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    NSDictionary *data = (NSDictionary *) [parser objectWithString:responseString error:nil];  
    
    NSString *total_items = (NSString *) [data objectForKey:@"total_items"];
    
   /* NSString *jsonData = [[NSString alloc] initWithContentsOfURL:url];
    
    jsonArray = [jsonData JSONValue];
    
    NSLog(@"%@", jsonArray);*/
    
  /*  NSLog(@"total items= %@\n", responseString);
    
    
	NSArray* result = [data objectForKey:@"result"];
	NSEnumerator *enumerator = [result objectEnumerator];
	NSDictionary* item;
	while (item = (NSDictionary*)[enumerator nextObject]) {
		NSLog(@"result:title = %@", [item objectForKey:@"title"]);
	}   */ 
    
    //decomment here for the global listContent
   /* listContent = [[NSArray alloc] initWithObjects:
                            [Product productWithType:@"Device" name:@"iPhone"],
                            [Product productWithType:@"Device" name:@"iPod"],
                            [Product productWithType:@"Device" name:@"iPod touch"],
                            [Product productWithType:@"Desktop" name:@"iMac"],
                            [Product productWithType:@"Desktop" name:@"Mac Pro"],
                            [Product productWithType:@"Portable" name:@"iBook"],
                            [Product productWithType:@"Portable" name:@"MacBook"],
                            [Product productWithType:@"Portable" name:@"MacBook Pro"],
                            [Product productWithType:@"Portable" name:@"PowerBook"], nil];*/
    //and here
    //SearchViewController *searchViewController = [[SearchViewController alloc] initWithNibName:@"SearchView" bundle:nil];
    
    //and here
	//searchViewController.listContent = listContent;
    
    //searchViewController.title = @"Products";
	//[listContent release];
    
    //and here
   // NSLog(@"Am setat array %d", [searchViewController.listContent count]);
	    
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
