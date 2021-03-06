package ${packageName}.utils;

import android.app.Activity;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.support.annotation.ColorInt;
import android.support.annotation.ColorRes;
import android.text.TextUtils;
import android.util.DisplayMetrics;
import android.util.TypedValue;
import android.widget.Toast;

import ${packageName}.App;

/**
 * Put some static functions that can be use everywhere
 * <p>
 */

public class BaseUtil {

    public static String checkNotNull(String origin) {
        return checkNotNull(origin, "");
    }

    /**
     * To avoid null object .
     * If object is null , the function will return a default value
     *
     * @param originValue  value to check
     * @param defaultValue value default
     * @return result value
     */
    public static <T> T checkNotNull(T originValue, T defaultValue) {
        if (null == originValue) {
            return defaultValue;
        } else {
            return originValue;
        }
    }

    public static void showToast(int resId) {
        try {
            showToast(App.getAppContext().getString(resId));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void showToast(String message) {
        if (null != message) {
            Toast.makeText(App.getAppContext(), message, Toast.LENGTH_SHORT).show();
        }
    }

    public static String getString(int strId) {
        String result = "";
        try {
            result = App.getAppContext().getString(strId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static String getVersion() {
        try {
            PackageManager manager = App.getAppContext().getPackageManager();
            PackageInfo info = manager.getPackageInfo(App.getAppContext().getPackageName(), 0);
            return info.versionName;
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    /**
     * Verify the email Address .
     * If return true , the email is OK .
     *
     * @param email target address to verify
     * @return the result
     */
    public static boolean isValidEmail(String email) {
        return !TextUtils.isEmpty(email) && android.util.Patterns.EMAIL_ADDRESS.matcher(email).matches();
    }

    public static boolean isValidPassword(String password) {
        if (TextUtils.isEmpty(password)) {
            return false;
        }
        // todo perfect the rules
        return true;
    }

    public static boolean isValidUserName(String username) {
        if (TextUtils.isEmpty(username)) {
            return false;
        }
        // todo perfect the rules
        return true;
    }

    public static void finishActivity(Context context) {
        try {
            String activityName = context.getClass().getSimpleName();
            if(!ActivityController.isTargetActivityAlive(activityName)){
                return;
            }
            Activity activity = ActivityController.getTargetActivity(activityName);
            activity.finish();
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @ColorInt
    public static int getColorInt(@ColorRes int colorResId){
        return App.getAppContext().getResources().getColor(colorResId);
    }

    public static float dipToPixels(float dipValue) {
        DisplayMetrics metrics = App.getAppContext().getResources().getDisplayMetrics();
        return TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, dipValue, metrics);
    }
}
