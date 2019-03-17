//
//  CollisionHandler.m
//  GunnerTheRunner
//
//  Created by Kabilan Thangarajah on 2019-03-09.
//

#import "CollisionHandler.h"
#import "RWTGlock.h"
#import "RWTMushroom.h"

//Values for Glock
float GxBoundsTop = 1;
float GyBoundsTop = 0.1f;
float GxOffsetTop = 0;
float GyOffsetTop = 0.1f;

float GxBoundsBot = 0.2f;
float GyBoundsBot = 0.5f;
float GxOffsetBot = -0.2f;
float GyOffsetBot = -0.1f;

float GtBboxTop;
float GtBboxRight;
float GtBboxBot;
float GtBboxLeft;

float GbBboxTop;
float GbBboxRight;
float GbBboxBot;
float GbBboxLeft;

//Values for Mushroom
float MxBounds = 0.8f;
float MyBounds = 0.8f;

float MBboxTop;
float MBboxRight;
float MBboxBot;
float MBboxLeft;

@interface CollisionHandler ()
{
    BOOL didMushroomHitGlock;
}
@end
@implementation CollisionHandler{
    RWTGlock *_glock;
    RWTMushroom *_mush;
}

- (BOOL)mushroomDetection:(RWTMushroom *)mushroom glockDetection:(RWTGlock *)glock{
    
    GtBboxTop = glock.position.y + GyOffsetTop + GyBoundsTop;
    GtBboxBot = glock.position.y + GyOffsetTop - GyBoundsTop;
    GtBboxRight = glock.position.x + GxOffsetTop + GxBoundsTop;
    GtBboxLeft = glock.position.x + GxOffsetTop - GxBoundsTop;
    
    GbBboxTop = glock.position.y + GyOffsetBot + GyBoundsBot;
    GbBboxBot = glock.position.y + GyOffsetBot - GyBoundsBot;
    GbBboxRight = glock.position.x + GxOffsetBot + GxBoundsBot;
    GbBboxLeft = glock.position.x + GxOffsetBot - GxBoundsBot;
    
    MBboxTop = mushroom.position.y + MyBounds;
    MBboxBot = mushroom.position.y - MyBounds;
    MBboxRight = mushroom.position.x + MxBounds;
    MBboxLeft = mushroom.position.x - MxBounds;
    //MBboxLeft >= GbBboxRight &&
    if(((GbBboxBot <= MBboxTop && GbBboxBot >= MBboxBot) || (GbBboxTop <= MBboxTop && GbBboxTop >= MBboxBot)) && ((GbBboxLeft >= MBboxLeft && GbBboxLeft <= MBboxRight) || (GbBboxRight >= MBboxLeft && GbBboxRight <= MBboxRight))){
        printf("hit");
        didMushroomHitGlock = true;
    }
    
    return didMushroomHitGlock;
}
@end
//1. function to recieve two objects (both of which are different objects to be collided with eachother)
//2. function must be accesible by the view contrller
//3. function must return a boolean (or equivalent)
//4. function must take the two objects and run a function of them that retrieves their bounding parameters
//5. function must test bounding parameters

