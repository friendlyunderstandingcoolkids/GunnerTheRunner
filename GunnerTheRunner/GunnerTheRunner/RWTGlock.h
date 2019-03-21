//
//  RWTGlock.h
//  GunnerTheRunner
//
//  Created by Gagandeep Heer on 2019-02-23.
//

#import "RWTModel.h"

@interface RWTGlock : RWTModel

- (instancetype)initWithShader:(RWTBaseEffect *)shader;
- (void)doJump:(BOOL)isJump;
- (void)dofastFall:(BOOL)fastFall;
- (CGPoint)getBarrelPos;
- (float)getPositionX;
- (float)getPositionY;
- (BOOL)isJumping;
@end
