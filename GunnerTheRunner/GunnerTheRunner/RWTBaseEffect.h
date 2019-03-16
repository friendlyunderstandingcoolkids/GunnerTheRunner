//
//  RWTBaseEffect.h
//  GunnerTheRunner
//
//  Created by Gagandeep Heer on 2019-02-16.
//

#import <Foundation/Foundation.h>
@import GLKit;

@interface RWTBaseEffect : NSObject

@property (nonatomic, assign) GLuint programHandle;
@property (nonatomic, assign) GLKMatrix4 modelViewMatrix;
@property (nonatomic, assign) GLKMatrix4 projectionMatrix;
@property (assign) GLuint texture;
@property (assign) float vertexInc;

- (id)initWithVertexShader:(NSString *)vertexShader
            fragmentShader:(NSString *)fragmentShader;
- (void)prepareToDraw;

@end
