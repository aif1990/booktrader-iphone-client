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


@implementation NewDataController

@synthesize bookTitle, searchViewController;

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
    NSLog(@"%@", searchViewController.product.title);
    
    bookTitle.text = searchViewController.product.title;
    
    //bookTitle.text = @"Ana are mere";
    
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
