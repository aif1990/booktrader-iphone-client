//
//  BooksViewController.m
//  books
//
//  Created by Andreea Ingrid Funie on 01/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import "BooksViewController.h"
#import "BookDetailViewController.h"
#import "booksAppDelegate.h"
#import "CollectionViewController.h"
#import "WantedViewController.h"
#import "NavigationController.h"

@implementation BooksViewController

@synthesize booksArray;
@synthesize bookDetailViewController;
@synthesize TableView;
@synthesize username;


- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = NSLocalizedString(@"Books",@"Books");
	
	NSMutableArray *array = [[NSArray alloc] initWithObjects:@"Collection",@"Wanted", nil];
	self.booksArray = array;
	[array release];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.booksArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	NSInteger row = [indexPath row];
	cell.text = [booksArray objectAtIndex:row];
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSInteger row = [indexPath row];		
	
	if([[booksArray objectAtIndex:row] isEqual:@"Collection"]){
		        
        CollectionViewController *settings = [[CollectionViewController alloc] initWithNibName:@"CollectionViewController" bundle:nil];
        
        settings.title = [NSString stringWithFormat:@"%@", [booksArray objectAtIndex:row]];

        settings.username = username;
        
		[self.navigationController pushViewController:settings animated:YES];
        [settings release];
        
	}
	
	if([[booksArray objectAtIndex:row] isEqual:@"Wanted"]){
		
        WantedViewController *settingsDetail = [[WantedViewController alloc] initWithNibName:@"WantedViewController" bundle:nil];
        
        settingsDetail.title = [NSString stringWithFormat:@"%@", [booksArray objectAtIndex:row]];
        
        settingsDetail.username = username;
        
        [self.navigationController pushViewController:settingsDetail animated:YES];
        [settingsDetail release];
		
	}	
	
	}


- (void)dealloc {
	[bookDetailViewController release]; 
    [super dealloc];
}


@end
