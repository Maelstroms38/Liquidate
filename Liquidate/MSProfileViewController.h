//
//  MSProfileViewController.h
//  Liquidate
//
//  Created by Michael Stromer on 8/21/14.
//  Copyright (c) 2014 Michael Stromer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MSProfileViewController <NSObject>

-(void)didPressLike;
-(void)didPressDislike;

@end
@interface MSProfileViewController : UIViewController

@property (strong, nonatomic) PFObject *photo;
@property (weak, nonatomic) id <MSProfileViewController> delegate;

@end
