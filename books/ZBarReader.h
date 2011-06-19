//
//  ZBarReader.h
//  books
//
//  Created by Andreea Ingrid Funie on 19/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//


#import <UIKit/UIKit.h>
#include "ZBarSDK/Headers/ZBarSDK/ZBarSDK.h"

@class SearchViewController;

@interface ZBarReader
: UIViewController
// ADD: delegate protocol
< ZBarReaderDelegate >
{
    UIImageView *resultImage;
    UITextView *resultText;
    SearchViewController *searchView;
}
@property (nonatomic, retain) IBOutlet UIImageView *resultImage;
@property (nonatomic, retain) IBOutlet UITextView *resultText;
@property (nonatomic, retain) SearchViewController *searchView;
- (IBAction) scanButtonTapped;
@end
