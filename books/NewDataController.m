//
//  NewDataController.m
//  books
//
//  Created by Andreea Ingrid Funie on 08/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import "NewDataController.h"
#import "SearchViewController.h"
#import "BookDetailViewController.h"
#import "NavigationController.h"
#import "booksAppDelegate.h"
#import "Product.h"
#import "CollectionViewController.h"
#import "JSON.h"


@implementation NewDataController

@synthesize bookTitle, searchViewController, bookAuthor, imageView, segmentedControl, collectionViewController, imageView2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [segmentedControl release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    NSLog(@"%@", searchViewController.product.title);
    
    bookTitle.text = searchViewController.product.title;
    
    NSEnumerator *enums = [searchViewController.product.author objectEnumerator];
    
    NSString* author;
    
    NSString *bookAuthors = @"***";
    
    while (author = (NSString*)[enums nextObject]) {
        
        bookAuthors = [bookAuthors stringByAppendingString:author];
        bookAuthors = [bookAuthors stringByAppendingString:@"***"];
    }
    
       
    NSURL *url = [NSURL URLWithString:searchViewController.product.url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:5];
    [request setHTTPMethod:@"POST"];
   
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    NSString *responseString = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    NSDictionary *data = (NSDictionary *) [parser objectWithString:responseString error:nil];  
    
    if (!data || [(NSString*)[data objectForKey:@"status"] compare:@"error"] == NSOrderedSame) {
        
        UIAlertView* alertView = nil; 
        
        @try {
        alertView = [[UIAlertView alloc] initWithTitle:@"Login Status" message:@"Check your login status" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
            
            [alertView show];  
        } @finally {
        if (alertView)
            [alertView release];
        }
    }

    
    
    UIImage *image = [UIImage imageWithData:responseData];
    if (image != NULL) {
        [imageView2 setHidden:YES];
        [imageView setImage:image];
    }    
    
    bookAuthor.text = bookAuthors;
    bookPublisher.text = searchViewController.product.publisher;
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // the user clicked one of the buttons
    switch (buttonIndex){
        case 0:
            // handle a cancel event
            break;
        default:
            //do whatever
            break;
    }
    
}*/

-(IBAction) segmentedControlIndexChanged{
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            [self have];
            break;
        case 1:
            [self want];
            break;
        default:
            break;
    }
 }

-(IBAction)want {
    
    
    NSString *first = @"http://abstractbinary.org:6543/books/";
    NSString *second = [first stringByAppendingString:searchViewController.product.identifier];
    NSString *nurl = [second stringByAppendingString:@"/want"];
    
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
        
        UIAlertView* alertView = nil; 
        
        @try {
            alertView = [[UIAlertView alloc] initWithTitle:@"Login Status" message:@"Check your login status" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
            
            [alertView show];  
        } @finally {
            if (alertView)
                [alertView release];
        }
    }


    //NSLog(@"%@ ", responseString);
    
}

-(IBAction)have {
    
    NSString *first = @"http://abstractbinary.org:6543/books/";
    NSString *second = [first stringByAppendingString:searchViewController.product.identifier];
    NSString *nurl = [second stringByAppendingString:@"/have"];
    
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
        
        UIAlertView* alertView = nil; 
        
        @try {
            alertView = [[UIAlertView alloc] initWithTitle:@"Login Status" message:@"Check your login status" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
            
            [alertView show];  
        } @finally {
            if (alertView)
                [alertView release];
        }
    }


    NSLog(@"%@ ", responseString);
    
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
