---
---

@ImageGallery = {}

class Gallery
    constructor: (@imageViewer, @images) ->
        @index = 0
        @imageViewer.src = @images[@index]

    previousImage: () =>
        @index = Math.max(0, @index - 1)
        @imageViewer.src = @images[@index]

    nextImage: () =>
        @index = Math.min(@images.length - 1, @index + 1)
        @imageViewer.src = @images[@index]

document.addEventListener("DOMContentLoaded", () ->
        
    for galleryConfig in galleries
        viewer = document.getElementById(galleryConfig.viewerId)
        gallery = new Gallery(viewer, galleryConfig.images)

        for image in galleryConfig.images
            img = new Image()
            img.src = image
        
        document.getElementById(galleryConfig.prevImg).addEventListener('click', gallery.previousImage, false);
        document.getElementById(galleryConfig.nextImg).addEventListener('click', gallery.nextImage, false);
);


