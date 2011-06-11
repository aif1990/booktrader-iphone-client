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

@implementation HomeViewController

@synthesize bookDetailViewController;
@synthesize welcomeMessage;
@synthesize loginView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [cookieStorage setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        loginView = NULL;
    }
    return self;
}

-(IBAction)showActionSheet {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Account" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Continue" otherButtonTitles:@"Login",@"Register", @"Logout", nil];
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
            
        case 3:
            [self Logout];
            break;
                
        default:
            //do whatever
            break;
    }

}

- (void)openRegisterView {
    
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://abstractbinary.org:6543/users/register"]];
    
}

- (void)Logout {
    
    NSURL *url = [NSURL URLWithString:@"http://abstractbinary.org:6543/users/logout"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setTimeoutInterval:5];
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    welcomeMessage.text = @"Not logged in";
    
    [loginView release];
    loginView = NULL;
    
}

- (void)openLoginView {
    /*LoginView *myController = [[LoginView alloc] init];
    [self presentModalViewController:myController animated:YES];
    [myController release];*/
    
    loginView = [[LoginView alloc] initWithNibName:@"LoginView" bundle:nil];
    
    [self presentModalViewController:loginView animated:YES];
    
    //[loginView autorelease];
    
    
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    welcomeMessage.text = @"Not logged in";
    
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated 
{

    if (loginView !=NULL && loginView.username != NULL)  {
        NSString *user = [@"Welcome, " stringByAppendingString:loginView.username];
        welcomeMessage.text = [user stringByAppendingString:@"!"];
    }
    
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
