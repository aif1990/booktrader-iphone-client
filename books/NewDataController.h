//
//  NewDataController.h
//  books
//
//  Created by Andreea Ingrid Funie on 08/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchViewController;
@class CollectionViewController;

@interface NewDataController : UIViewController {
    
    IBOutlet UILabel *bookTitle, *bookAuthor, *bookPublisher;
    IBOutlet UIImageView *imageView, *imageView2;
    IBOutlet UISegmentedControl *segmentedControl;
    
    SearchViewController *searchViewController;
    CollectionViewController *collectionViewController;
    
}

@property (nonatomic, retain) UILabel *bookTitle, *bookAuthor, *bookPublisher;
@property (nonatomic, retain) UISegmentedControl *segmentedControl;
@property (nonatomic, retain) UIImageView *imageView,*imageView2;
@property (nonatomic, retain) SearchViewController *searchViewController;
@property (nonatomic, retain) CollectionViewController *collectionViewController;

-(IBAction) segmentedControlIndexChanged;
-(IBAction) have;
-(IBAction) want;

@end
