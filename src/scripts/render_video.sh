#! /bin/bash

set -exu
exp_dir="output"
cam_path="demo_data/campath.json"

ckpt_dir="2026-02-19_064415"

ns-render camera-path \
    --camera-path-filename $cam_path \
    --load-config ${exp_dir}/test/splatfactox/${ckpt_dir}/config.yml \
    --output-path ${exp_dir}/video.mp4 \


# 3. render each frame in the video.
ns-render camera-path \
    --output-format images \
    --camera-path-filename $cam_path \
    --load-config ${exp_dir}/test/splatfactox/${ckpt_dir}/config.yml \
    --output-path ${exp_dir}/frames/ \
