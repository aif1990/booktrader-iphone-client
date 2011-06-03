//
//  SecondViewController.m
//  books
//
//  Created by Andreea Ingrid Funie on 01/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginView.h"
#import "BookDetailViewController.h"
#import "NavigationController.h"
#import "booksAppDelegate.h"
#import "RegisterView.h"

@implementation HomeViewController

@synthesize bookDetailViewController;

-(IBAction)showActionSheet {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Account" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Continue" otherButtonTitles:@"Login",@"Register", nil];
    [actionSheet showInView:self.view];
    
    [actionSheet release];
    
}


- (void)actionSheet:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // the user clicked one of the buttons
    switch (buttonIndex){
        case 0:
            // handle a cancel event
            break;
            
        case 1:
            //handle a login
            [self openLoginView];
            break;
            
        case 2:
            //handle a register
            [self openRegisterView];
            break;
                
        default:
            //do whatever
            break;
    }

}

- (void)openRegisterView {
    
    RegisterView *settingDetail = [[RegisterView alloc] initWithNibName:@"RegisterView" bundle:nil];
    [self presentModalViewController:settingDetail animated:YES];
    [settingDetail release];
    
}

- (void)openLoginView {
    /*LoginView *myController = [[LoginView alloc] init];
    [self presentModalViewController:myController animated:YES];
    [myController release];*/
    
    LoginView *settingDetail = [[LoginView alloc] initWithNibName:@"LoginView" bundle:nil];
    
    [self presentModalViewController:settingDetail animated:YES];
    
    [settingDetail release];
    
    
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    [bookDetailViewController release];
    [super dealloc];
}

@end
