//
//  Logging.h
//  GraphiteTest
//
//  Created by Chris Hubbard on 6/19/13.
//  Copyright (c) 2013 SIL International. All rights reserved.
//

#ifndef GraphiteTest_Logging_h
#define GraphiteTest_Logging_h

//#import "LoggerClient.h"
#import "GrLoggingFormat.h"

#ifdef DEBUG
#define LOG_NETWORK(level, ...)    LogMessageF(__FILE__,__LINE__,__FUNCTION__,@"network",level,__VA_ARGS__)
#define LOG_GENERAL(level, ...)    LogMessageF(__FILE__,__LINE__,__FUNCTION__,@"general",level,__VA_ARGS__)
#define LOG_LAYOUT(level, ...)   LogMessageF(__FILE__,__LINE__,__FUNCTION__,@"layout",level,__VA_ARGS__)
#else
#define LOG_NETWORK(...)    do{}while(0)
#define LOG_GENERAL(...)    do{}while(0)
#define LOG_LAYOUT(...)   do{}while(0)
#endif


#define DLOG_FPRINTF

#if defined(DLOG_FPRINTF)
#define DLogFormat(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#elif defined(DLOG_LOGGER)
#define DLogFormat(FORMAT, ...) LogMessageCompat(FORMAT, ##__VA_ARGS__)
#else
#define DLogFormat(FORMAT, ...) NSLog(FORMAT, ##__VA_ARGS__)
#endif


#ifdef DEBUG
#   define DLogEnter(fmt, ...) DLogFormat((@"%@%s " fmt), [GrLoggingFormat enterFormat], __PRETTY_FUNCTION__, ##__VA_ARGS__)
#   define DLogLeave(fmt, ...) DLogFormat((@"%@%s " fmt), [GrLoggingFormat leaveFormat], __PRETTY_FUNCTION__, ##__VA_ARGS__)
#   define DLog(fmt, ...) DLogFormat((@"%@%s " fmt), [GrLoggingFormat defaultFormat], __PRETTY_FUNCTION__, ##__VA_ARGS__)
#   define DLogLN(fmt, ...) DLogFormat((@"%@:%s " fmt), [GrLoggingFormat lineNumberFormat:__LINE__], __PRETTY_FUNCTION__,  ##__VA_ARGS__)
#else
#   define DLogEnter(...)
#   define DLogLeave(...)
#   define DLog(...)
#   define DLogLN(...)
#endif

// ALog always displays output regardless of the DEBUG setting
#define ALog(fmt, ...) NSLog((@"%s " fmt), __PRETTY_FUNCTION__, ##__VA_ARGS__)
#define ALogLN(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#define FMT_RANGE "{%d,%d}"
#define FMT_RECT "{{%f,%f}{%f,%f}}"
#define FMT_SIZE "{%f,%f}"
#define FMT_POINT "{%f,%f}"

#define PARAM_RECT(r) r.origin.x, r.origin.y, r.size.width, r.size.height
#define PARAM_RANGE(r) r.location, r.length
#define PARAM_SIZE(s) s.width, s.height
#define PARAM_POINT(p) p.x, p.y

#define PARAM_OPT_INT(p) p == NULL ? -1 : *p
#define PARAM_OPT_STR(p) p == NULL ? "" : *p
#define PARAM_OPT_NSTR(p) p == NULL ? @"" : *p
#define PARAM_OPT_RANGE(p) (p == NULL ? NSMakeRange(0,0) : *p)

#endif
