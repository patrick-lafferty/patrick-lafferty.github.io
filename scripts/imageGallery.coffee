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

#window.images = []
#window.imageIndex = 0

#class ImageGallery.Functions
#    @previousImage = () -> 
#        window.imageIndex--
#        if window.imageIndex < 0
#            window.imageIndex = 0
#        document.getElementById("galleryImage").src = window.images[window.imageIndex]
#    
#    @nextImage = () ->
#        window.imageIndex++
#        if window.imageIndex >= window.images.length
#            window.imageIndex = window.images.length - 1
#        document.getElementById("galleryImage").src = window.images[window.imageIndex]
#
#    @setImages = (images) ->
#        window.images = images
#
document.addEventListener("DOMContentLoaded", () ->
        
#    ImageGallery.Functions.setImages(["/images/woodenSphere/planner.png", "/images/woodenSphere/weedingObjectives.png"])
#    document.getElementById("previousImage").addEventListener('click', ImageGallery.Functions.previousImage, false);
#    document.getElementById("nextImage").addEventListener('click', ImageGallery.Functions.nextImage, false);

    for galleryConfig in galleries
        viewer = document.getElementById(galleryConfig.viewerId)
        gallery = new Gallery(viewer, galleryConfig.images)
        #this.galleries.add(gallery)
        document.getElementById(galleryConfig.prevImg).addEventListener('click', gallery.previousImage, false);
        document.getElementById(galleryConfig.nextImg).addEventListener('click', gallery.nextImage, false);
);


