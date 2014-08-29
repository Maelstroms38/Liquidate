//
//  MSTransitionAnimator.h
//  Liquidate
//
//  Created by Michael Stromer on 8/26/14.
//  Copyright (c) 2014 Michael Stromer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL presenting;  

@end
