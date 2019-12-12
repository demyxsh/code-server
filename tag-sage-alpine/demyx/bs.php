<?php
/**
* AUTO GENERATED
* @package demyx_browsersync
* @version 1.0
*/
/*
Plugin Name: Demyx BrowserSync
Plugin URI: https://demyx.sh/
Description: A static homepage will redirect BrowserSync, this plugin disables that.
Author: Demyx
Version: 1.0
Author URI: https://demyx.sh/
*/
add_filter('redirect_canonical', function ($redirect) {
    if (is_page() && $front_page = get_option('page_on_front')) {
        if (is_page( $front_page)) {
            $redirect = false;
        }
    }
    return $redirect;
});
