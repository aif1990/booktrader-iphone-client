//
//  booksAppDelegate.h
//  books
//
//  Created by Andreea Ingrid Funie on 01/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CollectionViewController;
@class WantedViewController;
@class NavigationController;
@class NewMessageView;
@class SearchViewController;

@interface booksAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    
	UIWindow *window;
    UITabBarController *tabBarController;
    IBOutlet NavigationController *navigationController;
    NSMutableArray *listContent;
    IBOutlet SearchViewController *searchViewController;
    NSArray *jsonArray;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) NSMutableArray *listContent;
@property (nonatomic, retain) NSArray *jsonArray;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet NavigationController *navigationController;
@property (nonatomic, retain) IBOutlet SearchViewController *searchViewController;

- (IBAction)openNewMessageView;

@end
