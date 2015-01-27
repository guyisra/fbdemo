//
//  ViewController.m
//  FBDemo
//
//  Created by Guy Israeli on 1/5/15.
//  Copyright (c) 2015 Guy Israeli. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *loginStatus;

@property (weak, nonatomic) IBOutlet UILabel *loginName;
@property (weak, nonatomic) IBOutlet FBLoginView *loginButton;
@property (weak, nonatomic) IBOutlet FBProfilePictureView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

-(void)toggleHiddenState:(BOOL)shouldHide;

@end

@implementation ViewController

-(void)toggleHiddenState:(BOOL)shouldHide{
    self.loginName.hidden = shouldHide;
    self.emailLabel.hidden = shouldHide;
    self.profilePicture.hidden = shouldHide;
}

-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
    self.loginStatus.text = @"You are logged out";
    
    [self toggleHiddenState:YES];
}

-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
    NSLog(@"%@", [error localizedDescription]);
}

-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
    self.loginStatus.text = @"You are logged in.";


    [self toggleHiddenState:NO];
}

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
    NSLog(@"%@", user);
    self.profilePicture.profileID = user.objectID;
    self.loginName.text = user.name;
    self.emailLabel.text = [user objectForKey:@"email"];
    
  
    
    
    NSString *token = [[[FBSession activeSession] accessTokenData] accessToken];
    NSLog(@"%@",token);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.loginButton.delegate = self;

    [self toggleHiddenState:YES];
    self.loginStatus.text = @"";
    self.loginButton.readPermissions = @[@"email", @"user_birthday", @"offline_access", @"user_likes", @"friends_likes"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
