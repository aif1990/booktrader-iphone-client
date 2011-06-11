//
//  HomeViewController.h
//  books
//
//  Created by Andreea Ingrid Funie on 01/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BookDetailViewController;
@class LoginView;
@class BooksViewController;

@interface HomeViewController : UIViewController <UIActionSheetDelegate> {
    
    BookDetailViewController *bookDetailViewController;
    IBOutlet UILabel *welcomeMessage;
    LoginView *loginView;
    IBOutlet BooksViewController *booksViewController;
}

- (IBAction)showActionSheet;
- (void)actionSheet:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)openLoginView;
- (void)openRegisterView;
- (void)Logout;

@property(nonatomic, retain) LoginView *loginView;
@property(nonatomic, retain) UILabel *welcomeMessage;
@property (nonatomic, retain) BookDetailViewController *bookDetailViewController;
@property (nonatomic, retain) BooksViewController *booksViewController;

@end
