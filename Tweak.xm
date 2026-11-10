#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <mach-o/dyld.h>
#import <unistd.h>

#define OFFSET_AIM_ASSIST 0x0000000 
#define OFFSET_AIMLOCK_FOV 0x0000000 

void* getBaseAddress() {
    return (void*)_dyld_get_image_header(0);
}

static void ForceAimLock() {
    void* base = getBaseAddress();
    if (!base) return;
    float* fovAddr = (float*)((uintptr_t)base + OFFSET_AIMLOCK_FOV);
    *fovAddr = 360.0f;
}

static void ForceAimAssist() {
    void* base = getBaseAddress();
    if (!base) return;
    bool* aimAddr = (bool*)((uintptr_t)base + OFFSET_AIM_ASSIST);
    *aimAddr = true;
}

__attribute__((constructor))
static void init() {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
            ForceAimLock();
            ForceAimAssist();
            usleep(100000); // 100ms
        }
    });
}
