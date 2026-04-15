import os
import glob
from PIL import Image

image_dir = '/home/aleblyat/projects/rickyshit/images/images'
os.chdir(image_dir)

for file in glob.glob('*.*'):
    if file.endswith('.jpeg') and file != 'nickelodion_logo.jpeg':
        continue
        
    try:
        img = Image.open(file)
        if img.mode in ("RGBA", "P"):
            img = img.convert("RGB")
            
        base = os.path.splitext(file)[0]
        new_name = base + '.jpeg'
        
        img.save(new_name, 'JPEG')
        
        if file != new_name:
            os.remove(file)
            print(f"Converted {file} to {new_name}")
    except Exception as e:
        print(f"Failed to convert {file}: {e}")
