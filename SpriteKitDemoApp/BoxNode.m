//
//  BoxNode.m
//  SpriteKitDemoApp
//
//  Created by Lozhkin Ilya on 6/6/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import "BoxNode.h"

@implementation BoxNode

- (id)init
{
    self = [super initWithColor:UIColor.grayColor size:CGSizeMake(200, 140)];
    if (self) {
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:
                            CGSizeMake(self.size.width * .95f,
                                       self.size.height * .95f)];
        self.physicsBody.dynamic = YES;
        self.name = @"nativeBox";
    }
    return self;
}

+ (id)createNodeOn:(SKNode *)parent
{
    id box = [BoxNode new];
    [parent addChild:box];
    return box;
}

- (void) addNativeAds:(AppodealNativeAd *) nativeAd{
    
    __block SKTexture * imageTexture = nil;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSURLRequest* request =[NSURLRequest requestWithURL:nativeAd.image.imageUrl];
        [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage * _imageTemplate = [UIImage imageWithData:data];
                imageTexture = [SKTexture textureWithImage:_imageTemplate];
                
                SKSpriteNode * image = [SKSpriteNode spriteNodeWithTexture:imageTexture size:(CGSize){CGRectGetWidth(self.frame) - 10, CGRectGetWidth(self.frame) - 40}];
                image.position = (CGPoint){0, 0};
                
                [self addChild:image];
            });
        }] resume];
    });
    
    SKLabelNode * title = [SKLabelNode labelNodeWithText:nativeAd.title];
    title.position = (CGPoint){CGRectGetMidX(self.frame), CGRectGetHeight(self.frame) - CGRectGetHeight(title.frame) / 2};
    
    
    [self addChild:title];
}

@end


//@property (copy, nonatomic, readonly) NSString *title;
//@property (copy, nonatomic, readonly) NSString *subtitle;
//@property (copy, nonatomic, readonly) NSString *descriptionText;
//@property (copy, nonatomic, readonly) NSString *callToActionText;
//@property (copy, nonatomic, readonly) NSString *contentRating;
//@property (copy, nonatomic, readonly) NSNumber *starRating;
//
//@property (strong, nonatomic, readonly) AppodealImage *image;
//@property (strong, nonatomic, readonly) AppodealImage *icon;