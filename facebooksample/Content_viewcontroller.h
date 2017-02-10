//
//  Content_viewcontroller.h
//  facebooksample
//
//  Created by Jhon Smith on 2/7/17.
//  Copyright © 2017 Jhon Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface Content_viewcontroller : UIViewController<FBSDKGameRequestDialogDelegate, FBSDKAppInviteDialogDelegate, FBSDKSharingDelegate, UITableViewDataSource, UITableViewDelegate>
- (IBAction)facebook_game_request:(id)sender;
- (IBAction)facebook_app_invite:(id)sender;
- (IBAction)facebook_link_share:(id)sender;
- (IBAction)facebook_object_share:(id)sender;
- (IBAction)facebook_screenshot_share:(id)sender;
- (IBAction)facebook_inapp_friends:(id)sender;
    @property (weak, nonatomic) IBOutlet UITableView *friends_tableview;
    @property (nonatomic)NSMutableArray *fb_friends_array;

@end

@interface Facebook_friend : NSObject
    
    @property (nonatomic) NSString *name;
    @property (nonatomic) NSString *id;
    @property (nonatomic) NSString *image_url;
@end
