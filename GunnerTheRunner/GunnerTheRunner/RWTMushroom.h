//
//  RWTGlock.h
//  GunnerTheRunner
//
//  Created by Gagandeep Heer on 2019-02-23.
//

#import "RWTModel.h"

@interface RWTMushroom : RWTModel

- (instancetype)initWithShader:(RWTBaseEffect *)shader;
- (void)updateWithDelta:(NSTimeInterval)dt;
- (void)setRandomPosition;
@end
