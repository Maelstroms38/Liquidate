//
//  MSMatchesViewController.m
//  Liquidate
//
//  Created by Michael Stromer on 8/21/14.
//  Copyright (c) 2014 Michael Stromer. All rights reserved.
//

#import "MSMatchesViewController.h"
#import "MSChatViewController.h"

@interface MSMatchesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *availableChatRooms;

@end

@implementation MSMatchesViewController


-(NSMutableArray *)availableChatRooms {
    if (!_availableChatRooms){
        _availableChatRooms = [[NSMutableArray alloc] init];
    }
    return _availableChatRooms;
}
- (void)viewDidLoad

{
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    // [self createFakeChats];
    
    _availableChatRooms = [[NSMutableArray alloc] init];
    
    [self updateAvailableChatRooms];
    
}
-(void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    MSChatViewController *chatVC = segue.destinationViewController;
    
    NSIndexPath *indexPath = sender;
    
    chatVC.chatroom = [self.availableChatRooms objectAtIndex:indexPath.row];
    
}
#pragma mark - Helper Methods

-(void) updateAvailableChatRooms {
    PFQuery *query = [PFQuery queryWithClassName:@"ChatRoom"];
    
    [query whereKey:@"user1" equalTo:[PFUser currentUser]];
    
    PFQuery *queryInverse = [PFQuery queryWithClassName:@"ChatRoom"];
    
    [query whereKey:@"user2" equalTo:[PFUser currentUser]];
    
    PFQuery *queryCombined = [PFQuery orQueryWithSubqueries:@[query, queryInverse]];
    
    [queryCombined includeKey:@"chat"];
    
    [queryCombined includeKey:@"user1"];
    
    [queryCombined includeKey:@"user2"];
    
    [queryCombined findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            
            [self.availableChatRooms removeAllObjects];
            
            self.availableChatRooms = [objects mutableCopy];
            
            [self.tableView reloadData];
            
        }
        
    }];
    
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return [self.availableChatRooms count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFObject *chatroom = [self.availableChatRooms objectAtIndex:indexPath.row];
    
    PFUser *likedUser;
    
    PFUser *currentUser = [PFUser currentUser];
    
    PFUser *testUser1 = chatroom[@"user1"];
    
    if ([testUser1.objectId isEqual:currentUser.objectId]) {
        
        likedUser = [chatroom objectForKey:@"user2"];
        
    }
    
    else {
        
        likedUser = [chatroom objectForKey:@"user1"];
        
    }
    
    cell.textLabel.text = likedUser[@"profile"][@"firstName"];
    
    return cell;
    
    //need a placeholder image here.
    
    cell.imageView.image = [UIImage imageNamed:@"avatar-placeholder.png"];
    
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    PFQuery *queryForPhoto = [[PFQuery alloc] initWithClassName:@"Photo"];
    
    [queryForPhoto whereKey:@"user" equalTo:likedUser];
    
    [queryForPhoto findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if ([objects count] > 0){
            
            PFObject *photo = objects[0];
            
            PFFile *pictureFile = photo[kCCPhotoPictureKey];
            
            [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                
                cell.imageView.image = [UIImage imageWithData:data];
                
                cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
                
            }];
            
        }
        
    }];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    [self performSegueWithIdentifier:@"matchesToChatSegue" sender:indexPath];
    
}


@end
