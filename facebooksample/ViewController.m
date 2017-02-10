//
//  ViewController.m
//  facebooksample
//
//  Created by Jhon Smith on 2/7/17.
//  Copyright © 2017 Jhon Smith. All rights reserved.
//

#import "ViewController.h"
#import "FBSDKCoreKit/FBSDKCoreKit.h"
#import "FBSDKLoginKit/FBSDKLoginKit.h"
#import "FBSDKLoginKit/FBSDKLoginManager.h"
#import "Content_viewcontroller.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onclick_facebook_login:(id)sender {
    NSLog(@"do facebook login");
    FBSDKLoginManager *login_manager = [[FBSDKLoginManager alloc] init];
    [login_manager logInWithReadPermissions:@[@"public_profile", @"user_friends"]
                         fromViewController:self
                                    handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if(error){
            NSLog(@"facebook login error: %@", error);
        }else if(result.isCancelled){
            NSLog(@"facebook login cancel");
        }else{
            if([result.grantedPermissions containsObject:@"public_profile"]){
                NSLog(@"facebook login succ and have public profile");
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main"
                                                                bundle:nil];
                UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"content"];
                [self presentViewController:vc animated:YES completion:NULL];
            }
        }
    }];
}
@end
