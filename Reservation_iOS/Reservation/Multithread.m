//
//  Multithread.m
//  Reservation
//
//  Created by Wai Man Chan on 4/4/16.
//  Copyright © 2016 CHAN, Wai Man. All rights reserved.
//

#import "Multithread.h"

@implementation Multithread
+(dispatch_queue_t)onlineQueryThread {
    static dispatch_queue_t queue;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        queue = dispatch_queue_create("Online Query", DISPATCH_QUEUE_CONCURRENT);
    });
    return queue;
}
@end
