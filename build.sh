# Set info vars.
CURRENT_DATE=$(date +'%Y%m%d')
LOUP_VERSION=3.18.31
ANDROID_VERSION=7.1
FILE_NAME="Ugglite.Kernel-v${LOUP_VERSION}-${ANDROID_VERSION}-${CURRENT_DATE}.zip"

# Delete old stuff.
#rm ~/kernel_flasher/*.zip
#if [ -f ~/kernel_flasher/modules/system/lib/modules/wlan.ko ]; then
#    rm ~/kernel_flasher/modules/system/lib/modules/wlan.ko
#fi

# Start building anykernel zip.
mv ~/kernel_flasher/Image.gz-dtb ~/kernel_flasher/zImage
find . -type f -name "wlan.ko" -exec cp -fv {} ~/kernel_flasher/modules/system/lib/modules/ \;

# Update kernel version
cp ~/kernel_flasher/anykernel-template.sh ~/kernel_flasher/anykernel.sh
sed -i -e "s/LOUP_VERSION/$LOUP_VERSION/g" ~/kernel_flasher/anykernel.sh
sed -i -e "s/ANDROID_VERSION/$ANDROID_VERSION/g" ~/kernel_flasher/anykernel.sh

# Zip it!.
pushd ~/kernel_flasher
zip -r9 ${FILE_NAME} * -x build.sh README.md anykernel-template.sh
popd

# Print final result in color!
GREEN='\033[0;32m'
echo ""
echo -e "${GREEN}> Succeed!, file located at ~/AnyKernel2/$FILE_NAME"
