//
//  Dead.m
//  bullet hell-o
//
//  Created by Kevin Frans on 7/2/13.
//
//

#import "Dead.h"
#import "HelloWorldLayer.h"
#import "Title.h"
#import "LevelSelect.h"
#import "StatLayer.h"

@implementation Dead

-(id) init
{
    if ((self = [super init]))
    {
        
        size = [[CCDirector sharedDirector] winSize];
        glClearColor(255, 255, 255, 255);
        [self unscheduleAllSelectors];
        
        // have everything stop
        CCNode* node;
        CCARRAY_FOREACH([self children], node)
        {
            [node pauseSchedulerAndActions];
        }
        
        CGPoint screencenter = [[CCDirector sharedDirector] screenCenter];
        
        CCSprite* background = [CCSprite spriteWithFile:@"sunbg.png"];
        background.position = screencenter;
        [self addChild:background z:-10000];
        [self setDimensionsInPixelsOnSprite:background width:380 height:480];
        
        
        
        // add the labels shown during game over
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        CGSize screenSize1 = [[CCDirector sharedDirector] winSizeInPixels];
        
        score = [NSString stringWithFormat:@"%i", [[NSUserDefaults standardUserDefaults] integerForKey:@"score"]];
        
        intscore = [[NSUserDefaults standardUserDefaults] integerForKey:@"score"];
        
        
        
        CCLabelTTF* gameOver = [CCLabelTTF labelWithString:@"Game Over" fontName:@"NexaBold" fontSize:23];
        gameOver.position = CGPointMake((screenSize.width / 2)-90, 420);
        gameOver.color = ccc3(0, 0, 0);
        [self addChild:gameOver z:100 tag:100];
        
        
        CCLabelTTF* gameOver2 = [CCLabelTTF labelWithString:score fontName:@"NexaBold" fontSize:19];
        gameOver2.position = CGPointMake((screenSize.width / 2)-90, 390);
        gameOver2.color = ccc3(0, 0, 0);
        [self addChild:gameOver2 z:100 tag:100];
        
        //CCTintTo* tint = [CCTintTo actionWithDuration:2 red:0 green:0 blue:255];
        //[gameOver runAction:tint];
        /*// game over label runs 3 different actions at the same time to create the combined effect
         // 1) color tinting
         CCTintTo* tint1 = [CCTintTo actionWithDuration:2 red:255 green:0 blue:0];
         CCTintTo* tint2 = [CCTintTo actionWithDuration:2 red:255 green:255 blue:0];
         CCTintTo* tint3 = [CCTintTo actionWithDuration:2 red:0 green:255 blue:0];
         CCTintTo* tint4 = [CCTintTo actionWithDuration:2 red:0 green:255 blue:255];
         CCTintTo* tint5 = [CCTintTo actionWithDuration:2 red:0 green:0 blue:255];
         CCTintTo* tint6 = [CCTintTo actionWithDuration:2 red:255 green:0 blue:255];
         CCSequence* tintSequence = [CCSequence actions:tint1, tint2, tint3, tint4, tint5, tint6, nil];
         CCRepeatForever* repeatTint = [CCRepeatForever actionWithAction:tintSequence];
         [gameOver runAction:repeatTint];
         
         // 2) rotation with ease
         CCRotateTo* rotate1 = [CCRotateTo actionWithDuration:2 angle:3];
         CCEaseBounceInOut* bounce1 = [CCEaseBounceInOut actionWithAction:rotate1];
         CCRotateTo* rotate2 = [CCRotateTo actionWithDuration:2 angle:-3];
         CCEaseBounceInOut* bounce2 = [CCEaseBounceInOut actionWithAction:rotate2];
         CCSequence* rotateSequence = [CCSequence actions:bounce1, bounce2, nil];
         CCRepeatForever* repeatBounce = [CCRepeatForever actionWithAction:rotateSequence];
         [gameOver runAction:repeatBounce];
         
         // 3) jumping
         CCJumpBy* jump = [CCJumpBy actionWithDuration:3 position:CGPointZero height:screenSize.height / 3 jumps:1];
         CCRepeatForever* repeatJump = [CCRepeatForever actionWithAction:jump];
         [gameOver runAction:repeatJump];*/
        
       /* CCMenuItemFont *playAgain = [CCMenuItemFont itemFromString: @"Retry" target:self selector:@selector(retry)];
        CCMenuItemFont *restart = [CCMenuItemFont itemFromString: @"Level Select" target:self selector:@selector(sel)];
        CCMenuItemFont *quit = [CCMenuItemFont itemFromString: @"Quit" target:self selector:@selector(quitGame)];
        [playAgain setFontName:@"Arial"];
        [restart setFontName:@"Arial"];
        [quit setFontName:@"Arial"];
        CCMenu *gameOverMenu = [CCMenu menuWithItems:playAgain, restart, quit, nil];
        [gameOverMenu alignItemsVertically];
        gameOverMenu.position = ccp(screenSize.width/2, screenSize.height/2 - 80);
        gameOverMenu.color = ccc3(0, 0, 0);
        [self addChild:gameOverMenu];
        
        */
        CCLabelTTF *highscore = [CCMenuItemImage itemFromNormalImage:@"2retry.png" selectedImage:@"2retry.png" target:self selector:@selector(retry)];
        highscore.position = ccp(160, 200);
        highscore.scale = 1;
        CCMenu *starMenu = [CCMenu menuWithItems:highscore, nil];
        starMenu.position = CGPointZero;
        [self addChild:starMenu];
        
        CCLabelTTF *boss = [CCMenuItemImage itemFromNormalImage:@"highscores.png" selectedImage:@"highscores.png" target:self selector:@selector(sel)];
        boss.position = ccp(100, 80);
        CCMenu *moreMenu = [CCMenu menuWithItems:boss, nil];
        moreMenu.position = CGPointZero;
        [self addChild:moreMenu];
        
        CCLabelTTF *back = [CCMenuItemImage itemFromNormalImage:@"back.png" selectedImage:@"back.png" target:self selector:@selector(quitGame)];
        back.position = ccp(240, 80);
        back.scale = 0.5;
        CCMenu *backmenu = [CCMenu menuWithItems:back, nil];
        backmenu.position = CGPointZero;
        [self addChild:backmenu];
        
        
        //xyhw
        nameField = [[UITextField alloc] initWithFrame:CGRectMake(35, 140, 260, 25)];
        [[[CCDirector sharedDirector] view] addSubview:nameField];
        nameField.delegate = self;
        nameField.placeholder = @"Tap to Enter Username";
        nameField.borderStyle = UITextBorderStyleRoundedRect;
        [nameField setReturnKeyType:UIReturnKeyDone];
        [nameField setAutocorrectionType:UITextAutocorrectionTypeNo];
        [nameField setAutocapitalizationType:UITextAutocapitalizationTypeWords];
        //        textField.visible = true;
        
        
        
           // NSLog(@"derp");
        CCLabelTTF *fb = [CCMenuItemImage itemFromNormalImage:@"facebook.png" selectedImage:@"facebook.png" target:self selector:@selector(fb)];
        fb.position = ccp(size.width - 16, size.height - 16);
        fb.scale = 1;
        CCMenu *fbm = [CCMenu menuWithItems:fb, nil];
        fbm.position = CGPointZero;
        [self addChild:fbm];
        
        
        
        
        
        if(screenSize1.height == 1136)
        {
            //[self setDimensionsInPixelsOnSprite:background width:450 height:568];
            
            //ackground.position = ccp(screencenter.x+50,screencenter.y);

            //gameOver.position = ccp((screenSize.width / 2)-60, 490);

            //gameOver2.position = ccp((screenSize.width / 2)-60, 460);

        }
        
        
        
       // [MGWU submitHighScore:[[NSUserDefaults standardUserDefaults] integerForKey:@"score"] byPlayer:@"Player" forLeaderboard:@"defaultLeaderboard"];
        
    }
    return self;
}

