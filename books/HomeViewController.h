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
    IBOutlet UILabel *welcomeMessage, *wantedBooksNb, *ownedBooksNb;
    LoginView *loginView;
    IBOutlet BooksViewController *booksViewController;
    IBOutlet UIImageView *imgView;
    IBOutlet UIImageView *logIm;
    
}

- (IBAction)showActionSheet;
- (void)actionSheet:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)openLoginView;
- (void)openRegisterView;
- (void)Logout;

@property (nonatomic, retain) UIImageView *logIm;
@property (nonatomic, retain) UIImageView *imgView;
@property(nonatomic, retain) LoginView *loginView;
@property(nonatomic, retain) UILabel *welcomeMessage, *wantedBooksNb, *ownedBooksNb;
@property (nonatomic, retain) BookDetailViewController *bookDetailViewController;
@property (nonatomic, retain) BooksViewController *booksViewController;

@end
