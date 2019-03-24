//
//  ViewController.h
//  GunnerTheRunner
//
//  Created by Dylan Chew on 2019-02-16.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface MainViewController : UIViewController {
    CMMotionManager *motionManager;
    NSOperationQueue *opQ;
}
@end

