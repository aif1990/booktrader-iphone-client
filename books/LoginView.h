//
//  LoginView.h
//  books
//
//  Created by Andreea Ingrid Funie on 02/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginView : UIViewController {
    
    IBOutlet UITextField *myusername;
    IBOutlet UITextField *mypassword;
    IBOutlet NSString *username;
    bool logged_in;
}

@property(nonatomic, retain) UITextField *myusername;
@property(nonatomic, retain) UITextField *mypassword;
@property(nonatomic, retain) NSString *username;
@property(nonatomic, assign) bool logged_in;

-(IBAction)back;
-(IBAction)textFieldDoneEditing:(id)sender;
-(IBAction)backgroundClick:(id)sender;
-(IBAction)login;

@end
