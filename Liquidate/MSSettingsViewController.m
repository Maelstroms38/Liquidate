//
//  MSSettingsViewController.m
//  Liquidate
//
//  Created by Michael Stromer on 8/21/14.
//  Copyright (c) 2014 Michael Stromer. All rights reserved.
//

#import "MSSettingsViewController.h"

@interface MSSettingsViewController ()
@property (strong, nonatomic) IBOutlet UISlider *ageSlider;
@property (strong, nonatomic) IBOutlet UISwitch *menSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *womenSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *singleSwitch;
@property (strong, nonatomic) IBOutlet UIButton *logButton;
@property (strong, nonatomic) IBOutlet UIButton *editProfileButton;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;

@end

@implementation MSSettingsViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    self.ageSlider.value = [[NSUserDefaults standardUserDefaults] integerForKey:kCCAgeMaxKey];
    
    self.menSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kCCMenEnabledKey];
    
    self.womenSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kCCWomenEnabledKey];
    
    self.singleSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kCCSingleEnabledKey];
    
    [self.ageSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.menSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.womenSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.singleSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    //setup UI
    
    self.ageLabel.text = [NSString stringWithFormat:@"%i",(int)self.ageSlider.value];
    
}



#pragma mark - IBActions
- (IBAction)logoutButtonPressed:(UIButton *)sender {
    
    [PFUser logOut];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)editProfileButtonPressed:(UIButton *)sender {
}

#pragma mark - Helper Methods
-(void)valueChanged:(id)sender

{
    
    if (sender == self.ageSlider)
        
    {
        
        [[NSUserDefaults standardUserDefaults] setInteger:self.ageSlider.value forKey:kCCAgeMaxKey];
        
        self.ageLabel.text = [NSString stringWithFormat:@"%i",(int)self.ageSlider.value];
        
    }
    
    else if (sender == self.menSwitch)
        
    {
        
        [[NSUserDefaults standardUserDefaults] setBool:self.menSwitch.isOn forKey:kCCMenEnabledKey];
        
    }
    
    else if (sender == self.womenSwitch)
        
    {
        
        [[NSUserDefaults standardUserDefaults] setBool:self.womenSwitch.isOn forKey:kCCWomenEnabledKey];
        
    }
    
    else if (sender == self.singleSwitch)
        
    {
        
        [[NSUserDefaults standardUserDefaults] setBool:self.singleSwitch.isOn forKey:kCCSingleEnabledKey];
        
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


@end
