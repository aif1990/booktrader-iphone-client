//
//  WantedViewController.h
//  books
//
//  Created by Andreea Ingrid Funie on 01/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Product;
@class LoginView;

@interface WantedViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
	
	IBOutlet UITableView *TableView;
	NSMutableArray *books;
    Product *product;
	LoginView *loginView;
    NSString *username;
    NSMutableArray			*list;
    
}
@property (nonatomic, retain) NSMutableArray *books;
@property (nonatomic, retain) UITableView *TableView;
@property (nonatomic, retain) Product *product;
@property (nonatomic, retain) LoginView *loginView;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSMutableArray *list;

@end
