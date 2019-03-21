//
//  CollisionHandler.m
//  GunnerTheRunner
//
//  Created by Kabilan Thangarajah on 2019-03-09.
//

#import "CollisionHandler.h"
#import "RWTGlock.h"
#import "RWTMushroom.h"
#import "RWTBullet.h"

//Values for Glock
float GxBoundsTop = 1;
float GyBoundsTop = 0.1f;
float GxOffsetTop = -0.3;
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


//Values for Bullet
//Values for Mushroom
float BxBounds = 0.8f;
float ByBounds = 0.8f;

float BBboxTop;
float BBboxRight;
float BBboxBot;
float BBboxLeft;
@interface CollisionHandler ()
{
    BOOL didMushroomHitGlock;
    BOOL didBulletHitGlock;
}
@end
@implementation CollisionHandler{
    RWTGlock *_glock;
    RWTMushroom *_mush;
    RWTMushroom *_bullet;
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
        //printf("hit");
        didMushroomHitGlock = true;
    }
    
    return didMushroomHitGlock;
}

- (BOOL)bulletDetection:(RWTBullet *)bullet glockDetection:(RWTGlock *)glock{
    
    GtBboxTop = glock.position.y + GyOffsetTop + GyBoundsTop;
    GtBboxBot = glock.position.y + GyOffsetTop - GyBoundsTop;
    GtBboxRight = glock.position.x + GxOffsetTop + GxBoundsTop;
    GtBboxLeft = glock.position.x + GxOffsetTop - GxBoundsTop;
    
    GbBboxTop = glock.position.y + GyOffsetBot + GyBoundsBot;
    GbBboxBot = glock.position.y + GyOffsetBot - GyBoundsBot;
    GbBboxRight = glock.position.x + GxOffsetBot + GxBoundsBot;
    GbBboxLeft = glock.position.x + GxOffsetBot - GxBoundsBot;
    
    BBboxTop = bullet.position.y + ByBounds;
    BBboxBot = bullet.position.y - ByBounds;
    BBboxRight = bullet.position.x + BxBounds;
    BBboxLeft = bullet.position.x - BxBounds;
    //MBboxLeft >= GbBboxRight &&
    if(((GbBboxBot <= BBboxTop && GbBboxBot >= BBboxBot) || (GbBboxTop <= BBboxTop && GbBboxTop >= BBboxBot)) && ((GbBboxLeft >= BBboxLeft && GbBboxLeft <= BBboxRight) || (GbBboxRight >= BBboxLeft && GbBboxRight <= BBboxRight))){
        //printf("hit bot \n");
        didBulletHitGlock = true;
    }
    //MBboxLeft >= GbBboxRight &&
    if(((GtBboxBot <= BBboxTop && GtBboxBot >= BBboxBot) || (GtBboxTop <= BBboxTop && GtBboxTop >= BBboxBot)) && ((GtBboxLeft >= BBboxLeft && GtBboxLeft <= BBboxRight) || (GtBboxRight >= BBboxLeft && GtBboxRight <= BBboxRight))){
        //printf("hit top \n");
        didBulletHitGlock = true;
    }
    
    return didBulletHitGlock;
}
@end
//1. function to recieve two objects (both of which are different objects to be collided with eachother)
//2. function must be accesible by the view contrller
//3. function must return a boolean (or equivalent)
//4. function must take the two objects and run a function of them that retrieves their bounding parameters
//5. function must test bounding parameters

