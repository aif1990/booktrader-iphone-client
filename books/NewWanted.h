//
//  NewWanted.h
//  books
//
//  Created by Andreea Ingrid Funie on 11/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WantedViewController;

@interface NewWanted : UIViewController {
    
    IBOutlet UILabel *bookTitle, *bookAuthor, *bookPublisher;
    IBOutlet UIImageView *imageView;
    
    WantedViewController *collectionViewController;
    
}

@property (nonatomic, retain) UILabel *bookTitle, *bookAuthor, *bookPublisher;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) WantedViewController *collectionViewController;

@end