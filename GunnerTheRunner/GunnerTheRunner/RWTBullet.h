//
//  RWTBullet.h
//  GunnerTheRunner
//
//  Created by Kabilan Thangarajah on 2019-03-16.
//

#import "RWTModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RWTBullet : RWTModel
- (instancetype)initWithShader:(RWTBaseEffect *)shader;
- (void)updateWithDelta:(NSTimeInterval)dt;
@end

NS_ASSUME_NONNULL_END
