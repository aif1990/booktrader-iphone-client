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
    
    
    //[self.TableView reloadData];
    
    //self.TableView.scrollEnabled = YES;
     
    NSEnumerator *enums = [self.convers objectEnumerator];
    Conversations *item;
    
    CGFloat margine=0;
    
    while(item = [enums nextObject]) {
        
       // NSLog(@"object %@", item);
        //NSLog(@"body %@", item.body);

        UIView *subview = [[UIView alloc] init];
        
        UILabel *txt = [[UILabel alloc] init] ;
        
       // UITextField *txt = [[UITextField alloc] init];
                
        //UILabel *txt = [[UILabel alloc] initWithFrame:CGRectMake(0, margine, txt.frame.size.width, txt.frame.size.height)];
        
        txt.lineBreakMode = UILineBreakModeWordWrap;
        txt.numberOfLines = 0;
        
       // txt.backgroundColor = [UIColor redColor];
        
        //txt.editable = FALSE;
        
        char c;
        float nr=0;
        
        for (c=0; c< [item.body length]; c++)
            if ([item.body characterAtIndex:c] == '\n')
                nr++;
       // 
       // NSLog(@"new lines %d", nr);
        
        txt.text = item.body;
        
        float nb = [item.body length];
        
        [subview addSubview:txt];
        
        [txt sizeToFit];
        
        int hg = (int)(nb/45.0f + 0.5f + nr)*30;
        
        if (hg == 0)
            hg = 30;
        
        txt.frame = CGRectMake(0, 0, scrollView.frame.size.width, hg);
        
        [subview sizeToFit];
        subview.frame = CGRectMake(0, margine, subview.frame.size.width, subview.frame.size.height);

        
        //UIImageView *labelBackground = [[UIImageView alloc] 
                                        //initWithImage:[UIImage imageNamed:@"FP.jpg"]];
        //[txt addSubview:labelBackground];
            
       // [subview insertSubview:labelBackground belowSubview:txt];
        
       /// UIImage *image = [UIImage imageNamed:@"border.png"];
        
        
        NSLog(@"%@", username);
        NSLog(@"sender:%@", item.sender);
        
        if ([item.sender compare:username] == 0) {
        
            txt.backgroundColor = [UIColor clearColor]; 
            txt.backgroundColor = [UIColor colorWithRed:(255.0/255.0) green:(235.0/255.0) blue:(235.0/255.0) alpha:0.8];
            
        } else {
            
            txt.backgroundColor = [UIColor clearColor];
            txt.backgroundColor = [UIColor colorWithRed:(217.0/255.0) green:(255.0/255.0) blue:(169.0/255.0) alpha:0.8];
            
        }
        
        ///txt.backgroundColor = [UIColor colorWithPatternImage:image];
        
       /// CGImageRef imgRef = [image CGImage];
        
        ///CGFloat width = CGImageGetWidth(imgRef);
        ///CGFloat height = CGImageGetHeight(imgRef);
        ///CGRect bounds = CGRectMake(0, 0, width, height);
        ///CGSize size = bounds.size;
        
        ///CGAffineTransform transform = CGAffineTransformMakeScale(1.0, hg/height);
        
        //NSLog(@"height: %f, ours: %i", height, hg);
        
        ///UIGraphicsBeginImageContext(size);
        ///CGContextRef context = UIGraphicsGetCurrentContext();
        ///CGContextScaleCTM(context, 1.0, hg/height);
        //CGContextConcatCTM(context, transform);
        //CGImageRef cgImage = CGBitmapContextCreateImage(context);
        //UIImage* uiImage = [[UIImage imageWithCGImage:cgImage] retain];
        ///CGContextDrawImage(context, CGRectMake(0, 0, width, hg), imgRef);
        //[image drawInRect:bounds];
        ///UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        ///UIGraphicsEndImageContext();  
        
        ///txt.backgroundColor = [UIColor colorWithPatternImage:img];
        
        //UIImageView *backg = [[UIImageView alloc] initWithImage:img];
        
        //[subview insertSubview:backg belowSubview:txt];
        
        //labelBackground.contentMode = UIViewContentModeScaleAspectFill;
        
        //[labelBackground release];
               
        
       // txt.backgroundColor = [UIColor clearColor];
       // txt.backgroundColor = [UIColor grayColor];
        
        //txt.layer.borderColor = [UIColor blackColor];
        //txt.layer.borderWidth  = 3.0f;
        //[txt.layer display];
        
        
        
       // NSLog(@"nr caract. %.0f", nb);
        
                //labelBackground.frame = CGRectMake(0, 0, scrollView.frame.size.width, hg);
        
        //NSLog(@"%g", txt.frame.size.width);
        
                
        //subview.backgroundColor = [UIColor redColor];
        
        //subview.layer.borderColor = [UIColor redColor].CGColor;
        
       // subview.backgroundColor = [UIColor clearColor];
       // subview.backgroundColor = [UIColor redColor];
        
        //[subview.layer setBorderColor:[UIColor redColor]];
        
        //subview.layer.borderWidth = 3.0f;
        
       // [subview.layer setBorderWidth:3.0f];
       // [subview.layer display];
        
        
        
       // NSLog(@"subview %g:", txt.frame.size.height);
        
       [self.scrollView addSubview:subview];
        
        //[self.scrollView addSubview:txt];
        
        [txt setNeedsDisplay];
        
        margine += txt.frame.size.height+7;
        
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

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 return 1;
 }*/


/*// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"count = %d\n", self.books.count);
    return [self.convers count];
    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSLog(@"controller view\n");
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
    // NSLog(@"sunt in collection view");
    
	
    convs = [self.convers objectAtIndex:indexPath.row];
	
    
    //[cell.textLabel sizeThatFits:cell.frame.size];
    
	cell.textLabel.text = self.convs.body;
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 0;
    CGSize size = [cell.textLabel sizeThatFits:cell.frame.size];
    cell.frame = CGRectMake(120, 33, size.width, size.height);
    //cell.autoresizesSubviews = YES;
    
    //NSLog(@"text:%@", self.convs.body);
    
	//[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}



/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
	NSInteger row = [indexPath row];	
    
	product = [self.list objectAtIndex:indexPath.row];
	
    NewOwned *settings = [[NewOwned alloc] initWithNibName:@"NewOwned" bundle:nil];
    
    
    settings.collectionViewController = self;
    
    // NSLog(@"%@\n", product.title);
    
    
    settings.title = product.title;
    
    [[self navigationController] pushViewController:settings animated:YES];
    [settings release];
    
	
}*/



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


- (void)dealloc {
    
    
    //[TableView release];
   // [books release];
    [convers release];
    [super dealloc];
    
}


@end
