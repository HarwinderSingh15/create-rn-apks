current_date=$(date +"%e%b")
current_time=$(date +"%H:%M")

clean_graldew() {
    cd android && ./gradlew clean
}

open_and_rename_build () {
    path=$1
    ext=$2
    # you are in android folder
    cd "app/build/outputs/$path/release" && open . && mv "app-release.$ext" "recover_my_id@$current_date"_"$current_time"."$ext"
}

make_debug_release () {
    clean_graldew && ./gradlew assembleRelease && open_and_rename_build apk apk
}

make_prod_release () {
    echo "************  MAKE SURE YOU HAVE INCREASED BUILD VERSION IN app/build.gradle FILE  **************"
    clean_graldew && ./gradlew bundleRelease && open_and_rename_build bundle aab
}

if [ "$1" == "debug" ]; then
    make_debug_release
elif [ "$1" == "prod" ]; then
    make_prod_release
elif [ "$1" == "clean" ]; then
    clean_graldew && cd ..
else 
    echo "Checkout README.md file if you not no how to run this file"
fi
