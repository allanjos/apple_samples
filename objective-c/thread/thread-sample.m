#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>
#import <CoreData/CoreData.h>

@interface Game: NSObject

-(void) initialize;
-(void) terminate;
-(void) start;

@end

@implementation Game
{
    bool started;
    bool endRequested;
    bool threadStopped;
}

-(instancetype)init {
    if (self = [super init]) {
        NSLog(@"Game.init()");

        started = NO;
        endRequested = NO;
        threadStopped = YES;
    }

    return self;
}

-(void) initialize
{
    NSLog(@"Game.initialize()");
}

-(void) terminate
{
    NSLog(@"Game.terminate()");
}

-(void) start
{
    NSLog(@"Game.start()");

    if (started == YES) {
        NSLog(@"Game has already started.");

        return;
    }

    NSThread *thread = [[NSThread alloc] initWithTarget:self
                        selector:@selector(gameThreadFunction)
                        object:nil];

    [thread start];

    started = YES;
}

- (void) gameThreadFunction
{
    threadStopped = NO;

    while (endRequested != YES) {
        NSLog(@"Game thread function...");

        [NSThread sleepForTimeInterval:0.5];
    }

    NSLog(@"Game end requested. Game thread ended.");

    threadStopped = YES;
}

-(void) stop
{
    NSLog(@"Game.stop()");

    endRequested = YES;

    while (threadStopped != YES) {
        NSLog(@"Waiting thread stop...");

        [NSThread sleepForTimeInterval:0.3];
    }

    started = NO;
}

@end

int main(int argc, char* argv[])
{
    @autoreleasepool {
        Game *game;

        game = [Game alloc];
        game = [game init];

        [game initialize];

        [game start];

        [NSThread sleepForTimeInterval:5.0];

        [game stop];

        [game terminate];
    }

    return 0;
}
