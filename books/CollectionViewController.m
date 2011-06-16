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


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(username == NULL)
        username = @"nonExistingUser";
    
    self.list = [[NSMutableArray alloc] init];
    
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
    
    if (!data || [(NSString*)[data objectForKey:@"status"] compare:@"error"] == NSOrderedSame) {
        
        //NSLog(@"%@", username);
        //NSLog(@"%@",[data objectForKey:@"status"]);
        
        UIAlertView* alertView = nil; 
        
        @try {
            alertView = [[UIAlertView alloc] initWithTitle:@"Login Status" message:@"Check your login status" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
            
            [alertView show];  
        } @finally {
            if (alertView)
                [alertView release];
        }
    } else {

    
    // NSLog(@"total items= %@\n", responseString);
    
	NSArray* result = [data objectForKey:@"owned"];
	NSEnumerator *enumerator = [result objectEnumerator];
	NSDictionary* item;
	
    [self.list removeAllObjects];
    
    while (item = (NSDictionary*)[enumerator nextObject]) {
        [self.list addObject:[Product productWithType:[item objectForKey:@"title"] author:[item objectForKey:@"authors"] publisher:[item objectForKey:@"publisher"] url:[item objectForKey:@"thumbnail"] identifier:[item objectForKey:@"identifier"]]];
    }
    
        //NSLog(@"%@", self.list);}
    }
    
    [self.TableView reloadData];
    
    self.TableView.scrollEnabled = YES;
    
	
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
    
    //NSLog(@"controller view\n");
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
   // NSLog(@"sunt in collection view");
    
	
    product = [self.list objectAtIndex:indexPath.row];
	
	cell.textLabel.text = product.title;

    
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
	NSInteger row = [indexPath row];	
    
	product = [self.list objectAtIndex:indexPath.row];
	
        NewOwned *settings = [[NewOwned alloc] initWithNibName:@"NewOwned" bundle:nil];
        
        
        settings.collectionViewController = self;
        
        // NSLog(@"%@\n", product.title);
        
        
        settings.title = product.title;
        
        [[self navigationController] pushViewController:settings animated:YES];
        [settings release];

	
}


- (void)dealloc {
    
    
    [TableView release];
    [books release];
    [list release];
    [super dealloc];
    
    NSLog(@"dealloc");
}


@end
