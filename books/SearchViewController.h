//
//  SearchViewController.h
//  books
//
//  Created by Andreea Ingrid Funie on 01/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BookDetailViewController;

@interface SearchViewController : UIViewController <UISearchDisplayDelegate, UISearchBarDelegate, UITableViewDelegate>
{
	NSMutableArray			*listContent;			// The master content.
    NSArray         *jsonArray;
	NSMutableArray	*filteredListContent;	// The content filtered as a result of a search.
	IBOutlet UITableView *TableView;

    
	// The saved state of the search UI if a memory warning removed the view.
    NSString		*savedSearchTerm;
    NSInteger		savedScopeButtonIndex;
    BOOL			searchWasActive;
    
    BookDetailViewController *bookDetailViewController;
}

@property (nonatomic, retain) NSMutableArray *listContent;
@property (nonatomic, retain) NSArray *jsonArray;
@property (nonatomic, retain) NSMutableArray *filteredListContent;
@property (nonatomic, retain) UITableView *TableView;


@property (nonatomic, retain) BookDetailViewController *bookDetailViewController;

@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;

@end
