//
//  NewChatConversation.m
//  books
//
//  Created by Andreea Ingrid Funie on 13/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import "BooksViewController.h"
#import "booksAppDelegate.h"
#import "NewChatConversation.h"
#import "WantedViewController.h"
#import "NavigationController.h"
#import "NewOwned.h"
#import "Conversations.h"
#import "LoginView.h"
#import "JSON.h"

@implementation NewChatConversation

@synthesize books;
@synthesize TableView;
@synthesize convs;
@synthesize loginView;
@synthesize username;
@synthesize convers;


- (void)viewDidLoad {
    [super viewDidLoad];
            
    //NSLog(@"conversations' array %@", self.convers);
    
    
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
    return [self.convers count];
    
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
    
	
    convs = [self.convers objectAtIndex:indexPath.row];
	
    
    //[cell.textLabel sizeThatFits:cell.frame.size];
    
	cell.textLabel.text = self.convs.body;
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 0;
    CGSize size = [cell.textLabel sizeThatFits:cell.frame.size];
    cell.frame = CGRectMake(120, 33, size.width, size.height);
    //cell.autoresizesSubviews = YES;
    
    NSLog(@"text:%@", self.convs.body);
    
	//[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}



/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
	NSInteger row = [indexPath row];	
    
	product = [self.list objectAtIndex:indexPath.row];
	
    NewOwned *settings = [[NewOwned alloc] initWithNibName:@"NewOwned" bundle:nil];
    
    
    settings.collectionViewController = self;
    
    // NSLog(@"%@\n", product.title);
    
    
    settings.title = product.title;
    
    [[self navigationController] pushViewController:settings animated:YES];
    [settings release];
    
	
}*/



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
    [convers release];
    [super dealloc];
    
}


@end
