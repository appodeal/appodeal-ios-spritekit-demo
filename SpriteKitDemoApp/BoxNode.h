//
//  BoxNode.h
//  SpriteKitDemoApp
//
//  Created by Lozhkin Ilya on 6/6/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Appodeal/AppodealNativeAd.h>

@interface BoxNode : SKSpriteNode

+ (id)createNodeOn:(SKNode *)parent;
- (void) addNativeAds:(AppodealNativeAd *) nativeAd;
@end
