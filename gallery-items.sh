#!/bin/bash
gallery_items_path=../../../generated/gallery-items
pushd . 
# make the gallery page divs
cd html/gallery/small_images 
rm "$gallery_items_path" 
for i in *.jpg; do
  echo "<div class=\"gallery-item\"><a href=\"gallery/${i/jpg/html}\"><img src=\"gallery/small_images/$i\"></img></a></div>">> "$gallery_items_path";
done
popd

# make the big picture page for each picture
pushd .

backlink="../gallery.html"
forward_link="../gallery.html"

cd html/gallery/images
template_path=../../../gallery-item-template.hppm4
all_images=(*.jpg)
len_images=$((${#all_images[*]}))

# the first one links back to the gallery page
next_img=${all_images[1]}
img=${all_images[0]}
m4 -Dbacklink="../gallery.html" -Dforward_link="${next_img/jpg/html}" -Dimg_src="images/$img" "$template_path" > ../${img/jpg/html} 

for i in $(seq 1 $(($len_images - 2))); do
  prev_img=${all_images[$(($i - 1))]}
  img=${all_images[$i]}
  next_img=${all_images[$(($i + 1))]}
  m4 -Dbacklink="${prev_img/jpg/html}" -Dforward_link="${next_img/jpg/html}" -Dimg_src="images/$img" $template_path > ../${img/jpg/html} 
done

prev_img=${all_images[$(($len_images - 2))]}
img="${all_images[$(($len_images -1))]}"
m4 -Dbacklink="${prev_img/jpg/html}" -Dforward_link="../gallery.html" -Dimg_src="images/$img" $template_path > ../${img/jpg/html} 
popd 
