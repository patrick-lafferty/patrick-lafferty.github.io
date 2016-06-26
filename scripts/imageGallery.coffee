---
---

@ImageGallery = {}

class Gallery
    constructor: (@imageViewer, @fullsizeViewer, @previews, @fullsizes) ->
        @index = 0
        @isShowingFullsize = false
        @imageViewer.src = @previews[@index]
        transform = do (@fullsizeViewer) ->
            (height) -> @fullsizeViewer.style.transform = "translateY(" + (window.screen.height/2 + -height/2) + "px)"  
        @fullsizeViewer.addEventListener('load', 
            () ->
                transform(this.height)
            , false)

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
        @isShowingFullsize = true
        @fullsizeViewer.parentNode.style.display = "block"
        @fullsizeViewer.focus()
        @fullsizeViewer.src = @fullsizes[@index]

    hideFullsize: () =>
        @fullsizeViewer.src = ""
        @isShowingFullsize = false
        @fullsizeViewer.parentNode.style.display = "none"

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
                            gallery.setIndex(index)
                        , false);

                    list.appendChild(listImage) 
                index++
        
            viewer.addEventListener('click', gallery.showFullSize, false);
            fullsizeViewer.parentNode.addEventListener('click', gallery.hideFullsize, false); 
            fullsizeViewer.addEventListener('keydown', clickHandler, false); 
);


