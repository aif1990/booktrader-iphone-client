//
//  booksAppDelegate.h
//  books
//
//  Created by Andreea Ingrid Funie on 01/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "ZBarSDK/Headers/ZBarSDK/ZBarSDK.h"


#import "ZBarReader.h"
#import "NewDataController.h"
#import "JSON.h"
#import "Product.h"
#include "ZBarSDK/Headers/ZBarSDK/ZBarSDK.h"

@class CollectionViewController;
@class WantedViewController;
@class NavigationController;
@class NewMessageView;
@class SearchViewController;
@class Product;

@interface booksAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, ZBarReaderDelegate> {
    
	UIWindow *window;
    UITabBarController *tabBarController;
    IBOutlet NavigationController *navigationController;
    NSMutableArray *listContent;
    IBOutlet SearchViewController *searchViewController;
    NSArray *jsonArray;
    
    NSString *username;
    
    
    SearchViewController *searchView;
    Product *product;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) NSString *username;


@property (nonatomic, retain) SearchViewController *searchView;
@property (nonatomic, retain) Product *product;

@property (nonatomic, retain) NSMutableArray *listContent;
@property (nonatomic, retain) NSArray *jsonArray;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet NavigationController *navigationController;
@property (nonatomic, retain) IBOutlet SearchViewController *searchViewController;

- (IBAction)openNewMessageView;
- (IBAction) scanButtonTapped;
- (IBAction) exits;
//- (IBAction)searchBarcode;

@end
