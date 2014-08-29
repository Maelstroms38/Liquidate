//
//  MSProfileViewController.m
//  Liquidate
//
//  Created by Michael Stromer on 8/21/14.
//  Copyright (c) 2014 Michael Stromer. All rights reserved.
//

#import "MSProfileViewController.h"

@interface MSProfileViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *tagLineLabel;


@end
@implementation MSProfileViewController

- (void) viewDidLoad {
    PFFile *pictureFile = self.photo[kCCPhotoPictureKey];
    
    [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        
        self.profilePictureImageView.image = [UIImage imageWithData:data];
        
    }];
    
    PFUser *user = self.photo[kCCPhotoUserKey];
    
    self.locationLabel.text = user[kCCUserProfileKey][kCCUserProfileLocationKey];
    
    self.ageLabel.text = [NSString stringWithFormat:@"%@", user[kCCUserProfileKey][kCCUserProfileAgeKey]];
    
    if (user[kCCUserProfileKey][kCCUserProfileRelationshipStatusKey] == nil){
        
        self.statusLabel.text = @"Single";
        
    } else {
        
        self.statusLabel.text = user[kCCUserProfileKey][kCCUserProfileRelationshipStatusKey];
        
    }
    self.statusLabel.text = user[kCCUserProfileKey][kCCUserProfileRelationshipStatusKey];
    
    self.tagLineLabel.text = user[kCCUserTagLineKey];
    
    self.title = user[kCCUserProfileKey][kCCUserProfileFirstNameKey];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
}

#pragma mark - IBAction

- (IBAction)likeButtonPressed:(UIButton *)sender {
    [self.delegate didPressLike];
}
- (IBAction)dislikeButtonPressed:(UIButton *)sender {
    [self.delegate didPressDislike];
}

@end
