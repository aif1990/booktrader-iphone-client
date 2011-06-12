//
//  Conversations.m
//  books
//
//  Created by Andreea Ingrid Funie on 12/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import "Conversations.h"

@implementation Conversations

@synthesize date, body, recipient, sender, subject;


+ (id)productWithType:(NSString *)date body:(NSArray *)body recipient:(NSString *)recipient sender:(NSString *)sender subject:(NSString *)subject
{
	Conversations *newConversation = [[[self alloc] init] autorelease];
	newConversation.date = date;
	newConversation.body = body;
    newConversation.recipient = recipient;
    newConversation.sender = sender;
    newConversation.subject = subject;
	return newConversation;
}


- (void)dealloc
{
	[date release];
	[body release];
    [recipient release];
    [sender release];
    [subject release];
	[super dealloc];
}

@end

