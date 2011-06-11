//
//  NewDataController.h
//  books
//
//  Created by Andreea Ingrid Funie on 08/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchViewController;

@interface NewDataController : UIViewController {
    
    IBOutlet UILabel *bookTitle, *bookAuthor, *bookPublisher;
    IBOutlet UIImageView *imageView;
    IBOutlet UISegmentedControl *segmentedControl;
    
    SearchViewController *searchViewController;
    
}

@property (nonatomic, retain) UILabel *bookTitle, *bookAuthor, *bookPublisher;
@property (nonatomic, retain) UISegmentedControl *segmentedControl;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) SearchViewController *searchViewController;

-(IBAction) segmentedControlIndexChanged;
-(IBAction) have;
-(IBAction) want;

@end