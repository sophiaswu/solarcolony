//
//  WaveController.m
//  SolarColony
//
//  Created by Charles on 2/14/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "WaveController.h"
#import "SoldierController.h"
#import "GridMap.h"
#import "Soldier.h"
#import "Army.h"

int WAVE_GEN_RATE = 300; // 60 ticks per sec
int SOL_GEN_RATE = 60; // 60 ticks per sec
BOOL test = false;

@implementation WaveController {
    int _tick;
    int _hold_tick;
    BOOL _in_wave;
    NSMutableArray *_queue;
    NSMutableArray *_monitor;
    Army *_wave;
    NSObject *_mylock;
    SoldierController *_sol_control;
    GridMap *_grid;
}

#pragma mark - Create and Destroy

+ (instancetype) controller: (SoldierController *) sol_control Grid: (GridMap *) grid
{
    return [[self alloc] init: sol_control Grid: grid];
}

- (instancetype) init: (SoldierController *) sol_control Grid: (GridMap *) grid
{
    self = [super init];
    if (!self) return(nil);
    
    // initialize variable
    _in_wave = FALSE;
    _queue = [[NSMutableArray alloc] init];
    _monitor = [[NSMutableArray alloc] init];
    _tick = 0;
    _mylock = [[NSObject alloc] init];
    _sol_control = sol_control;
    _grid = grid;
    
    return self;
}

- (void) dealloc
{
    [_queue release]; _queue = nil;
    [_monitor release]; _monitor = nil;
    [_wave release]; _wave = nil;
    [_mylock release]; _mylock = nil;
    [_sol_control release]; _sol_control = nil;
    [_grid release]; _grid = nil;
    [self release];
    [super dealloc];
}

#pragma mark - Wave operation

- (void) update
{
    @synchronized(_mylock){
        //NSLog(@"WaveController: tick = %d", _tick);
        //NSLog(@"WaveController: number of %d wave in queue", [_queue count]);
        _tick++;
        if(_in_wave){
            if([_wave count]){
                if(_tick == SOL_GEN_RATE){
                    // add to monitor and soldier controller
                    _tick = 0;
                    [self generateSoldier];
                }
            }else{
                // if all monitored soldiers died, end wave
                if(![self checkMonitor]){
                    [self endWave];
                }
            }
        }else{
            if(_tick == WAVE_GEN_RATE){
                _tick = 0;
                [self genertateAIarmy];
            }
        }
    }
    if([_queue count] > 0 && !test){
        [self startWave];
        test = true;
    }
}

- (void) genertateAIarmy
{
    NSLog(@"WaveController: generate AI army");
    // add one AI army in queue
    Army *army = [Army army];
    for (int i=0; i<5; i++) {
        Soldier *temp = [Soldier runner:(int)100 ATTACK:(int)80 Speed:(int)50 ATTACK_SP:(int)50];
        [army addSoldier: temp];
    }
    [_queue addObject: army];
}

- (void) generateSoldier
{
    NSLog(@"WaveController: generate a soldier");
    Soldier *sol = [_wave popSoldier];
    [_monitor addObject: sol];
    [sol setPOSITION:2 Y:0];
    [sol setPosition:[_grid convertMapIndexToCenterGL:ccp(2, 0)]];
    [_grid addChild:sol];
    [_sol_control addSoldier: sol];
}

- (BOOL) checkMonitor
{
    for(int i=0; i<[_monitor count]; i++){
        Soldier *sol = (Soldier *)[_monitor objectAtIndex:i];
        if(sol.visible)
            return TRUE;
    }
    return FALSE;
}

- (void) startWave
{
    NSLog(@"WaveController: start a wave");
    @synchronized(_mylock){
        _wave = (Army *)[_queue objectAtIndex: 0];
        _hold_tick = _tick;
        _tick = SOL_GEN_RATE - 1;
        _in_wave = TRUE;
    }
}

- (void) endWave
{
    NSLog(@"WaveController: end a wave");
    [_queue removeObjectAtIndex: 0];
    _tick = _hold_tick;
    _in_wave = FALSE;
    [_wave dealloc];
}

@end