//
//  MSChatViewController.h
//  Liquidate
//
//  Created by Michael Stromer on 8/21/14.
//  Copyright (c) 2014 Michael Stromer. All rights reserved.
//

#import "JSMessagesViewController.h"

@interface MSChatViewController : JSMessagesViewController <JSMessagesViewDataSource, JSMessagesViewDelegate>

@property (strong, nonatomic) PFObject *chatroom;

@end
