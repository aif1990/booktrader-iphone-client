//
//  LoginView.m
//  books
//
//  Created by Andreea Ingrid Funie on 02/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import "LoginView.h"
#import "CoreFoundation/CFString.h"
//#import "ASIHTTPRequest.h"
//#import "ASIFormDataRequest.h"


@implementation LoginView

@synthesize mypassword;
@synthesize myusername;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)back {
    
    [self dismissModalViewControllerAnimated:YES];
    
}

- (IBAction)textFieldDoneEditing:(id)sender {
	
	[sender resignFirstResponder];
	
}

- (IBAction)backgroundClick:(id)sender {
    
	[myusername resignFirstResponder];
	[mypassword resignFirstResponder];
		
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
    
    
    NSUserDefaults *name = [NSUserDefaults standardUserDefaults];
    myusername.text = [name stringForKey:@"textFieldKey"];
    
    NSUserDefaults *passwd = [NSUserDefaults standardUserDefaults];
    mypassword.text = [passwd stringForKey:@"passwordFieldKey"];
    
    //[super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSString *)urlEncodeValue:(NSString *)str
{
    NSString *result = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, CFSTR(":/?#[]@!$&’()*+,;=”"), kCFStringEncodingUTF8);
    
    return [result autorelease];
}

- (IBAction)login {
    
    
    NSURL *url = [NSURL URLWithString:@"http://146.169.25.146:6543/users/login"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:myusername.text forHTTPHeaderField:@"username"];
    
    [request setValue:mypassword.text forHTTPHeaderField:@"password"];
    NSString *text = [NSString stringWithFormat:@"username=%@&password=%@&Login=Login&came_from=ana", [self urlEncodeValue:myusername.text], [self urlEncodeValue:mypassword.text]];
    
    NSData *requestBody =  [text dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:requestBody];
    
    
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    NSString *responseString = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
    
    
    if (requestError)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not logon to server" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else if (response)
	{
		NSLog (@"[DEBUG]: HTTP Response is %@", responseString);
	}
    
    
    // [response release];
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
