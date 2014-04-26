//
//  TowerDestroyer.h
//  SolarColony
//
//  Created by Student on 2/17/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "Tower.h"
#import "NormalBullet.h"
#import "GameStatusEssentialsSingleton.h"
#import "MusicManagerSingleton.h"

@interface TowerAttack : CCNode<Tower>{
    int counterTest;
    int _health;
    NormalBullet* bullet;
    id movePoint, returnPoint ;
    GameStatusEssentialsSingleton* gameStatusEssentialsSingleton;
    CCProgressTimer *timeBar;
    int counter;
    CCSprite* towerSprite;
    CCSprite* towerSprite_hp;
    MusicManagerSingleton *musicManagerSingleton;
}
-(void) endAttack;
@property(assign, atomic) CGPoint targetLocation;
@property(assign, atomic) CGPoint selfLocation;

@end
