//
//  MSMatchViewController.h
//  Liquidate
//
//  Created by Michael Stromer on 8/21/14.
//  Copyright (c) 2014 Michael Stromer. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MSMatchViewControllerDelegate <NSObject>
-(void)presentMatchesViewController;
@end
@interface MSMatchViewController : UIViewController

@property (strong, nonatomic) UIImage *matchedUserImage;
@property (weak, nonatomic) id <MSMatchViewControllerDelegate> delegate;

@end
