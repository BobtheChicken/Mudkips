
//  StatLayer.m
//  Moon Landing
//
//  Borrowed from Gautam Mittal on 6/27/13.
//   Modifeied by kevin frans with permissuon
//

#import "StatLayer.h"

@implementation StatLayer

CGSize screenSize;

-(id) init
{
	if ((self = [super init]))
	{
        glClearColor(255, 255, 255, 255);
        CGSize deviceScreenSize = [[CCDirector sharedDirector] winSizeInPixels];
        screenSize = [[CCDirector sharedDirector] winSize];
        CGPoint screenCenter = [[CCDirector sharedDirector] screenCenter];
        
        
        
        CCLabelBMFont *gameTitle = [CCLabelTTF labelWithString:@"HIGH SCORES" fontName:@"Bend2SquaresBRK" fontSize:60];
        gameTitle.color = ccc3(0,0,0);
        gameTitle.position = ccp(screenCenter.x, screenCenter.y + 210);
        if(deviceScreenSize.height == 1136)
        {
            gameTitle.position = ccp(screenCenter.x, screenCenter.y + 240);
        }
        //[self addChild:gameTitle];
        
        
        CCSprite* bg = [CCSprite spriteWithFile:@"statbg.png"];
        bg.position = ccp(160,240);
        [self addChild:bg z:-20];
        
        if([[NSUserDefaults standardUserDefaults] boolForKey:@"iphone5"] == true)
        {
            bg.position = ccp(160,328);
            CCSprite* fill = [CCSprite spriteWithFile:@"darkbluefill.png"];
            fill.position = [CCDirector sharedDirector].screenCenter;
            [self addChild:fill z:-100];
        }
        /*NSNumber *savedHighScore = [[NSUserDefaults standardUserDefaults] objectForKey:@"sharedHighScore"];
        int highScore = [savedHighScore intValue];
        NSString *highScoreString = [[NSString alloc] initWithFormat:@"High Score: %i", highScore];
        CCLabelBMFont *highScoreLabel = [CCLabelTTF labelWithString:highScoreString fontName:@"Roboto-Light" fontSize:20];
        highScoreLabel.position = ccp(screenSize.width/2, screenSize.height/2);
        highScoreLabel.color = ccc3(0, 0, 0);
        //        [self addChild:highScoreLabel];
        
        
        NSNumber *lastRoundScore = [[NSUserDefaults standardUserDefaults] objectForKey:@"sharedScore"];
        int lastRoundPlayedScore = [lastRoundScore intValue];
        NSString *lastRoundString = [[NSString alloc]initWithFormat:@"Last Round: %i", lastRoundPlayedScore];
        CCLabelBMFont *lastRoundPlayed = [CCLabelTTF labelWithString:lastRoundString fontName:@"Roboto-Light" fontSize:20];
        lastRoundPlayed.position = ccp(screenSize.width/2, screenSize.height/2 - 40);
        lastRoundPlayed.color = ccc3(0, 0, 0);
        //        [self addChild:lastRoundPlayed];*/
        
        //        [MGWU submitHighScore:highScore byPlayer:@"gmittal" forLeaderboard:@"defaultLeaderboard"];
        
        NSString *savedUser = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        
        //        [MGWU getHighScoresForLeaderboard:@"defaultLeaderboard" withCallback:@selector(receivedScores:)
        //                                 onTarget:self];
        
        [self getScores];
        
        CCMenuItemFont *goBackToHome = [CCMenuItemFont itemFromString: @"Back to Menu" target:self selector:@selector(goHome)];
        [goBackToHome setFontName:@"Bend2SquaresBRK"];
        [goBackToHome setFontSize:50];
        goBackToHome.color = ccc3(0, 0, 0);
        
        CCMenu *goHomeMenu = [CCMenu menuWithItems:goBackToHome, nil];
        [goHomeMenu alignItemsVertically];
        goHomeMenu.position = ccp(screenSize.width/2, 40);
       // [self addChild:goHomeMenu];
        
        [self scheduleUpdate];
        
    }
    return self;
}