-(void) fblogin
{
    [MGWU loginToFacebook];
}
-(void) fb
{
    if([MGWU isFacebookActive])
    {
    NSString *myString = @"I just finished a run of Blue and got a score of ";
    NSString *test = [myString stringByAppendingString:score];
    [MGWU shareWithTitle:@"Blue" caption:[MGWU getUsername] andDescription:test];
    }
else{
    [self fblogin];
}
}

-(void) quitGame
{
    [nameField removeFromSuperview];
//    [nameField release];
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionSlideInL transitionWithDuration:0.5f scene:[Title node]]];
}

-(void) sel
{
    [nameField removeFromSuperview];
//    [nameField release];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:0.5f scene:[StatLayer node]]];
}

-(void) retry
{
    [nameField removeFromSuperview];
//    [nameField release];
    //    [[CCDirector sharedDirector] popSceneWithTransition:
    //       [CCTransitionCrossFade transitionWithDuration:0.5f scene:[HelloWorldLayer node]]];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:0.5f scene:[HelloWorldLayer node]]];
}

- (void)textFieldDidEndEditing:(UITextField*)textField
{
    if (textField == nameField && ![nameField.text isEqualToString:@""])
    {
       
        //if([[NSUserDefaults standardUserDefaults] integerForKey:@"score"] > 0)
       // {
        
        [nameField endEditing:YES];
        [nameField removeFromSuperview];
        // here is where you should do something with the data they entered
        NSString *result = nameField.text;
        
        
        if(intscore > 0)
        {
        NSLog(@"hurp");
        //        username = result;
        [[NSUserDefaults standardUserDefaults] setObject:result forKey:@"username"];
        [MGWU submitHighScore:[[NSUserDefaults standardUserDefaults] integerForKey:@"score"] byPlayer:result forLeaderboard:@"defaultLeaderboard"];
        //}
        }
        
        
    }
}
-(void) setDimensionsInPixelsOnSprite:(CCSprite *) spriteToSetDimensions width:(int) width height:(int) height
{
    spriteToSetDimensions.scaleX = width/[spriteToSetDimensions boundingBox].size.width;
    spriteToSetDimensions.scaleY = height/[spriteToSetDimensions boundingBox].size.height;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
	if (![nameField.text isEqualToString:@""])
	{
		//Hide keyboard when "done" clicked
		[textField resignFirstResponder];
		[nameField removeFromSuperview];
		return YES;
	}
}

@end

