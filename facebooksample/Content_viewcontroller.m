//
//  Content_viewcontroller.m
//  facebooksample
//
//  Created by Jhon Smith on 2/7/17.
//  Copyright © 2017 Jhon Smith. All rights reserved.
//

#import "Content_viewcontroller.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
@interface Content_viewcontroller ()

@end
@implementation Facebook_friend


@end
@implementation Content_viewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self init_like_view];
}

- (void)init_like_view{
    FBSDKLikeControl *likeButton = [[FBSDKLikeControl alloc] init];
    likeButton.objectID = @"https://www.facebook.com/pages/Clannad-After-Story/107957089231713";
    likeButton.center = self.view.center;
    [self.view addSubview:likeButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)show_alertview_with_title:(NSString *)title msg:(NSString *)msg{
    UIAlertController *alert_c = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        NSLog(@"alert view cancel click");
    }];
    [alert_c addAction:cancle];
    [self presentViewController:alert_c animated:YES completion:nil];
}
//facebook game request
- (IBAction)facebook_game_request:(id)sender {
    //https://developers.facebook.com/docs/games/services/gamerequests
    FBSDKGameRequestContent *gameRequestContent = [[FBSDKGameRequestContent alloc] init];
    // Look at FBSDKGameRequestContent for futher optional properties
    gameRequestContent.message = @"facebook game request msg";
    gameRequestContent.title = @"facebook game request title";
    
    // Assuming self implements <FBSDKGameRequestDialogDelegate>
    [FBSDKGameRequestDialog showWithContent:gameRequestContent delegate:self];
}

//facebook game request callbak
- (void)gameRequestDialog:(FBSDKGameRequestDialog *)gameRequestDialog didCompleteWithResults:(NSDictionary *)results{
    NSLog(@"facebook game request complete result: %@", results);
    [self show_alertview_with_title:@"game request" msg:[NSString stringWithFormat:@"succ, %@", results.description]];
}
- (void)gameRequestDialog:(FBSDKGameRequestDialog *)gameRequestDialog didFailWithError:(NSError *)error{
    NSLog(@"facebook game request error %@", error.description);
    [self show_alertview_with_title:@"game request" msg:[NSString stringWithFormat:@"error, %@", error.description]];
}
- (void)gameRequestDialogDidCancel:(FBSDKGameRequestDialog *)gameRequestDialog{
    NSLog(@"facebook game request cancel");
    [self show_alertview_with_title:@"game request" msg:@"user cancel"];
}
//
//facebook app inivte
- (IBAction)facebook_app_invite:(id)sender {
    //https://developers.facebook.com/docs/app-invites/ios
    //facebook app link 托管平台 https://developers.facebook.com/quickstarts/?platform=app-links-host
    NSString *url = @"https://fb.me/598118950379650";
    NSString *image_url = @"http://cdn.akamai.steamstatic.com/steam/apps/324160/header.jpg?t=1481497442";
    FBSDKAppInviteContent *content = [[FBSDKAppInviteContent alloc] init];
    content.appLinkURL = [NSURL URLWithString:url];
    content.appInvitePreviewImageURL = [NSURL URLWithString:image_url];
    [FBSDKAppInviteDialog showFromViewController:self
                                     withContent:content
                                        delegate:self];
}
//facebook app invite callback
- (void)appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didCompleteWithResults:(NSDictionary *)results{
    NSLog(@"app invite succ %@", results.description);
    [self show_alertview_with_title:@"app invite" msg:[NSString stringWithFormat:@"succ, %@", results.description]];
}
- (void)appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didFailWithError:(NSError *)error{
    NSLog(@"app invite error %@", error.description);
    [self show_alertview_with_title:@"app invite" msg:[NSString stringWithFormat:@"error, %@", error.description]];
}
//
- (IBAction)facebook_link_share:(id)sender {
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:@"http://www.clannadbar.com"];
    content.imageURL = [NSURL URLWithString:@"http://cdn.akamai.steamstatic.com/steam/apps/324160/header.jpg?t=1481497442"];
    [FBSDKShareDialog showFromViewController:self
                                 withContent:content
                                    delegate:self];
}
//facebook share callback
- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results{
    NSLog(@"facebook share succ %@", results.description);
    [self show_alertview_with_title:@"share" msg:[NSString stringWithFormat:@"succ, %@", results.description]];
}
    

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error{
    NSLog(@"facebook share fail %@", error.description);
    [self show_alertview_with_title:@"share" msg:[NSString stringWithFormat:@"fail, %@", error.description]];
}
    
