//
//  CollectionViewController.m
//  books
//
//  Created by Andreea Ingrid Funie on 01/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import "BooksViewController.h"
#import "booksAppDelegate.h"
#import "CollectionViewController.h"
#import "WantedViewController.h"
#import "NavigationController.h"
#import "NewOwned.h"
#import "Product.h"
#import "LoginView.h"
#import "JSON.h"

@implementation CollectionViewController

@synthesize books;
@synthesize TableView;
@synthesize product;
@synthesize loginView;
@synthesize username;
@synthesize list;

/*
 - (id)initWithStyle:(UITableViewStyle)style {
 // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 if (self = [super initWithStyle:style]) {
 }
 return self; 
 }
 */

/*- (void)viewWillAppear:(BOOL)animated { 
	
	[TableView reloadData];
	
}*/


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.list = [NSMutableArray arrayWithCapacity:100];
    
    NSString *first = @"http://abstractbinary.org:6543/users/";
    NSString *second = [first stringByAppendingString:username];
    NSString *nurl = [second stringByAppendingString:@"?format=json"];
    
    NSURL *url = [NSURL URLWithString:nurl];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:5];
    
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    NSString *responseString = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    NSDictionary *data = (NSDictionary *) [parser objectWithString:responseString error:nil];  
    
    
    
    // NSLog(@"total items= %@\n", responseString);
    
	NSArray* result = [data objectForKey:@"owned"];
	NSEnumerator *enumerator = [result objectEnumerator];
	NSDictionary* item;
	
    [self.list removeAllObjects];
    
    while (item = (NSDictionary*)[enumerator nextObject]) {
        [self.list addObject:[Product productWithType:[item objectForKey:@"title"] author:[item objectForKey:@"authors"] publisher:[item objectForKey:@"publisher"] url:[item objectForKey:@"thumbnail"] identifier:[item objectForKey:@"identifier"]]];
    }
    
    NSLog(@"%@", self.list);
    
    [self.TableView reloadData];
    
    self.TableView.scrollEnabled = YES;
    
	
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

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}*/


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"count = %d\n", self.books.count);
    return [self.list count];

}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"controller view\n");
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
    NSLog(@"sunt in collection view");
    
    
    product = nil;
	
        product = [self.list objectAtIndex:indexPath.row];
	
	cell.textLabel.text = product.title;

    
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
	
	NSInteger row = [indexPath row];	
    
    product = nil;
    
	product = [self.list objectAtIndex:indexPath.row];
	
        NewOwned *settings = [[NewOwned alloc] initWithNibName:@"NewOwned" bundle:nil];
        
        
        settings.collectionViewController = self;
        
        // NSLog(@"%@\n", product.title);
        
        
        settings.title = product.title;
        
        [[self navigationController] pushViewController:settings animated:YES];
        [settings release];

	
}



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
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
    [TableView release];
    [books release];
    [product release];
    [list release];
    [super dealloc];
}


@end
