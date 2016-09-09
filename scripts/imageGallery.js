var ImageGallery = {}

function Gallery(viewer, fullsizeViewer, previewSources, fullsizeSources) {
	this.viewer = viewer;
	this.fullsizeViewer = fullsizeViewer;
	this.previewSources = previewSources;
	this.fullsizeSources = fullsizeSources;		
	this.index = 0;
    this.viewer.src = previewSources[this.index]
}

Gallery.prototype.showPreviousImage = function () {
	this.index = Math.max(0, this.index - 1);
	this.viewer.src = this.previewSources[this.index];
};
 
Gallery.prototype.showNextImage = function () {
	this.index = Math.min(this.previewSources.length - 1, this.index + 1);
	this.viewer.src = this.previewSources[this.index];
};

Gallery.prototype.setIndex = function (i) {
	this.index = i;
	this.viewer.src = this.previewSources[this.index];
};

Gallery.prototype.showFullsize = function() {
	this.fullsizeViewer.parentNode.style.display = "block";
	this.fullsizeViewer.focus();

	var img = new Image();
	var viewer = this.fullsizeViewer;
	img.onload = function () {
		viewer.src = this.src;

		if (this.height < window.innerHeight) {
			viewer.style.transform = 'translateY(' + this.height / 2 + 'px)';
		}
	};

	img.src = this.fullsizeSources[this.index];
};

Gallery.prototype.hideFullsize = function () {
	this.fullsizeViewer.src = "";
	this.fullsizeViewer.parentNode.style.display = "none";
};

document.addEventListener("DOMContentLoaded", function () {
        
    var galleries = [];

	galleryConfigs.forEach(function (config) {
		var viewer = document.getElementById(config.viewerId);
		var fullsizeViewer = document.getElementById(config.fullsizeViewerId);
		var gallery = new Gallery(viewer, fullsizeViewer, config.previews, config.fullsizes);
		galleries.push(gallery);

		var list = document.getElementById(config.galleryList);
		config.previews.forEach(function (image, index) {
			var img = new Image();
			img.src = image;

			var listImage = document.createElement("img");
			listImage.src = image;
			listImage.addEventListener('click', function () {
				gallery.setIndex(index);
			}, false);
			list.appendChild(listImage);
		});

		viewer.addEventListener('click', gallery.showFullsize.bind(gallery), false);
		fullsizeViewer.parentNode.addEventListener('click', gallery.hideFullsize.bind(gallery), false);
		fullsizeViewer.addEventListener('keydown', function () {
			galleries.forEach(function (gallery) {
				gallery.hideFullsize();
			});
		}, false);
	});

});


