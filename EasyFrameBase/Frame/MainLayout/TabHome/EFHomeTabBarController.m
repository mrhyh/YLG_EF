//
//  TabBarController.m
//  rssreader
//
//  Created by zhuchao on 15/2/6.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

#import "EFHomeTabBarController.h"
#import "EFBaseNavigationController.h"

@interface EFHomeTabBarController ()<UITabBarControllerDelegate>
@end

@implementation EFHomeTabBarController

static EFHomeTabBarController *mainTab;

+ (EFHomeTabBarController*)shareInstance{
    static EFHomeTabBarController *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[EFHomeTabBarController alloc] init];
    });
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    mainTab = self;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

- (void)setUp{
    self.tabBar.translucent= NO;
    NSString *plistPath = nil;
    plistPath = [[NSBundle mainBundle] pathForResource:@"EasyFrame_" ofType:@"plist"];
    //如果没有创建EasyFrame_.plist文件，那么直接加载框架内部自带的
    if (plistPath == nil) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"EasyFrame" ofType:@"plist"];
    }
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath][@"MainLayout"];
    //加载底部Tabbar框架的配置
    dictionary = [dictionary objectForKey:@"TabHome"];
    NSArray * naviPages = [dictionary objectForKey:@"VCClassName"];
    NSArray * TitleArray = [dictionary objectForKey:@"TitleArray"];
    NSArray * NormalImageArray = [dictionary objectForKey:@"NormalImageArray"];
    NSArray * SelectedImageArray = [dictionary objectForKey:@"SelectedImageArray"];
    NSMutableArray * viewControllers = [NSMutableArray array];
    for (int i = 0; i < naviPages.count; i++) {
        const char *className = [[naviPages objectAtIndex:i] cStringUsingEncoding:NSUTF8StringEncoding];
        Class aClass = objc_getClass(className);
        UIViewController *vc = [[aClass alloc]init];
        vc.title = TitleArray[i];
        EFBaseNavigationController *nav = [[EFBaseNavigationController alloc] initWithRootViewController:vc];
        //        选择之前的图片
        [nav.tabBarItem setImage:[Img(NormalImageArray[i]) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        //选择之后的图片
        [nav.tabBarItem setSelectedImage:[Img(SelectedImageArray[i]) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        ////        选择后字体的颜色
        [nav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObject:[EFSkinThemeManager getTextColorWithKey:SkinThemeKey_TextColorTabberSelected] forKey:NSForegroundColorAttributeName] forState:UIControlStateHighlighted];
        //选择前字体的颜色
        [nav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObject:[EFSkinThemeManager getTextColorWithKey:SkinThemeKey_TextColorTabberNormal] forKey:NSForegroundColorAttributeName] forState:UIControlStateNormal];
        
        [viewControllers addObject:nav];
    }
    self.viewControllers = viewControllers;
}

@end
