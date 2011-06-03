//
//  ChatViewController.h
//  books
//
//  Created by Andreea Ingrid Funie on 03/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BookDetailViewController;

@interface ChatViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
	
	IBOutlet UITableView *TableView;
	NSMutableArray *booksArray;
	BookDetailViewController *bookDetailViewController;
	
}

@property (nonatomic, retain) UITableView *TableView;
@property (nonatomic, retain) NSMutableArray *booksArray;
@property (nonatomic, retain) BookDetailViewController *bookDetailViewController;

@end

