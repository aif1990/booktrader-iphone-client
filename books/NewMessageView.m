//
//  NewMessageView.m
//  books
//
//  Created by Andreea Ingrid Funie on 03/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import "NewMessageView.h"
#import "CoreFoundation/CFString.h"
#import "HomeViewController.h"


@implementation NewMessageView

@synthesize recipient;
@synthesize subject;
@synthesize message;
@synthesize alert;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [cookieStorage setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)textFieldDoneEditing:(id)sender {
	
	[sender resignFirstResponder];
	
}

- (IBAction)backgroundClick:(id)sender {
    
	[recipient resignFirstResponder];
	[subject resignFirstResponder];
    [message resignFirstResponder];
    
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
    
    NSUserDefaults *recip = [NSUserDefaults standardUserDefaults];
    recipient.text = [recip stringForKey:@"recipientFieldKey"];
    
    NSUserDefaults *subj = [NSUserDefaults standardUserDefaults];
    subject.text = [subj stringForKey:@"subjectFieldKey"];
    
    NSUserDefaults *msg = [NSUserDefaults standardUserDefaults];
    message.text = [msg stringForKey:@"messageFieldKey"];
    
    
}

- (NSString *)urlEncodeValue:(NSString *)str
{
    NSString *result = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, CFSTR(":/?#[]@!$&’()*+,;=”"), kCFStringEncodingUTF8);
    
    return [result autorelease];
}

- (IBAction)send {
    
    
    NSURL *url = [NSURL URLWithString:@"http://abstractbinary.org:6543/messages/new"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:5];
    [request setHTTPMethod:@"POST"];
    [request setValue:recipient.text forHTTPHeaderField:@"recipient"];
    [request setValue:subject.text forHTTPHeaderField:@"subject"];
    [request setValue:message.text forHTTPHeaderField:@"body"];
    
    NSString *text = [NSString stringWithFormat:@"recipient=%@&subject=%@&body=%@&Send=Send&format=json", [self urlEncodeValue:recipient.text], [self urlEncodeValue:subject.text], [self urlEncodeValue:message.text]];
    
    NSData *requestBody =  [text dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:requestBody];
    
    
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    NSString *responseString = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
    
    
    if (requestError)
	{
		alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not send to server" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else if (response)
	{
        
           /* alert = [[UIAlertView alloc] initWithTitle:@"Sent" message:@"Message sent successfully" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [alert show];
            [alert release];*/
        [self dismissModalViewControllerAnimated:YES];
            
        }
    
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
