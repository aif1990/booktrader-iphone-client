//
//  ChatViewController.m
//  books
//
//  Created by Andreea Ingrid Funie on 03/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import "BooksViewController.h"
#import "booksAppDelegate.h"
#import "ChatViewController.h"
#import "WantedViewController.h"
#import "NavigationController.h"
#import "NewOwned.h"
#import "Conversations.h"
#import "LoginView.h"
#import "JSON.h"
#import "NewChatConversation.h"

@implementation ChatViewController

@synthesize books;
@synthesize TableView;
@synthesize conversation;
@synthesize loginView;
@synthesize username;
@synthesize list;
@synthesize keys;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(username == NULL)
        username = @"nonExistingUser";
    
    self.list = [[NSMutableDictionary alloc] init];
    self.keys = [[NSMutableArray alloc] init];
    
   // self.list = [NSMutableArray arrayWithCapacity:100];
    
    NSString *nurl = @"http://abstractbinary.org:6543/messages/list?format=json";
    
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
        
        NSLog(@"%@", username);
        NSLog(@"%@",[data objectForKey:@"status"]);
        
        UIAlertView* alertView = nil; 
        
        @try {
            alertView = [[UIAlertView alloc] initWithTitle:@"Login Status" message:@"Check your login status" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
            
            [alertView show];  
        } @finally {
            if (alertView)
                [alertView release];
        }
    } else {
        
        
        NSDictionary* conversations = [data objectForKey:@"conversations"];
        NSString* user;
        NSDictionary* item;
        
        NSEnumerator *enumerator = [conversations keyEnumerator];
        
        [self.list removeAllObjects];
        
        
        while (user = (NSDictionary*) [enumerator nextObject]) {
            
            if ([self.list valueForKey:user] == nil) {
             
                [self.list setValue:[[NSMutableArray alloc] init] forKey:user];
                [self.keys addObject:user];
                
            }
            
            NSArray *convs = [conversations objectForKey:user];
            NSEnumerator *enums = [convs objectEnumerator];
            NSLog(@"utilizatorul este %@", convs);
            
            while (item = (NSDictionary*) [enums nextObject]) {
                
                NSLog(@"creez vectorul");
                
                [[self.list valueForKey:user] addObject:[Conversations productWithType:[item objectForKey:@"date"] body:[item objectForKey:@"body"] recipient:[item objectForKey:@"recipient"] sender:[item objectForKey:@"sender"] subject:[item objectForKey:@"subject"]]];
                
            }
            
        }
        
        
        NSLog(@"bau %@", [self.list valueForKey:@"scvalex"]);
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
	
    cell.textLabel.text = [self.keys objectAtIndex:indexPath.row];
    
    
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
    NewChatConversation *settings = [[NewChatConversation alloc] initWithNibName:@"NewChatConversation" bundle:nil];
    
    
    settings.convers = [self.list valueForKey:[self.keys objectAtIndex:indexPath.row]];
    
    //settings.collectionViewController = self;
    
    
    
    settings.title = [self.keys objectAtIndex:indexPath.row];
    
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
