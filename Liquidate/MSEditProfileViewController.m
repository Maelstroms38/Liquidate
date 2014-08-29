//
//  MSEditProfileViewController.m
//  Liquidate
//
//  Created by Michael Stromer on 8/21/14.
//  Copyright (c) 2014 Michael Stromer. All rights reserved.
//

#import "MSEditProfileViewController.h"

@interface MSEditProfileViewController () <UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *tagLineTextView;
@property (strong, nonatomic) IBOutlet UIImageView *profilePictureImageView;

@end

@implementation MSEditProfileViewController

-(void) viewDidLoad {
    
    self.tagLineTextView.delegate = self;
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    PFQuery *query = [PFQuery queryWithClassName:kCCPhotoClassKey];
    
    [query whereKey:kCCPhotoUserKey equalTo:[PFUser currentUser]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if ([objects count] > 0){
            
            PFObject *photo = objects[0];
            
            PFFile *pictureFile = photo[kCCPhotoPictureKey];
            
            [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                
                self.profilePictureImageView.image = [UIImage imageWithData:data];
                
            }];
            
        }
        
    }];
    
    self.tagLineTextView.text = [[PFUser currentUser] objectForKey:kCCUserTagLineKey];
}

#pragma mark - TextView Delegate

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender {
   
    [[PFUser currentUser] setObject:self.tagLineTextView.text forKey:kCCUserTagLineKey];
    
    [[PFUser currentUser] saveInBackground];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
    [self.tagLineTextView resignFirstResponder];
    [[PFUser currentUser] setObject:self.tagLineTextView.text forKey:kCCUserTagLineKey];
    
    [[PFUser currentUser] saveInBackground];
    
    [self.navigationController popViewControllerAnimated:YES];
    return NO;
} else {
    return YES;
}
}
@end
