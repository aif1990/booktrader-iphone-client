//
//  ChatViewController.h
//  books
//
//  Created by Andreea Ingrid Funie on 03/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Conversations;
@class LoginView;
@class booksAppDelegate;

@interface ChatViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
	
	IBOutlet UITableView *TableView;
	NSMutableArray *books;
    Conversations *conversation;
	LoginView *loginView;
    NSString *username;
    NSMutableDictionary		*list;
    NSMutableArray *keys;
    NSMutableArray *msg;
    
    IBOutlet booksAppDelegate *book;
    
    
}
@property(nonatomic, retain) booksAppDelegate *book;

@property (nonatomic, retain) NSMutableArray *books, *msg;
@property (nonatomic, retain) UITableView *TableView;
@property (nonatomic, retain) Conversations *conversation;
@property (nonatomic, retain) LoginView *loginView;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSMutableDictionary *list;
@property (nonatomic, retain) NSMutableArray *keys;

@end

