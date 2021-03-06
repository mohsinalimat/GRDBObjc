#import <sqlite3.h>
#import "FMDatabase+Objc.h"

@implementation FMDatabase(Objc)

- (BOOL)executeUpdate:(NSString *)sql withErrorAndBindings:(NSError **)outErr, ...
{
    va_list args;
    va_start(args, outErr);
    BOOL success = [self executeUpdate:sql va_list:args error:outErr];
    va_end(args);
    return success;
}

- (BOOL)executeUpdate:(NSString * _Nonnull)sql, ...
{
    va_list args;
    va_start(args, sql);
    BOOL success = [self executeUpdate:sql va_list:args error:NULL];
    va_end(args);
    return success;
}

- (BOOL)executeUpdate:(NSString * _Nonnull)sql va_list:(va_list)args error:(NSError **)outErr;
{
    _FMUpdateStatement *statement = [self _makeUpdateStatement:sql error:outErr];
    if (!statement) {
        return NO;
    }
    
    NSMutableArray *arguments = [NSMutableArray array];
    for(int i = sqlite3_bind_parameter_count(statement.sqliteHandle); i > 0; i--) {
        id obj = va_arg(args, id);
        [arguments addObject:obj ?: [NSNull null]];
    }
    return [statement executeWithValues:arguments error:outErr];
}

- (FMResultSet * _Nullable)executeQuery:(NSString * _Nonnull)sql, ...
{
    va_list args;
    va_start(args, sql);
    FMResultSet *resultSet = [self executeQuery:sql va_list:args error:NULL];
    va_end(args);
    return resultSet;
}

- (FMResultSet * _Nullable)executeQuery:(NSString * _Nonnull)sql va_list:(va_list)args error:(NSError **)outErr;
{
    _FMSelectStatement *statement = [self _makeSelectStatement:sql error:outErr];
    if (!statement) {
        return nil;
    }
    
    NSMutableArray *arguments = [NSMutableArray array];
    for(int i = sqlite3_bind_parameter_count(statement.sqliteHandle); i > 0; i--) {
        id obj = va_arg(args, id);
        [arguments addObject:obj ?: [NSNull null]];
    }
    return [statement executeWithValues:arguments error:outErr];
}

@end
