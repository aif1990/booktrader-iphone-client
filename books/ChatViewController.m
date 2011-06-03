//
//  ChatViewController.m
//  books
//
//  Created by Andreea Ingrid Funie on 03/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import "ChatViewController.h"
#import "BookDetailViewController.h"
#import "booksAppDelegate.h"
#import "CollectionViewController.h"
#import "WantedViewController.h"
#import "NavigationController.h"

@implementation  ChatViewController

@synthesize booksArray;
@synthesize bookDetailViewController;
@synthesize TableView;

/*
 - (id)initWithStyle:(UITableViewStyle)style {
 // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 if (self = [super initWithStyle:style]) {
 }
 return self; 
 }
 */


- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = NSLocalizedString(@"Chat",@"Chat");
	
	NSMutableArray *array = [[NSArray alloc] initWithObjects:@"conv1",@"conv2", nil];
	self.booksArray = array;
   	[array release];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

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
        cell.hidesAccessoryWhenEditing = YES;
    }
    
    // Set up the cell...
    
    
    //NSLog([NSString stringWithFormat:@"%i,%i",indexPath.row,(indexPath.row-count)]);
    
    
    NSInteger row = [indexPath row];
	cell.text = [booksArray objectAtIndex:row];
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
	
	NSInteger row = [indexPath row];		
	
	if([[booksArray objectAtIndex:row] isEqual:@"conv1"]){
		BookDetailViewController *settingDetail = [[CollectionViewController alloc] initWithNibName:@"CollectionViewController" bundle:nil];
		self.bookDetailViewController = settingDetail;
		
		bookDetailViewController.title = [NSString stringWithFormat:@"%@", [booksArray objectAtIndex:row]];
		
		[self.navigationController pushViewController:bookDetailViewController animated:YES];
        [settingDetail release];
        
	}
	
	if([[booksArray objectAtIndex:row] isEqual:@"conv2"]){
		BookDetailViewController *settingDetail = [[WantedViewController alloc] initWithNibName:@"WantedViewController" bundle:nil];
		self.bookDetailViewController = settingDetail;
		
		bookDetailViewController.title = [NSString stringWithFormat:@"%@", [booksArray objectAtIndex:row]];
        
		[self.navigationController pushViewController:bookDetailViewController animated:YES];		
		[settingDetail release];		
		
	}	
	
}




/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

 


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */




- (void)dealloc {
	[bookDetailViewController release]; 
    [super dealloc];
}


@end
