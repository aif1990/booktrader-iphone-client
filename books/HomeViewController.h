//
//  HomeViewController.h
//  books
//
//  Created by Andreea Ingrid Funie on 01/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BookDetailViewController;

@interface HomeViewController : UIViewController <UIActionSheetDelegate> {
    
    BookDetailViewController *bookDetailViewController;
    
}

- (IBAction)showActionSheet;
- (void)actionSheet:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)openLoginView;
- (void)openRegisterView;
- (void)Logout;

@property (nonatomic, retain) BookDetailViewController *bookDetailViewController;

@end
