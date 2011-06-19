//
//  booksAppDelegate.m
//  books
//
//  Created by Andreea Ingrid Funie on 01/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import "booksAppDelegate.h"
#import "CollectionViewController.h"
#import "WantedViewController.h"
#import "NavigationController.h"
#import "NewMessageView.h"
#import "SearchViewController.h"
#import "Product.h"
#import "JSON.h"
#import "ZBarReader.h"

@implementation booksAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize navigationController;
@synthesize searchViewController;

@synthesize username;

@synthesize listContent;
@synthesize jsonArray;
@synthesize product;



- (IBAction)openNewMessageView {
    
    NewMessageView *settingDetail = [[NewMessageView alloc] initWithNibName:@"NewMessageView" bundle:nil];
    settingDetail.title = [NSString stringWithFormat:@"New Message"];
    //[self.navigationController pushViewController:settingDetail animated:YES];
    [self.navigationController presentModalViewController:settingDetail animated:YES];
    [settingDetail release];
    
}


- (id)init {
	if (self = [super init]) {
		// 
	}
	return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
       
    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];
	
	return YES;
}

- (void)dealloc {

    [tabBarController release];
    [navigationController release];
    [window release];
    [super dealloc];
}


- (NSString *)urlEncodeValue:(NSString *)str
{
    NSString *result = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, CFSTR(":/?#[]@!$&’()*+,;=”"), kCFStringEncodingUTF8);
    
    return [result autorelease];
}

-(IBAction) exists {
    
    [self dismissModalViewControllerAnimated:YES];
    
}

- (IBAction) scanButtonTapped
{
    // ADD: present a barcode reader that scans from the camera feed
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    
    ZBarImageScanner *scanner = reader.scanner;
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    // present and release the controller
    /*/// [self presentModalViewController: reader
     animated: YES];
     [reader release];*/
    
    [self imagePickerController:reader didFinishPickingMediaWithInfo:nil];
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    /*/// id<NSFastEnumeration> results =
     [info objectForKey: ZBarReaderControllerResults];
     ZBarSymbol *symbol = nil;
     for(symbol in results)
     // EXAMPLE: just grab the first barcode
     break;*/
    
    
    // EXAMPLE: do something useful with the barcode data
    //resultText.text = symbol.data;
    //resultText.text = @"9780262011532";
    
    
    // EXAMPLE: do something useful with the barcode image
    // resultImage.image =
    //[info objectForKey: UIImagePickerControllerOriginalImage];
    
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    // [reader dismissModalViewControllerAnimated: YES];
    
    
    
    NSString *first = @"http://abstractbinary.org:6543/search?query=";
    NSString *second = [first stringByAppendingString:[self urlEncodeValue:@"9780262011532"]];
    NSString *nurl = [second stringByAppendingString:@"&type=books&format=json&Search=Search&limit=40"];
    
    NSURL *url = [NSURL URLWithString:nurl];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:5];
    
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    NSString *responseString = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    NSDictionary *data = (NSDictionary *) [parser objectWithString:responseString error:nil];  
    
	NSArray* result = [data objectForKey:@"google_books"];
	NSEnumerator *enumerator = [result objectEnumerator];
	NSDictionary* item;
    
    if ([result count] == 0)
        return;
	
    
    item = (NSDictionary*)[enumerator nextObject];
    product = [Product productWithType:[item objectForKey:@"title"] author:[item objectForKey:@"authors"] publisher:[item objectForKey:@"publisher"] url:[item objectForKey:@"thumbnail"] identifier:[item objectForKey:@"identifier"]];
    
    
    
    // product = [self.listContent objectAtIndex:0];
    
    NewDataController *settingDetail = [[NewDataController alloc] initWithNibName:@"NewDataController" bundle:nil];
    settingDetail.title = product.title;
    
    NSLog(@"%@", product.title);
    
    settingDetail.product = product;
    //[self.navigationController pushViewController:settingDetail animated:YES];
    [self.navigationController presentModalViewController:settingDetail animated:YES];
    [settingDetail release];
    
    
}



/*- (IBAction) searchBarcode
{
    
    ZBarReader *settingDetail = [[ZBarReader alloc] initWithNibName:@"ZBarReader" bundle:nil];
    settingDetail.title = [NSString stringWithFormat:@"Barcode Reader"];
    //[self.navigationController pushViewController:settingDetail animated:YES];
    settingDetail.searchView = searchViewController;
    
    [self.navigationController presentModalViewController:settingDetail animated:YES];
    [settingDetail release];
    
    }
*/

@end
