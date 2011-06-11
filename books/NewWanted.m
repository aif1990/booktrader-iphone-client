//
//  NewWanted.m
//  books
//
//  Created by Andreea Ingrid Funie on 11/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import "NewWanted.h"
#import "SearchViewController.h"
#import "BookDetailViewController.h"
#import "NavigationController.h"
#import "booksAppDelegate.h"
#import "Product.h"
#import "WantedViewController.h"


@implementation NewWanted

@synthesize bookTitle, bookAuthor, imageView, collectionViewController;

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
    //NSLog(@"%@", searchViewController.product.title);
    
    bookTitle.text = collectionViewController.product.title;
    
    NSEnumerator *enums = [collectionViewController.product.author objectEnumerator];
    
    NSString* author;
    
    NSString *bookAuthors = @"***";
    
    while (author = (NSString*)[enums nextObject]) {
        
        bookAuthors = [bookAuthors stringByAppendingString:author];
        bookAuthors = [bookAuthors stringByAppendingString:@"***"];
    }
    
    
    NSURL *url = [NSURL URLWithString:collectionViewController.product.url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:5];
    [request setHTTPMethod:@"POST"];
    
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    UIImage *image = [UIImage imageWithData:responseData];
    [imageView setImage:image];
    
    
    bookAuthor.text = bookAuthors;
    bookPublisher.text = collectionViewController.product.publisher;
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
