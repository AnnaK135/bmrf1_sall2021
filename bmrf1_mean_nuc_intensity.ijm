 /*
* ImgageJ macro
* This macro performs chanel-splitting, outlines the nuclei based on the DAPI channel and creates 
*  the nuclei mask for subsequent measuremnet of the mean intensity inside this mask in the BMRF1 channel.
*
* NB:
* to customize settings, enter the paths to the image folders in your system;
* make sure nuclei outlines are precise before preceeding to mean intensity measurement (Ctrl + M);
*/


while (nImages>0) { 
          selectImage(nImages); 
          close(); 
      } 

input = "/Users/annak/Documents/Work/Projects/HIV_TAT/images_b/8/"; 
list = getFileList(input);

for (i = 0; i < list.length; i++){
	print(list[i]);
}


function split_premask(input, filename) {
	open(input + filename);
	title = getTitle();
	run("Split Channels");
	selectImage(title + " (green)");
	close();
	selectImage(title + " (red)");
	setAutoThreshold("Default dark");
	//run("Threshold...");
	//setThreshold(8, 255);
	setOption("BlackBackground", true);
	run("Convert to Mask");
	run("Erode");
	run("Fill Holes");
	run("Fill Holes");
	run("Dilate");
	run("Fill Holes");
	run("Fill Holes");
	run("Dilate");
	run("Fill Holes");
	run("Erode");
	run("Dilate");
	run("Erode");
	run("Fill Holes");
	run("Create Selection");
	roiManager("Add");
}

for (i = 0; i < list.length; i++){
	split_premask(input, list[i]);
}
