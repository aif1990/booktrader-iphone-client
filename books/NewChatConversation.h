//
//  NewChatConversation.h
//  books
//
//  Created by Andreea Ingrid Funie on 13/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Conversations;
@class LoginView;

@interface NewChatConversation : UIViewController<UIScrollViewDelegate> {
	
	IBOutlet UITableView *TableView;
	NSMutableArray *books;
    Conversations *convs;
	LoginView *loginView;
    NSMutableArray			*convers;
    IBOutlet UIScrollView *scrollView;
    
}
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *books;
@property (nonatomic, retain) UITableView *TableView;
@property (nonatomic, retain) Conversations *convs;
@property (nonatomic, retain) LoginView *loginView;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSMutableArray *convers;

@end
