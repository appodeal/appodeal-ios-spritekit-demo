//
//  NativeScene.m
//  SpriteKitDemoApp
//
//  Created by Lozhkin Ilya on 6/6/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "NativeScene.h"
#import "BoxNode.h"
#import <Appodeal/Appodeal.h>

@interface NativeScene ()<SKPhysicsContactDelegate, AppodealNativeAdDelegate, AppodealNativeAdServiceDelegate>

@property (nonatomic, strong) UIViewController * controller;
@property (nonatomic, strong) AppodealNativeAdService * nativeService;
@property (nonatomic, strong) NSMutableArray <__kindof BoxNode *> * boxArray;
@property (nonatomic, strong) NSMutableArray <__kindof UIView *> * staticBoxArray;
@property (nonatomic, strong) NSMutableArray <__kindof AppodealNativeAd *> * nativeArray;

@property (nonatomic, strong) AppodealNativeAdViewAttributes* attributes;

@end

@implementation NativeScene

- (instancetype) initWithSize:(CGSize)size onController:(UIViewController *)controller{
    self = [super initWithSize:size];
    if (self) {
        self.controller = controller;
        self.boxArray = [NSMutableArray array];
        self.nativeArray = [NSMutableArray array];
        self.staticBoxArray = [NSMutableArray array];
    }
    return self;
}

- (void) didMoveToView:(SKView *)view{
    [super didMoveToView:view];
    
    {
        self.nativeService = [[AppodealNativeAdService alloc] init];
        [self.nativeService loadAd];
        self.nativeService.delegate = self;
    }
    
    [self setup];
}

- (void) setup {
    [self createBackground];
//    [self createBoxArray];
    [self createStaticBoxArray];
}

- (AppodealNativeAdViewAttributes *) attributes{
    if (!_attributes) {
        _attributes = [[AppodealNativeAdViewAttributes alloc] init];
        _attributes.sponsored = YES;
        _attributes.buttonColor = [UIColor blueColor];
    }
    return _attributes;
}

- (void)createBackground{
    SKTexture * texture = [SKTexture textureWithImageNamed:@"Background"];
    SKSpriteNode * backgroundNode = [SKSpriteNode spriteNodeWithTexture:texture];
    backgroundNode.position = (CGPoint) {CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame)};
    
    self.scaleMode = SKSceneScaleModeAspectFit;
    self.physicsWorld.contactDelegate = self;
    self.physicsWorld.gravity = CGVectorMake(0, -0.1);
    
    [self  addChild:backgroundNode];
    self.scaleMode = SKSceneScaleModeAspectFill;
}

- (void)createBoxArray{
    BoxNode * box = [BoxNode createNodeOn:self];
    box.position = (CGPoint){CGRectGetMidX(self.view.frame), CGRectGetMaxY(self.view.frame)};
    
    [self.boxArray addObject:box];
}

- (void)createStaticBoxArray{
    UIView * box = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 140)];
    box.layer.position = (CGPoint){CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame)};
    
    [self.staticBoxArray addObject:box];
}

- (void)showNativeOnAnyBox{
//    if ([self.boxArray count] > 0) {
//        
//        BoxNode * box = [self.boxArray lastObject];
//        self.attributes.width = CGRectGetWidth(box.frame);
//        self.attributes.heigth = CGRectGetHeight(box.frame);
//        
////        AppodealNativeAdView* adView = [[AppodealNativeAdView alloc] init];
////        adView = [AppodealNativeAdView nativeAdViewWithType: AppodealNativeAdTypeContentStream
////                                                andNativeAd: [self.nativeArray lastObject]
////                                              andAttributes: self.attributes
////                                         rootViewController: self.controller];
//        
//        [box addNativeAds:[self.nativeArray lastObject]];
//    }
    if ([self.staticBoxArray count] > 0) {
        UIView * box = [self.staticBoxArray lastObject];
        
        self.attributes.width = CGRectGetWidth(box.frame);
        self.attributes.heigth = CGRectGetHeight(box.frame);
        
        AppodealNativeAdView* adView = [[AppodealNativeAdView alloc] init];
        adView = [AppodealNativeAdView nativeAdViewWithType: AppodealNativeAdTypeContentStream
                                                andNativeAd: [self.nativeArray lastObject]
                                              andAttributes: self.attributes
                                         rootViewController: self.controller];
        
        
        [self.view addSubview:box];
    }
}

#pragma mark --- NATIVE_SERVICE_DELEGATE

- (void) nativeAdServiceDidLoad:(AppodealNativeAd *)nativeAd {
    NSLog(@"nativeAdServiceDidLoad");
    [self.nativeArray addObject:nativeAd];
    [self showNativeOnAnyBox];
}

-(void) nativeAdServiceDidFailedToLoad{
    NSLog(@"nativeAdServiceDidFailedToLoad");
}

#pragma mark --- EVENT

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    CGPoint positionScene = [touch locationInNode:[self childNodeWithName:@"nativeBox"]];
    if(CGRectContainsPoint(self.frame, positionScene))
    {
        NSLog(@"box click");
    }
}

@end
