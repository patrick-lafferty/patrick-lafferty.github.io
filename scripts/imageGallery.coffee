---
---

@ImageGallery = {}

class Gallery
    constructor: (@imageViewer, @fullsizeViewer, @previews, @fullsizes) ->
        @index = 0
        @isShowingFullsize = false
        @imageViewer.src = @previews[@index]

    previousImage: () =>
        @index = Math.max(0, @index - 1)
        @imageViewer.src = @previews[@index]

    nextImage: () =>
        @index = Math.min(@previews.length - 1, @index + 1)
        @imageViewer.src = @previews[@index]

    setIndex: (i) =>
        @index = i
        @imageViewer.src = @previews[@index]
    
    showFullSize: () =>
        @fullsizeViewer.src = @fullsizes[@index]
        @isShowingFullsize = true
        @fullsizeViewer.style.display = "block"
        @fullsizeViewer.focus();

    hideFullsize: () =>
        @fullsizeViewer.src = ""
        @isShowingFullsize = false
        @fullsizeViewer.style.display = "none"

document.addEventListener("DOMContentLoaded", () ->
        
    galleries = []

    clickHandler = (a) ->
        for gallery in galleries
            gallery.hideFullsize()


    for galleryConfig in galleryConfigs
        do (galleryConfig) ->
            viewer = document.getElementById(galleryConfig.viewerId)
            fullsizeViewer = document.getElementById(galleryConfig.fullsizeViewerId)
            gallery = new Gallery(viewer, fullsizeViewer, galleryConfig.previews, galleryConfig.fullsizes)

            galleries.push gallery

            list = document.getElementById(galleryConfig.galleryList)

            index = 0
            for image in galleryConfig.previews
                do (image, index) ->
                    img = new Image()
                    img.src = image
            
                    listImage = document.createElement("img")
                    listImage.src = image
                    listImage.addEventListener('click', 
                        () ->
                            #viewer.src = image
                            gallery.setIndex(index)
                        , false);

                    list.appendChild(listImage) 
                index++
        
            #document.getElementById(galleryConfig.prevImg).addEventListener('click', gallery.previousImage, false);
            #document.getElementById(galleryConfig.nextImg).addEventListener('click', gallery.nextImage, false);
            viewer.addEventListener('click', gallery.showFullSize, false);
            fullsizeViewer.addEventListener('click', gallery.hideFullsize, false); 
            fullsizeViewer.addEventListener('keydown', clickHandler, false); 

);


