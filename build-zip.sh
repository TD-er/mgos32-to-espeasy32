#!/bin/bash

#Philipp "3D" ten Brink
#2023-01-21

#GNU General Public License v3.0 see LICENSE

mkdir output

espeasy_version=$(curl --silent "https://api.github.com/repos/letscontrolit/ESPEasy/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

#Skip download until next release

#curl -o build-files/espeasy-8MB.bin 
#curl -o build-files/espeasy-4MB.bin 

generatezip () {

shelly_device=$1
app_file=$2
boot_file=$3
otadata_file=$4
partition_file=$5

#General:

fs_file="fs-espeasy.img"

#Generated:

build_id=$(date '+%Y%m%d-%H%M%S')
build_date=$(date '+%Y-%m-%dT%H:%M:%SZ')
app_file_size=$(wc -c build-files/$app_file | awk '{print $1}')
app_file_cs1=$(shasum -a1 build-files/$app_file | awk '{print $1}')
app_file_cs256=$(shasum -a256 build-files/$app_file | awk '{print $1}')
boot_file_size=$(wc -c build-files/$boot_file | awk '{print $1}')
boot_file_cs1=$(shasum -a1 build-files/$boot_file | awk '{print $1}')
boot_file_cs256=$(shasum -a256 build-files/$boot_file | awk '{print $1}')
fs_file_size=$(wc -c build-files/$fs_file | awk '{print $1}')
fs_file_cs1=$(shasum -a1 build-files/$fs_file | awk '{print $1}')
fs_file_cs256=$(shasum -a256 build-files/$fs_file | awk '{print $1}')
otadata_file_size=$(wc -c build-files/$otadata_file | awk '{print $1}')
otadata_file_cs1=$(shasum -a1 build-files/$otadata_file | awk '{print $1}')
otadata_file_cs256=$(shasum -a256 build-files/$otadata_file | awk '{print $1}')
partition_file_size=$(wc -c build-files/$partition_file | awk '{print $1}')
partition_file_cs1=$(shasum -a1 build-files/$partition_file | awk '{print $1}')
partition_file_cs256=$(shasum -a256 build-files/$partition_file | awk '{print $1}')

JSON_STRING=$( jq -n \
                    --arg name "$shelly_device" \
                    --arg version "$espeasy_version" \
                    --arg build_id "$build_id/espeasy-$espeasy_version" \
                    --arg build_timestamp "$build_date" \
                    --arg app_file "$app_file" \
                    --argjson app_file_size $app_file_size \
                    --arg app_cs_sha1 "$app_file_cs1" \
                    --arg app_cs_sha256 "$app_file_cs256" \
                    --arg boot_file "$boot_file" \
                    --argjson boot_file_size $boot_file_size \
                    --arg boot_cs_sha1 "$boot_file_cs1" \
                    --arg boot_cs_sha256 "$boot_file_cs256" \
                    --arg fs_file "$fs_file" \
                    --argjson fs_file_size $fs_file_size \
                    --arg fs_cs_sha1 "$fs_file_cs1" \
                    --arg fs_cs_sha256 "$fs_file_cs256" \
                    --arg otadata_file "$otadata_file" \
                    --argjson otadata_file_size $otadata_file_size \
                    --arg otadata_cs_sha1 "$otadata_file_cs1" \
                    --arg otadata_cs_sha256 "$otadata_file_cs256" \
                    --arg partition_file "$partition_file" \
                    --argjson partition_file_size $partition_file_size \
                    --arg partition_cs_sha1 "$partition_file_cs1" \
                    --arg partition_cs_sha256 "$partition_file_cs256" \
'{ "name" : $name, "platform" : "esp32", "version" : $version, "build_id" : $build_id, "build_timestamp" : $build_timestamp, "parts": { "app": { "type": "app", "src": $app_file, "size": $app_file_size, "cs_sha1" : $app_cs_sha1, "cs_sha256" : $app_cs_sha256, "encrypt": true, "ptn": "app_0"}, "boot": { "type": "boot", "src": $boot_file, "addr": 4096, "size": $boot_file_size, "cs_sha1" : $boot_cs_sha1, "cs_sha256": $boot_cs_sha256, "encrypt": true, "update": true }, "fs": { "type": "fs", "src": $fs_file, "size": $fs_file_size, "cs_sha1": $fs_cs_sha1, "cs_sha256": $fs_cs_sha256, "fs_size": $fs_file_size, "encrypt": true, "ptn": "fs_1" }, "nvs": { "type": "nvs", "size": 16384, "fill": 255, "ptn": "nvs" }, "otadata": { "type": "otadata", "src": $otadata_file, "size": $otadata_file_size, "cs_sha1": $otadata_cs_sha1, "cs_sha256": $otadata_cs_sha256, "encrypt": true, "ptn": "otadata"}, "pt": { "type": "pt", "src": $partition_file, "addr": 32768, "size": $partition_file_size, "cs_sha1": $partition_cs_sha1, "cs_sha256": $partition_cs_sha256, "encrypt": true }}}')

printf "$JSON_STRING" > build-files/manifest.json

cd build-files
zip -0 mgos32-to-espeasy32-$shelly_device.zip manifest.json $app_file $boot_file $fs_file $otadata_file $partition_file
mv mgos32-to-espeasy32-$shelly_device.zip ../output/
cd ..

printf "\nDone mgos32-to-espeasy32-$shelly_device.zip\n\n"

} 

ShellyPlus=( PlusHT PlusPlugS PlusPlugIT PlusPlugUS PlusPlugUK PlusI4 PlusWallDimmer Plus1PM Plus1 Plus2PM )
for i in "${ShellyPlus[@]}"
do
    generatezip $i "espeasy-4MB.bin" "bootloader-4MB-espeasy.bin" "otadata-4MB-espeasy.bin" "partition-table-4MB-espeasy.bin"
done

ShellyPro8MB=( Pro1 Pro1PM Pro2 Pro2PM Pro3 Pro4PM )
for i in "${ShellyPro8MB[@]}"
do
    generatezip $i "espeasy-8MB.bin" "bootloader-8MB-espeasy.bin" "otadata-8MB-espeasy.bin" "partition-table-8MB-espeasy.bin"
done

# Skip currently unsupported/untested devices

#ShellyPro16MB=( Pro3EM )
#for i in "${ShellyPro16MB[@]}"
#do
#    generatezip $i "espeasy-16MB.bin" "bootloader-16MB-espeasy.bin" "otadata-16MB-espeasy.bin" "partition-table-16MB-espeasy.bin"
#done