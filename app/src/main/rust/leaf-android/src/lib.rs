use jni::{
    objects::{JClass, JString},
    JNIEnv,
};

#[allow(non_snake_case)]
#[no_mangle]
pub unsafe extern "C" fn Java_com_im_im_1lib_LeafVpnService_runLeaf(
    env: JNIEnv,
    _: JClass,
    config_path: JString,
) {
    let config_path = env
        .get_string(config_path)
        .unwrap()
        .to_str()
        .unwrap()
        .to_owned();
    let opts = leaf::StartOptions {
        config: leaf::Config::File(config_path),
        runtime_opt: leaf::RuntimeOption::SingleThread,
    };
    leaf::start(1, opts).unwrap();
}

#[allow(non_snake_case)]
#[no_mangle]
pub unsafe extern "C" fn Java_com_im_im_1lib_LeafVpnService_stopLeaf(
    _: JNIEnv,
    _: JClass,
) {
    leaf::shutdown(1);
}

#[allow(non_snake_case)]
#[no_mangle]
pub unsafe extern "C" fn Java_com_im_im_1lib_LeafVpnService_leafIsRunning(
    _: JNIEnv,
    _: JClass,
) {
    leaf::is_running(1);
}
