//
//  NewMessageView.h
//  books
//
//  Created by Andreea Ingrid Funie on 03/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewMessageView : UIViewController {
    
    IBOutlet UITextField *recipient;
    IBOutlet UITextField *subject;
    IBOutlet UITextView *message;
    IBOutlet UIAlertView *alert;
    
}

@property(nonatomic, retain) UITextField *recipient;
@property(nonatomic, retain) UITextField *subject;
@property(nonatomic, retain) UITextView *message;
@property(nonatomic, retain) UIAlertView *alert;

-(IBAction)textFieldDoneEditing:(id)sender;
-(IBAction)backgroundClick:(id)sender;
-(IBAction)send;

@end

