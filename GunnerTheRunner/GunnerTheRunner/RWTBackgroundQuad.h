//
//  RWTBackgroundQuad.h
//  GunnerTheRunner
//
//  Created by Renzo Pamplona on 2019-02-23.
//

#import "RWTModel.h"

@interface RWTBackgroundQuad : RWTModel
- (void)getScreenParams:(float)height and: (float)width;
- (instancetype)initWithShader:(RWTBaseEffect *)shader;
@end
