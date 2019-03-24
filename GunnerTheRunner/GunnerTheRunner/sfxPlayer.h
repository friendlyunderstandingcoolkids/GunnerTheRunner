//
//  sfxPlayer.h
//  GunnerTheRunner
//
//  Created by Dylan Chew on 2019-03-23.
//

#define sfxPlayer_h

@interface sfxPlayer : NSObject {
    
}

- (void) setup;
- (void) startMenuMusic;
- (void) startGameMusic;
- (void) gameStartFX;
- (void) knifeThrowFX;
- (void) oof;

@end
