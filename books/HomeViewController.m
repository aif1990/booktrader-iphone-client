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
#import "BooksViewController.h"
#import "JSON.h"

@implementation HomeViewController

@synthesize bookDetailViewController;
@synthesize welcomeMessage, wantedBooksNb, ownedBooksNb, unreadMsg;
@synthesize loginView;
@synthesize booksViewController;
@synthesize imgView;
@synthesize logIm;

@synthesize book;

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
    
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.doc.ic.ac.uk/project/2010/271/g1027114/users/register"]];
    
}

- (void)Logout {
    
    NSURL *url = [NSURL URLWithString:@"http://www.doc.ic.ac.uk/project/2010/271/g1027114/users/logout"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setTimeoutInterval:5];
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    welcomeMessage.text = @"Not logged in";
    ownedBooksNb.text = @"";
    wantedBooksNb.text = @"";
    unreadMsg.text = @"";
    loginView.logged_in = false;
    
    [imgView setHidden:YES];
    [logIm setHidden:NO];
    
    [loginView release];
    loginView = NULL;
    
}

- (void)openLoginView {
    
    loginView = [[LoginView alloc] initWithNibName:@"LoginView" bundle:nil];
    
    [self presentModalViewController:loginView animated:YES];
    
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
        booksViewController.username = loginView.username;
        
        book.username = loginView.username;
        //NSLog(@"homeview:%@", book.username);
        
        //gravatar
        
        NSString *first = @"http://www.doc.ic.ac.uk/project/2010/271/g1027114/users/";
        NSString *second = [first stringByAppendingString:loginView.username];
        NSString *nurl = [second stringByAppendingString:@"/?format=json"];
        
        NSURL *url = [NSURL URLWithString:nurl];
        
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setTimeoutInterval:5];
        
        NSURLResponse *response = NULL;
        NSError *requestError = NULL;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
        NSString *responseString = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
        
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        
        NSDictionary *data = (NSDictionary *) [parser objectWithString:responseString error:nil];  
        
        NSString *gurl = (NSString*) [data objectForKey:@"gravatar"];
        
        NSURL *gvurl = [NSURL URLWithString:gurl];
        
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:gvurl];
        [req setTimeoutInterval:5];
        [req setHTTPMethod:@"POST"];
        
        NSURLResponse *resp = NULL;
        NSError *reqError = NULL;
        NSData *respData = [NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:&reqError];
        
        
        UIImage *img = [UIImage imageWithData:respData];
        if (img != NULL) {
            [logIm setHidden:YES];
            [imgView setImage:img];
            [imgView setHidden:NO];
        }    

        //gravatar appeared
     
        NSMutableArray *wanted = (NSMutableArray*) [data objectForKey:@"want"];
        NSMutableArray *owned = (NSMutableArray*) [data objectForKey:@"owned"];
        
        NSString* errors = (NSString*) [data objectForKey:@"status"];
        
        if([errors compare:@"error"] !=0) {
        
            if ([owned count] >1) {
                NSString *txt1 = [NSString stringWithFormat:@"*You have %d books in your collection *", [owned count]]; 
                ownedBooksNb.text = txt1;
            } else {
                    NSString *txt1 = [NSString stringWithFormat:@"*You have %d book in your collection*", [owned count]];
                ownedBooksNb.text = txt1;
            }
        
            if ([wanted count] >1) {
                NSString *txt2 = [NSString stringWithFormat:@"**You want %d books**", [wanted count]];
                wantedBooksNb.text = txt2;
            } else {
                NSString *txt2 = [NSString stringWithFormat:@"**You want %d book**", [wanted count]];
                wantedBooksNb.text = txt2;
            }
        
            
            if([owned count] == 0) {
                
                NSString *txt10 = [NSString stringWithFormat:@"*You have no books in your collection *"]; 
                ownedBooksNb.text = txt10;
                
            }
            
            if([wanted count] == 0) {
                
                NSString *txt20 = [NSString stringWithFormat:@"**You don't want any book**"];
                wantedBooksNb.text = txt20;
                
            }
            
        }
        
    
    NSString *nurl1 = @"http://www.doc.ic.ac.uk/project/2010/271/g1027114/messages/list?format=json";
    
    NSURL *url1 = [NSURL URLWithString:nurl1];
    
    
    NSMutableURLRequest *request1 = [NSMutableURLRequest requestWithURL:url1];
    [request1 setTimeoutInterval:5];
    
    NSURLResponse *response1 = NULL;
    NSError *requestError1 = NULL;
    NSData *responseData1 = [NSURLConnection sendSynchronousRequest:request1 returningResponse:&response1 error:&requestError1];
    NSString *responseString1 = [[[NSString alloc] initWithData:responseData1 encoding:NSUTF8StringEncoding] autorelease];
    
    SBJsonParser *parser1 = [[SBJsonParser alloc] init];

    NSDictionary *data1 = (NSDictionary *) [parser1 objectWithString:responseString1 error:nil];
    
    NSMutableArray *msg = (NSMutableArray*) [data1 objectForKey:@"unread"];
    
    NSString* errorAns = (NSString*) [data1 objectForKey:@"status"];
    
    if ([errorAns compare:@"error"] != 0) {
    
        if ([msg count] > 1) {
        NSString *txt3 = [NSString stringWithFormat:@"***You have %d unread messages***", [msg count]];
        unreadMsg.text = txt3;
        } else {
            
            NSString *txt31 = [NSString stringWithFormat:@"***You have %d unread message***", [msg count]];
            unreadMsg.text = txt31;
            
        }
        
        if ([msg count] == 0) {
            
            
            NSString *txt30 = [NSString stringWithFormat:@"***You don't have any unread messages***"];
            unreadMsg.text = txt30;
            
        }
    
    }
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
