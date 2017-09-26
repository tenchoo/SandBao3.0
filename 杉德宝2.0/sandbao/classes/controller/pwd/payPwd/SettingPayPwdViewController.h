//
//  SettingPayPwdViewController.h
//  sandbao
//
//  Created by tianNanYiHao on 2017/1/18.
//  Copyright © 2017年 sand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingPayPwdViewController : UIViewController

@property (nonatomic, strong) NSArray *regAuthToolsArray;
@property (nonatomic, strong) NSString *loginPwd;
@property (nonatomic, strong) NSString *phoneNumStr;
@property (nonatomic, assign) BOOL registerFlag; //是否注册


//第三方注册所需属性
@property (nonatomic, assign) BOOL thirdRegistFlag; //是否第三方注册
@property (nonatomic, strong) NSString *nick; //微博微信昵称名->上送杉德宝做用户姓名
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *firm;
@property (nonatomic, strong) NSString *userUnionid;


@property (nonatomic, assign)BOOL isOtherAPPSPS;// 是否其他App启动SPA
@property (nonatomic, strong) NSString *otherAPPSPSurl; //启动的url
@end
