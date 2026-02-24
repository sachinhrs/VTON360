from transformers import SegformerImageProcessor, SegformerForSemanticSegmentation
from PIL import Image
import torch
import torch.nn as nn
import numpy as np

def extract_garment(image_path, output_path, labels=[4, 5, 6, 7]):
    processor = SegformerImageProcessor.from_pretrained("mattmdjaga/segformer_b2_clothes")
    model = SegformerForSemanticSegmentation.from_pretrained("mattmdjaga/segformer_b2_clothes")
    model.eval()

    image = Image.open(image_path).convert("RGB")
    inputs = processor(images=image, return_tensors="pt")

    with torch.no_grad():
        outputs = model(**inputs)

    upsampled = nn.functional.interpolate(
        outputs.logits, size=image.size[::-1], mode="bilinear", align_corners=False
    )
    pred_seg = upsampled.argmax(dim=1)[0].numpy()

    mask = np.isin(pred_seg, labels).astype(np.uint8) * 255
    mask_img = Image.fromarray(mask, mode="L")

    result = Image.new("RGB", image.size, (255, 255, 255))
    result.paste(image, mask=mask_img)
    result.save(output_path)
    print(f"Saved to {output_path}")

# Usage
extract_garment("input.jpg", "garment_out.jpg")
