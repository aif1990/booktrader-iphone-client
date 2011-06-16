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
#import "BookDetailViewController.h"
#import "NewDataController.h"


@implementation SearchViewController

@synthesize listContent, filteredListContent, savedSearchTerm, savedScopeButtonIndex, searchWasActive, jsonArray, product;
@synthesize TableView, bookDetailViewController;


#pragma mark - 
#pragma mark Lifecycle methods

- (void)viewDidLoad
{
    
	self.title = @"Search";
    
    NSLog(@"Am incarcat view");
    
    
	// create a filtered list that will contain products for the search results table.
    self.listContent = [NSMutableArray arrayWithCapacity:100];
	self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.listContent count]];

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
   // self.searchDisplayController.searchBar.selectedScopeButtonIndex = 0;
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    
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
	product = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        product = [self.filteredListContent objectAtIndex:indexPath.row];
    }
	
	cell.textLabel.text = product.title;
    
    
    //cell.textLabel.text = (NSString *)[self.jsonArray objectAtIndex:indexPath.row];
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
	/*
	 If the requesting table view is the search display controller's table view, configure the next view controller using the filtered content, otherwise use the main list.
	 */
	product = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        product = [self.filteredListContent objectAtIndex:indexPath.row];
    }
    
    NewDataController *settings = [[NewDataController alloc] initWithNibName:@"NewDataController" bundle:nil];
    
    
    settings.searchViewController = self;
    
    
    settings.title = product.title;
    
    [[self navigationController] pushViewController:settings animated:YES];
    [settings release];
    
   }


#pragma mark -
#pragma mark Content Filtering

- (NSString *)urlEncodeValue:(NSString *)str
{
    NSString *result = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, CFSTR(":/?#[]@!$&’()*+,;=”"), kCFStringEncodingUTF8);
    
    return [result autorelease];
}



- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
   
    
    NSString *first = @"http://abstractbinary.org:6543/books/search?query=";
    NSString *second = [first stringByAppendingString:[self urlEncodeValue:searchText]];
    NSString *nurl = [second stringByAppendingString:@"&Search=Search&format=json&limit=40"];
    
    NSURL *url = [NSURL URLWithString:nurl];

    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:5];
    
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    NSString *responseString = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    NSDictionary *data = (NSDictionary *) [parser objectWithString:responseString error:nil];  

	NSArray* result = [data objectForKey:@"google_books"];
	NSEnumerator *enumerator = [result objectEnumerator];
	NSDictionary* item;
	
    
    [self.listContent removeAllObjects];
    
    while (item = (NSDictionary*)[enumerator nextObject]) {
        [self.listContent addObject:[Product productWithType:[item objectForKey:@"title"] author:[item objectForKey:@"authors"] publisher:[item objectForKey:@"publisher"] url:[item objectForKey:@"thumbnail"] identifier:[item objectForKey:@"identifier"]]];

    }
    
	[self.filteredListContent removeAllObjects]; // First clear the filtered array.
    
    
    
	for (product in self.listContent)
	{
            
        
		if ([scope isEqualToString:@"Title"] || [product.title isEqualToString:scope] || self.searchDisplayController.searchBar.selectedScopeButtonIndex == 0)		{
            
            
            if([product.title rangeOfString:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)].location != NSNotFound)
			{
				[self.filteredListContent addObject:product];
                
            }
            
		}
        
        if ([scope isEqualToString:@"Author"] || self.searchDisplayController.searchBar.selectedScopeButtonIndex == 1) {
            
            
            NSEnumerator *enums = [product.author objectEnumerator];
            
            NSString* author;
            
            while (author = (NSString*)[enums nextObject]) {
                if([author rangeOfString:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)].location != NSNotFound)
                    {
                        [self.filteredListContent addObject:product];
                    }
                }
            
        }
        
        if ([scope isEqualToString:@"Publisher"] || [product.publisher isEqualToString:scope] ||self.searchDisplayController.searchBar.selectedScopeButtonIndex == 2) {
            
            
            if([product.publisher rangeOfString:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)].location != NSNotFound)
            //if([product.publisher containsSubstring:searchText])
			{
				[self.filteredListContent addObject:product];
            }

            
        }
	}
    
    
}
 
//put this if we want to search for thw whole string not char by char : not working in some cases.

/*- (void)searchBarSearchButtonClicked:(UISearchBar*)searchBar
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]
                               scope:[self.searchDisplayController.searchBar selectedScopeButtonIndex]];
    [self.searchDisplayController.searchResultsTableView reloadData];
}*/


#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
        
    // Return YES to cause the search result table view to be reloaded.
    return YES;
    
   // return NO; if we want to search for the whole string not char by char
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
   [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
        
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


@end