- (void)sharerDidCancel:(id<FBSDKSharing>)sharer{
    NSLog(@"facebook share cancle");
    [self show_alertview_with_title:@"share" msg:[NSString stringWithFormat:@"user cancel"]];
}
//
- (IBAction)facebook_object_share:(id)sender {
    //https://developers.facebook.com/docs/sharing/ios
    NSDictionary *properties = @{
                                 @"og:type": @"fitness.course",
                                 @"og:title": @"Sample Course",
                                 @"og:description": @"This is a sample course.",
                                 @"fitness:duration:value": @100,
                                 @"fitness:duration:units": @"s",
                                 @"fitness:distance:value": @12,
                                 @"fitness:distance:units": @"km",
                                 @"fitness:speed:value": @5,
                                 @"fitness:speed:units": @"m/s",
                                 };
    FBSDKShareOpenGraphObject *object = [FBSDKShareOpenGraphObject objectWithProperties:properties];
    FBSDKShareOpenGraphAction *action = [[FBSDKShareOpenGraphAction alloc] init];
    action.actionType = @"fitness.runs";
    [action setObject:object forKey:@"fitness:course"];
    FBSDKShareOpenGraphContent *content = [[FBSDKShareOpenGraphContent alloc] init];
    content.action = action;
    content.previewPropertyName = @"fitness:course";
    [FBSDKShareDialog showFromViewController:self
                                 withContent:content
                                    delegate:self];
}
    
- (IBAction)facebook_screenshot_share:(id)sender {
    //https://developers.facebook.com/docs/sharing/ios
    FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
    photo.image = [self screenshot:self.view];
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    content.photos = @[photo];
    [FBSDKShareDialog showFromViewController:self
                                 withContent:content
                                    delegate:self];
}
//screenshot method
-(UIImage *)screenshot:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// facebook get friends via graph api
- (IBAction)facebook_inapp_friends:(id)sender {
    //https://developers.facebook.com/docs/graph-api/reference/user/friends
    NSDictionary *params = @{
                             @"fields":@"id,name,picture"
                             };
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:[NSString stringWithFormat:@"/%@/friends", [FBSDKAccessToken currentAccessToken].userID]
                                  parameters:params
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error) {
        NSLog(@"facebook graph api get friends %i", (int)[[result objectForKey:@"data"]count]);
        NSArray *friends_array = [result objectForKey:@"data"];
        _fb_friends_array = [[NSMutableArray alloc] init];
        for(id friend in friends_array){
            Facebook_friend *ff = [[Facebook_friend alloc] init];
            ff.name = [friend objectForKey:@"name"];
            ff.id = [friend objectForKey:@"id"];
            ff.image_url = [[[friend objectForKey:@"picture"]objectForKey:@"data"]objectForKey:@"url"];
            [_fb_friends_array addObject:ff];
        }
        _friends_tableview.dataSource = self;
        _friends_tableview.delegate = self;
        [_friends_tableview reloadData];
    }];
}
    
//friends datasource protocol
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_fb_friends_array count];
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2
                                                  reuseIdentifier:nil];
    Facebook_friend *ff = [_fb_friends_array objectAtIndex:(int)indexPath.item];
    cell.textLabel.text = ff.name;
    cell.detailTextLabel.text = ff.id;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //facebook game request https://developers.facebook.com/docs/games/services/gamerequests
    Facebook_friend *ff = [_fb_friends_array objectAtIndex:(int)indexPath.item];
    FBSDKGameRequestContent *content = [[FBSDKGameRequestContent alloc] init];
    content.message = @"game request message";
    content.recipients = @[ff.id];
    content.actionType = FBSDKGameRequestActionTypeTurn;
    [FBSDKGameRequestDialog showWithContent:content
                                   delegate:self];
}
@end
