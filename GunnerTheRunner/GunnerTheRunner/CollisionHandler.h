//
//  CollisionHandler.h
//  GunnerTheRunner
//
//  Created by Kabilan Thangarajah on 2019-03-09.
//

#import <Foundation/Foundation.h>
#import "RWTGlock.h"
#import "RWTMushroom.h"
#import "RWTBullet.h"
NS_ASSUME_NONNULL_BEGIN

@interface CollisionHandler : NSObject
- (BOOL)mushroomDetection:(RWTMushroom *)mushroom glockDetection:(RWTGlock *)glock;
- (BOOL)bulletDetection:(RWTBullet *)bullet glockDetection:(RWTGlock *)glock;
@end

NS_ASSUME_NONNULL_END
