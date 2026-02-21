#! /bin/bash
set -exu

# 1. Use 'splatfacto' (standard), NOT 'splatfactox'
ns-train splatfacto \
  --output-dir output \
  --experiment-name test \
  --max-num-iterations 7000 \
  --pipeline.model.cull-alpha-thresh 0.03 \
  --pipeline.datamanager.camera-res-scale-factor 0.33 \
  --pipeline.datamanager.max-thread-workers 1 \
  nerfstudio-data --data demo_data/splatfactox_demo_data


# 2. Update checkpoint path (folder name will now be 'splatfacto')
#ckpt_dir=$(ls output/test/splatfacto | sort -r | head -n 1) 
#config_path="output/test/splatfacto/${ckpt_dir}/config.yml"

# 3. Render
#ns-render camera-path \
#    --camera-path-filename demo_data/campath.json \
#    --load-config "$config_path" \
#    --output-path output/video.mp4
