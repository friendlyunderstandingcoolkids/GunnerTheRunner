//
//  RWTModel.h
//  GunnerTheRunner
//
//  Created by Gagandeep Heer on 2019-02-16.
//

#import <Foundation/Foundation.h>
#import "RWTVertex.h"

@class RWTBaseEffect;
@import GLKit;

@interface RWTModel : NSObject

@property (nonatomic, strong) RWTBaseEffect *shader;
@property (nonatomic, assign) GLKVector3 position;
@property (nonatomic) float rotationX;
@property (nonatomic) float rotationY;
@property (nonatomic) float rotationZ;
@property (nonatomic, assign) GLKVector3 scale;
@property (nonatomic) GLuint texture;
@property (nonatomic) float vertexInc;

- (instancetype)initWithName:(char *)name shader:(RWTBaseEffect *)shader vertices:(RWTVertex *)vertices vertexCount:(unsigned int)vertexCount;
- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix;
- (void)updateWithDelta:(NSTimeInterval)dt;
- (void)loadTexture:(NSString *)filename;

@end
