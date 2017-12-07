#import "Messages.h"

@implementation Messages

NSMutableArray *theMessages;
-(id)init {
    if ( self = [super init] ) {
        theMessages = [NSMutableArray new];
        [theMessages addObject:@"You should learn from your mistakes"];
        [theMessages addObject:@"It is in the now that we must live"];
        [theMessages addObject:@"The greatest risk is not taking one"];
        [theMessages addObject:@"You will be a Swift programmer"];
    }
    return self;
}

-(NSString *)getMessage {
    int num = arc4random() % theMessages.count;
    return theMessages[num];
}

@end
