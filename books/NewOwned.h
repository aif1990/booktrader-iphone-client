//
//  NewOwned.h
//  books
//
//  Created by Andreea Ingrid Funie on 11/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CollectionViewController;

@interface NewOwned : UIViewController {
    
    IBOutlet UILabel *bookTitle, *bookAuthor, *bookPublisher;
    IBOutlet UIImageView *imageView, *imageView2;
    
    CollectionViewController *collectionViewController;
    
}

@property (nonatomic, retain) UILabel *bookTitle, *bookAuthor, *bookPublisher;
@property (nonatomic, retain) UIImageView *imageView, *imageView2;
@property (nonatomic, retain) CollectionViewController *collectionViewController;

@end