-(void) update:(ccTime)delta
{
    
    if ([KKInput sharedInput].anyTouchBeganThisFrame)
    {
        KKInput* input = [KKInput sharedInput];
        CGPoint pos = [input locationOfAnyTouchInPhase:KKTouchPhaseAny];
        
        
        
        if([[NSUserDefaults standardUserDefaults] boolForKey:@"iphone5"] == true)
        {
            if(pos.y < 568 && pos.y > 518 && pos.x < 40)
            {
                [self goHome];
            }
            
            if(pos.y < 50 && pos.y > 0 && pos.x < 40)
            {
                [MGWU showMessage:@"Whyd u reset the data mun" withImage:nil];
                NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];

            }
        }
        else
        {
        
        
            if(pos.y < 480 && pos.y > 440 && pos.x < 40)
            {
                [self goHome];
            }
            
            if(pos.y < 50 && pos.y > 0 && pos.x < 40)
            {
                [MGWU showMessage:@"Whyd u reset the data mun" withImage:nil];
                NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
            }
        }
        
    }
}

-(void) goHome
{
    [[CCDirector sharedDirector] replaceScene:
	 [CCTransitionSlideInL transitionWithDuration:0.5f scene:[Title node]]];
    //        [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer node]];
}

-(void) getScores
{
    [MGWU getHighScoresForLeaderboard:@"defaultLeaderboard" withCallback:@selector(receivedScores:)
                             onTarget:self];
}

-(void)receivedScores:(NSDictionary*)scores
{
    //Do stuff with scores in here! Display them!
    //    NSString *leaderBoardString = [[NSString alloc] initWithFormat:@"%@", scores];
    //    CCLabelBMFont *leaderBoard = [CCLabelTTF labelWithString:leaderBoardString fontName:@"Roboto-Light" fontSize:15];
    //    leaderBoard.position = ccp(screenSize.width/2, screenSize.height/2);
    //    [self addChild:leaderBoard];
    //    NSLog(@"%@", scores);
    
    //    NSString *object = [[NSString alloc]initWithFormat:
    
    //    for(NSString *key in [scores allKeys]) {
    //        NSLog(@"%@",[scores objectForKey:key]);
    //        NSString *rankStr = [scores objectForKey:@"score"];
    //        NSString *rank = [NSString stringWithFormat: @"%@", [scores objectForKey:@"all"]];
    //        CCLabelBMFont *rankLabel = [CCLabelTTF labelWithString:rank fontName:@"Roboto-Light" fontSize:20];
    //        rankLabel.position = ccp(screenSize.width/2, screenSize.height/2);
    //        rankLabel.color = ccc3(0,0,0);
    //        [self addChild:rankLabel];
    
    //    }
    
    //    NSDictionary *userDict = [scores objectForKey:@"user"];
    //    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    //	if (!userName)
    //		userName = @"player";
    //    NSNumber *userHighScore = [userDict objectForKey:@"score"];
    //    NSNumber *userRank = [userDict objectForKey:@"rank"];
    //
    //    CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Your name: %@, Most Kills: %@, Rank: %@", userName, userHighScore, userRank]
    //                                           fontName:@"Marker Felt"
    //                                           fontSize:16];
    
    //    label.position = ccp(screenSize.width / 2, screenSize.height-15);
    //    [self addChild:label z: 2];
    
    
    NSMutableArray *otherPlayers = [scores objectForKey:@"all"];
    int count = [otherPlayers count];
    
    //    if([otherPlayers count] > 250)
    //    {
    //        count = 250;
    //    }
    
    for (int i = 0; i < 10; i ++)
    {
        NSMutableDictionary *playerDict = [otherPlayers objectAtIndex:i];
        NSNumber * score = [playerDict objectForKey:@"score"];
        NSString *name = [playerDict objectForKey:@"name"];
        if (!name) {
            name = @"player";
        }
        //        NSNumber *rank = [playerDict objectForKey:@"rank"];
        NSNumber *rank = [NSNumber numberWithInt:i + 1];
        
        
        if (name.length > 17) {
            name = [[name substringToIndex:18] stringByAppendingString:@"..."];
        }
        
        LeaderBoardPlayer *p = [[LeaderBoardPlayer alloc] init];
        p.name = name;
        p.score = score;
        p.rank = rank;
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@  %@", rank, name]
                                               fontName:@"HelveticaNeue-Light"
                                               fontSize:15];
        label.anchorPoint = ccp(0.0f,0.5f);

        label.position = ccp(45, screenSize.height - 119 - i * 30);
        label.color = ccc3(0, 0, 0);
        [self addChild:label z: 2];
        
        
        CCLabelTTF *label2 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", score]
                                               fontName:@"HelveticaNeue-Light"
                                               fontSize:15];
        label2.anchorPoint = ccp(1.0f,0.5f);
        
        label2.position = ccp(screenSize.width-50, screenSize.height - 119 - i * 30);
        label2.color = ccc3(0, 0, 0);
        [self addChild:label2 z: 2];
        
        [allPlayers addObject:p];
    }
    
}

@end