#import "IdentityServerPlugin.h"
#import <identity_server/identity_server-Swift.h>

@implementation IdentityServerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftIdentityServerPlugin registerWithRegistrar:registrar];
}
@end
