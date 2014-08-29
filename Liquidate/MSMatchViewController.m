//
//  MSMatchViewController.m
//  Liquidate
//
//  Created by Michael Stromer on 8/21/14.
//  Copyright (c) 2014 Michael Stromer. All rights reserved.
//

#import "MSMatchViewController.h"

@interface MSMatchViewController()

@property (strong, nonatomic) IBOutlet UIImageView *matchedUserImageView;

@property (strong, nonatomic) IBOutlet UIImageView *currentUserImageView;

@property (strong, nonatomic) IBOutlet UIButton *viewChatsButton;

@property (strong, nonatomic) IBOutlet UIButton *keepSearchingButton;

@end
@implementation MSMatchViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    
    PFQuery *query = [PFQuery queryWithClassName:kCCPhotoClassKey];
    [query  whereKey:kCCPhotoUserKey equalTo:[PFUser currentUser]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if ([objects count] > 0){
            
            PFObject *photo = objects[0];
            
            PFFile *pictureFile = photo[kCCPhotoPictureKey];
            
            [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                
                self.currentUserImageView.image = [UIImage imageWithData:data];
                
                self.matchedUserImageView.image = self.matchedUserImage;
                
            }];
            
        }
        
    }];
    
}
#pragma mark - IBActions
- (IBAction)viewChatsButtonPressed:(UIButton *)sender {
    [self.delegate presentMatchesViewController];
}
- (IBAction)keepSearchingButtonPressed:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
