//
//  Conversations.h
//  books
//
//  Created by Andreea Ingrid Funie on 12/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

@interface Conversations : NSObject {
	NSString *date;
	NSString *body;
    NSString *recipient;
    NSString *sender;
    NSString *subject;
    NSString *identifier;
    BOOL isOffer;
}

@property (nonatomic, copy) NSString *date, *body;
@property (nonatomic, copy) NSString *recipient;
@property (nonatomic, copy) NSString *sender, *subject, *identifier;
@property (nonatomic, assign) BOOL isOffer;

+ (id)productWithType:(NSString *)date body:(NSArray *)body recipient:(NSString *)recipient sender:(NSString*)sender subject:(NSString*)subject identifier:(NSString*)identifier;

@end

