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
@synthesize msg;

@synthesize book;


-(void)viewDidLoad{
    
    [super viewDidLoad];
    self.list = [[NSMutableDictionary alloc] init];
    self.keys = [[NSMutableArray alloc] init];
    self.msg = [[NSMutableArray alloc] init];
    
    username = book.username;
    
    //NSLog(@"chatview: %@", username);
    
}

- (void)viewDidAppear:(BOOL)animated{
   
    
    if(username == NULL)
        username = @"nonExistingUser";
    
    
    NSString *nurl = @"http://www.doc.ic.ac.uk/project/2010/271/g1027114/messages/list?format=json";
    
    NSURL *url = [NSURL URLWithString:nurl];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:5];
    
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    NSString *responseString = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    NSDictionary *data = (NSDictionary *) [parser objectWithString:responseString error:nil];  
    
    [self.msg removeAllObjects];
    
    self.msg = (NSMutableArray*) [data objectForKey:@"unread"];
    
    if (!data || [(NSString*)[data objectForKey:@"status"] compare:@"error"] == NSOrderedSame) {
        
       // NSLog(@"%@", username);
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
        
       // NSLog(@"data este %@", data);
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
           // NSLog(@"utilizatorul este %@", convs);
            
            while (item = (NSDictionary*) [enums nextObject]) {
                
                //NSLog(@"creez vectorul%@", self.list);
                
                Conversations *c = [Conversations productWithType:[item objectForKey:@"date"] body:[item objectForKey:@"body"] recipient:[item objectForKey:@"recipient"] sender:[item objectForKey:@"sender"] subject:[item objectForKey:@"subject"] identifier:[item objectForKey:@"identifier"]];
                
                if ([item objectForKey:@"apples"] != nil) {
                    
                    c.isOffer = YES;
                    
                }
                
                [[self.list valueForKey:user] addObject:c];
                
            }
            
        }
        
        
       // NSLog(@"bau %@", [self.list valueForKey:@"scvalex"]);
    }
    
    [self.TableView reloadData];
    
    self.TableView.scrollEnabled = YES;
    
	
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [self.list removeAllObjects];
    [self.msg removeAllObjects];
    
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
    
    NSMutableArray *cvs;
    
    cvs = [self.list valueForKey:[self.keys objectAtIndex:indexPath.row]];
    
    Conversations *c = [cvs objectAtIndex:0];
    
    cell.textLabel.textColor = [UIColor blackColor];
    
    
    if(c.isOffer == YES) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"Offer from %@", c.sender];
        
        
        NSString* sends = [self.keys objectAtIndex:indexPath.row];
        
        NSLog(@"sends:%@", sends);
        
        
        if([self.msg count] >0) {
            
            NSEnumerator *enumer = [self.msg objectEnumerator];
            NSString* sender;
            
            while (sender = (NSMutableArray*) [enumer nextObject]){
                
                NSLog(@"sender: %@", sender);
                
                if([sender compare:sends] == 0)
                    cell.textLabel.textColor = [UIColor redColor];
            }
        }

        
        
    } else {
	
    cell.textLabel.text = [self.keys objectAtIndex:indexPath.row];
    
    NSString* sends = [self.keys objectAtIndex:indexPath.row];
        
    
    if([self.msg count] >0) {
        
        NSEnumerator *enumer = [self.msg objectEnumerator];
        NSString* sender;
        
        while (sender = (NSMutableArray*) [enumer nextObject]){
            
            if([sender compare:sends] == 0)
                cell.textLabel.textColor = [UIColor redColor];
        }
        
    }
        
    }
    
    
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewChatConversation *settings = [[NewChatConversation alloc] initWithNibName:@"NewChatConversation" bundle:nil];
    
    settings.convers = [self.list valueForKey:[self.keys objectAtIndex:indexPath.row]];
    
    settings.username = username;
    
    Conversations *c = [settings.convers objectAtIndex:0];

    NSString *nurl = [NSString stringWithFormat:@"http://www.doc.ic.ac.uk/project/2010/271/g1027114/messages/%@?format=json", c.identifier];
    
    NSURL *url = [NSURL URLWithString:nurl];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:5];
    
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    NSString *responseString = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];

    NSLog(@"url: %@\n", nurl);
    NSLog(@"ident: %@\n", c.identifier);
    
    //NSLog(@"chat messages%@", responseString);
    
    
   
    
    
    if(c.isOffer == YES) {
        
        settings.title = [NSString stringWithFormat:@"Offer: %@", c.subject];
    
    } else {

    settings.title = [self.keys objectAtIndex:indexPath.row];
        
    }
    
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
