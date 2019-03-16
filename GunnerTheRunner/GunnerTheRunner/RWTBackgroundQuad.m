//
//  RWTBackgroundQuad.m
//  GunnerTheRunner
//
//  Created by Renzo Pamplona on 2019-02-23.
//

#import "RWTBackgroundQuad.h"
#import "BackgroundQuad.h"

//@interface RWTBackgroundQuad(){
//    float vertexInc;
//}
//@end
@interface RWTBackgroundQuad(){
    float screenWidth;
    float screenHeight;
}

@end
@implementation RWTBackgroundQuad

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
    if ((self = [super initWithName:"background" shader:shader vertices:(RWTVertex *)Quad_Material_Vertices vertexCount:sizeof(Quad_Material_Vertices)/sizeof(Quad_Material_Vertices[0])])) {
        [self loadTexture:@"forestBG.png"];
        self.rotationY = 0;
        self.rotationX = 0;
        self.rotationZ = M_PI;
        self.scale = GLKVector3Make(1, 1, 1);
        self.position = GLKVector3Make(0, 1, 0);
//        glBindTexture(GL_TEXTURE_2D, self.texture);
//        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
//        self.rotationZ += (*Quad_Material_Vertices).TexCoord[0];
//        glTexImage2D(GL_TEXTURE_2D, 0, GL_ALPHA, 64, 64, 0, GL_ALPHA, GL_UNSIGNED_BYTE, self.texture);
        self.vertexInc = 0;
    }
    return self;
}

- (void)updateWithDelta:(NSTimeInterval)dt {
//    self.rotationX += M_PI * dt;
//    self.rotationY += M_PI * dt;
    self.vertexInc += 0.005;
}

- (void)getScreenParams:(float)height and: (float)width{
//    NSLog(@"%f", height);
//    NSLog(@"%f", width);
    screenWidth = width / height;
    screenHeight = 1;
    self.scale = GLKVector3Make(screenWidth * 3.68, screenHeight* 3.68, 1);
}

@end
