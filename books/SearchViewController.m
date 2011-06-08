//
//  FirstViewController.m
//  books
//
//  Created by Andreea Ingrid Funie on 01/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import "SearchViewController.h"
#import "Product.h"
#import "booksAppDelegate.h"
#import "NavigationController.h"
#import "JSON.h"


@implementation SearchViewController

@synthesize listContent, filteredListContent, savedSearchTerm, savedScopeButtonIndex, searchWasActive, jsonArray;
@synthesize TableView;


#pragma mark - 
#pragma mark Lifecycle methods

- (void)viewDidLoad
{
    
	self.title = @"Search";
    
    NSLog(@"Am incarcat view");
    
    //booksAppDelegate *delegate = (booksAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if(self.listContent != NULL)
        NSLog(@"list cnt size%d\n", [self.listContent count]);
    
	
    
	// create a filtered list that will contain products for the search results table.
    self.listContent = [NSMutableArray arrayWithCapacity:100];
	self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.listContent count]];
    
    //self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.jsonArray count]];
	
	// restore search settings if they were saved in didReceiveMemoryWarning.
    if (self.savedSearchTerm)
	{
        [self.searchDisplayController setActive:self.searchWasActive];
        [self.searchDisplayController.searchBar setSelectedScopeButtonIndex:self.savedScopeButtonIndex];
        [self.searchDisplayController.searchBar setText:savedSearchTerm];
        
        self.savedSearchTerm = nil;
    }
	
	[self.TableView reloadData];
	self.TableView.scrollEnabled = YES;
}

- (void)viewDidUnload
{
	self.filteredListContent = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    
    self.searchDisplayController.searchBar.scopeButtonTitles = nil;
    self.searchDisplayController.searchBar.scopeButtonTitles = [NSArray arrayWithObjects:@"Title",@"Author",@"Publisher", nil];
    self.searchDisplayController.searchBar.showsScopeBar = YES;
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    // save the state of the search UI so that it can be restored if the view is re-created
    self.searchWasActive = [self.searchDisplayController isActive];
    self.savedSearchTerm = [self.searchDisplayController.searchBar text];
    self.savedScopeButtonIndex = [self.searchDisplayController.searchBar selectedScopeButtonIndex];
}

- (void)dealloc
{
	[listContent release];
	[filteredListContent release];
	
	[super dealloc];
}


#pragma mark -
#pragma mark UITableView data source and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	/*
	 If the requesting table view is the search display controller's table view, return the count of
     the filtered list, otherwise return the count of the main list.
	 */
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [self.filteredListContent count];
    }
	/*else
     {
     return [self.listContent count];
     }*/
    
    //return [jsonArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *kCellID = @"cellID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID] autorelease];
		//cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	/*
	 If the requesting table view is the search display controller's table view, configure the cell using the filtered content, otherwise use the main list.
	 */
	Product *product = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        product = [self.filteredListContent objectAtIndex:indexPath.row];
    }
	/*else
     {
     product = [self.listContent objectAtIndex:indexPath.row];
     }
	*/
	cell.textLabel.text = product.title;
    
    
    //cell.textLabel.text = (NSString *)[self.jsonArray objectAtIndex:indexPath.row];
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *detailsViewController = [[UIViewController alloc] init];
    
	/*
	 If the requesting table view is the search display controller's table view, configure the next view controller using the filtered content, otherwise use the main list.
	 */
	Product *product = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        product = [self.filteredListContent objectAtIndex:indexPath.row];
    }
	/*else
     {
     product = [self.listContent objectAtIndex:indexPath.row];
     }*/
	detailsViewController.title = product.title;
    
    [[self navigationController] pushViewController:detailsViewController animated:YES];
    [detailsViewController release];
}


#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	/*
	 Update the filtered array based on the search text and scope.
	 */
    //NSURL *url = [NSURL URLWithString:@"http://abstractbinary.org:6543/books/search?query=ana&Search=Search&format=json"];
    
    NSString *first = @"http://abstractbinary.org:6543/books/search?query=";
    NSString *second = [first stringByAppendingString:searchText];
    NSString *nurl = [second stringByAppendingString:@"&Search=Search&format=json"];
    
    NSURL *url = [NSURL URLWithString:nurl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:5];
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    NSString *responseString = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    NSDictionary *data = (NSDictionary *) [parser objectWithString:responseString error:nil];  
    
    //NSString *total_items = (NSString *) [data objectForKey:@"total_items"];
    
    /* NSString *jsonData = [[NSString alloc] initWithContentsOfURL:url];
     
     jsonArray = [jsonData JSONValue];
     
     NSLog(@"%@", jsonArray);*/
    
    NSLog(@"total items= %@\n", responseString);
    
	NSArray* result = [data objectForKey:@"result"];
	NSEnumerator *enumerator = [result objectEnumerator];
	NSDictionary* item;
	/*while (item = (NSDictionary*)[enumerator nextObject]) {
		NSLog(@"result:title = %@", [item objectForKey:@"title"]);
	} */
    //[self.listContent removeAllObjects];
    
    
    
    while (item = (NSDictionary*)[enumerator nextObject]) {
        [self.listContent addObject:[Product productWithType:[item objectForKey:@"title"] author:[item objectForKey:@"authors"] publisher:[item objectForKey:@"publisher"]]];
        //NSLog(@"result:title = %@", [item objectForKey:@"title"]);

    }
    
	[self.filteredListContent removeAllObjects]; // First clear the filtered array.
	
	/*
	 Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
	for (Product *product in self.listContent)
	{
        //NSLog(@"%@ %@\n",searchText, scope);
        
		if ([scope isEqualToString:@"Title"] || [product.title isEqualToString:scope])		{
           // NSLog(@"size %d", [self.listContent count]);
			NSComparisonResult result = [product.title compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
            if (result == NSOrderedSame)
			{
				[self.filteredListContent addObject:product];
            }
		}
        
        if ([scope isEqualToString:@"Author"]) {
            
            NSEnumerator *enums = [product.author objectEnumerator];
            
            NSString* author;
            
            while (author = (NSString*)[enums nextObject]) {
                NSComparisonResult result = [author compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
                    if (result == NSOrderedSame)
                    {
                        [self.filteredListContent addObject:product];
                    }
                }
            
        }
        
        if ([scope isEqualToString:@"Publisher"] || [product.publisher isEqualToString:scope]) {
            
            NSComparisonResult result = [product.publisher compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
            if (result == NSOrderedSame)
			{
				[self.filteredListContent addObject:product];
            }

            
        }
	}
}


#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


@end
