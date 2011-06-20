//
//  Conversations.m
//  books
//
//  Created by Andreea Ingrid Funie on 12/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import "Conversations.h"

@implementation Conversations

@synthesize date, body, recipient, sender, subject, isOffer, identifier;


+ (id)productWithType:(NSString *)date body:(NSArray *)body recipient:(NSString *)recipient sender:(NSString *)sender subject:(NSString *)subject identifier:(NSString *)identifier
{
	Conversations *newConversation = [[[self alloc] init] autorelease];
	newConversation.date = date;
	newConversation.body = body;
    newConversation.recipient = recipient;
    newConversation.sender = sender;
    newConversation.subject = subject;
    newConversation.identifier = identifier;
    newConversation.isOffer = NO;
	return newConversation;
}


- (void)dealloc
{
	[date release];
	[body release];
    [recipient release];
    [sender release];
    [subject release];
    [identifier release];
	[super dealloc];
}

@end

