//
//  BooksViewController.h
//  books
//
//  Created by Andreea Ingrid Funie on 01/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BookDetailViewController;

@interface BooksViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource> {
	
	IBOutlet UITableView *TableView;
	NSMutableArray *booksArray;
	BookDetailViewController *bookDetailViewController;
    NSString *username;
	
}
@property (nonatomic, retain) NSMutableArray *booksArray;
@property (nonatomic, retain) BookDetailViewController *bookDetailViewController;
@property (nonatomic, retain) UITableView *TableView;
@property (nonatomic, retain) NSString *username;

@end

