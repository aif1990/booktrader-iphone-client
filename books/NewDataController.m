//
//  NewDataController.m
//  books
//
//  Created by Andreea Ingrid Funie on 08/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import "NewDataController.h"
#import "BookDetailViewController.h"
#import "NavigationController.h"
#import "booksAppDelegate.h"
#import "Product.h"
#import "CollectionViewController.h"
#import "JSON.h"


@implementation NewDataController

@synthesize bookTitle, bookAuthor, imageView, segmentedControl, collectionViewController, imageView2, product;

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
    NSLog(@"%@", product.title);
    
    bookTitle.text = product.title;
    
    NSEnumerator *enums = [product.author objectEnumerator];
    
    NSString* author;
    
    NSString *bookAuthors = @"***";
    
    while (author = (NSString*)[enums nextObject]) {
        
        bookAuthors = [bookAuthors stringByAppendingString:author];
        bookAuthors = [bookAuthors stringByAppendingString:@"***"];
    }
    
    
    NSLog(@"%@", product.url);
    
    NSURL *url = [NSURL URLWithString:product.url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:5];
    [request setHTTPMethod:@"POST"];
   
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    
    UIImage *image = [UIImage imageWithData:responseData];
    if (image != NULL) {
        [imageView2 setHidden:YES];
        [imageView setImage:image];
    }    
    
    bookAuthor.text = bookAuthors;
    bookPublisher.text = product.publisher;
    
    
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

-(IBAction) exit {
    
    [self dismissModalViewControllerAnimated:YES];
    
}

-(IBAction)want {
    
    
    NSString *first = @"http://www.doc.ic.ac.uk/project/2010/271/g1027114/books/";
    NSString *second = [first stringByAppendingString:product.identifier];
    NSString *nurl = [second stringByAppendingString:@"/want?format=json"];
    
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
        
        if ( [(NSString*) [data objectForKey:@"reason"] compare:@"book already wanted"] == NSOrderedSame) {
        
            
            UIAlertView* alertView = nil; 
            
            @try {
                alertView = [[UIAlertView alloc] initWithTitle:@"Book Status" message:@"Book already wanted" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
                
                [alertView show];  
            } @finally {
                if (alertView)
                    [alertView release];
            }
        
            
        
        } else {
        
        UIAlertView* alertView = nil; 
        
        @try {
            alertView = [[UIAlertView alloc] initWithTitle:@"Login Status" message:@"Check your login status" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
            
            [alertView show];  
        } @finally {
            if (alertView)
                [alertView release];
        }
    }
    }


    //NSLog(@"%@ ", responseString);
    
}

-(IBAction)have {
    
    NSString *first = @"http://www.doc.ic.ac.uk/project/2010/271/g1027114/books/";
    NSString *second = [first stringByAppendingString:product.identifier];
    NSString *nurl = [second stringByAppendingString:@"/have?format=json"];
    
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
        
       // NSLog(@"hjghghjh %@", [data objectForKey:@"status"]);
        
        
        if ( [(NSString*) [data objectForKey:@"reason"] compare:@"book already owned"] == NSOrderedSame) {
            
            
            UIAlertView* alertView = nil; 
            
            @try {
                alertView = [[UIAlertView alloc] initWithTitle:@"Book Status" message:@"Book already owned" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
                
                [alertView show];  
            } @finally {
                if (alertView)
                    [alertView release];
            }
            
            
            
        } else {
        
        UIAlertView* alertView = nil; 
        
        @try {
            alertView = [[UIAlertView alloc] initWithTitle:@"Login Status" message:@"Check your login status" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
            
            [alertView show];  
        } @finally {
            if (alertView)
                [alertView release];
        }
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
