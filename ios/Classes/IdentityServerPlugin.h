#import <Flutter/Flutter.h>
@protocol OIDExternalUserAgentSession;
@interface IdentityServerPlugin : NSObject<FlutterPlugin>
@property(nonatomic, strong, nullable) id<OIDExternalUserAgentSession> currentAuthorizationFlow;

@end
