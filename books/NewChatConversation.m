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
#import "UIKit/UIKit.h"
#import "QuartzCore/QuartzCore.h"
#import "MyLabel.h"


@implementation NewChatConversation

@synthesize books;
@synthesize TableView;
@synthesize convs;
@synthesize loginView;
@synthesize username;
@synthesize convers;
@synthesize scrollView;


-(void)viewDidAppear:(BOOL)animated {
    
    [self.scrollView flashScrollIndicators];
    
    NSLog(@"did appear: %@", username);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
            
    //NSLog(@"conversations' array %@", self.convers);
    
     
    NSEnumerator *enums = [self.convers objectEnumerator];
    Conversations *item;
    
    CGFloat margine=9;
    
    while(item = [enums nextObject]) {
        

        UIView *subview = [[UIView alloc] init];
        
        UILabel *txt = [[UILabel alloc] init] ;
        
        
        txt.lineBreakMode = UILineBreakModeWordWrap;
        txt.numberOfLines = 0;
        
        char c;
        float nr=0;
        
        for (c=0; c< [item.body length]; c++)
            if ([item.body characterAtIndex:c] == '\n')
                nr++;
        
        txt.text = item.body;
        
        float nb = [item.body length];
        
        [subview addSubview:txt];
        
        [txt sizeToFit];
        
        int hg = (int)(nb/45.0f + 0.5f + nr)*30;
        
        if (hg == 0)
            hg = 30;
        
        txt.frame = CGRectMake(4, 0, scrollView.frame.size.width-8, hg);

        
        [subview sizeToFit];
        subview.frame = CGRectMake(0, margine, subview.frame.size.width, subview.frame.size.height);

        if ([item.sender compare:username] == 0) {
            
            txt.layer.borderColor = [[UIColor colorWithRed:(204.0/255.0) green:(167.0/255.0) blue:(207.0/255.0) alpha:1] CGColor];
            txt.layer.borderWidth = 1;
            txt.layer.cornerRadius = 8;
            
        
            txt.backgroundColor = [UIColor clearColor]; 
            txt.backgroundColor = [UIColor colorWithRed:(234.0/255.0) green:(197.0/255.0) blue:(237.0/255.0) alpha:1];
            
        } else {
            
            txt.layer.borderColor = [[UIColor colorWithRed:(187.0/255.0) green:(225.0/255.0) blue:(139.0/255.0) alpha:1] CGColor];
            txt.layer.borderWidth = 1;
            txt.layer.cornerRadius = 8;
            
            txt.backgroundColor = [UIColor clearColor];
            txt.backgroundColor = [UIColor colorWithRed:(217.0/255.0) green:(255.0/255.0) blue:(169.0/255.0) alpha:1];
            
        }
        
       [self.scrollView addSubview:subview];
        
        [txt setNeedsDisplay];
        
        margine += txt.frame.size.height+9;
        
    }
    
    [self.scrollView setNeedsDisplay];
    
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, margine);
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = YES;
    
	
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

- (void)dealloc {
    
    [convers release];
    [super dealloc];
    
}


@end
