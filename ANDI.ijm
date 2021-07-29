setBatchMode(true);
//identify directories and create file lists
NeuriteDir = getDirectory("Choose folder with neurite staining");
DapiDir = getDirectory("Choose folder with DAPI staining")
SaveDir = getDirectory("Choose Where to Save");
NeuriteList = getFileList(NeuriteDir);
DapiList = getFileList(DapiDir);
if (NeuriteList.length != DapiList.length) {exit("number of images in two directories is not equal")};
run("Clear Results");
close("*");
//initiate for loop
for (f=0; f<NeuriteList.length; f++){
	//code to prevent errors due to Desktop.ini files
	IniFileIndex = indexOf(DapiDir + DapiList[f],".ini");
	if(IniFileIndex >= 0) {
		print("skipped due to .ini file detection");
		continue;}
	open(DapiDir + DapiList[f]);
	OriDapiImage = getTitle();
	run("8-bit");
	run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixel");
	//run("Brightness/Contrast...");
	setMinAndMax(10, 245);
	run("Apply LUT");
	//make binary and remove particles
	run("Colors...", "foreground=white background=black selection=yellow");
	setOption("BlackBackground", false);
	run("Options...", "iterations=1 count=1");
	run("Make Binary");
	run("Particle Remover", "size=0-10");
	close(OriDapiImage);
	//dilate and erode
	setOption("BlackBackground", false);
	run("Dilate");
	run("Dilate");
	run("Dilate");
	run("Dilate");
	run("Dilate");
	run("Dilate");
	run("Dilate");
	run("Dilate");
	run("Dilate");
	run("Dilate");
	run("Dilate");
	run("Dilate");
	run("Erode");
	run("Erode");
	run("Erode");
	run("Erode");
	run("Erode");
	rename("Y"+f);
	//open neurite image
	open(NeuriteDir + NeuriteList[f]);
	OriNeuriteImage = getTitle();
	//convert image to 8-bit and remove any scale information
	run("8-bit");
	run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixel");
	//contrast enhancement
	setMinAndMax(0, 195);
	run("Apply LUT");
	print("       Cell body removal for " + OriNeuriteImage + "...");
	//image subtraction
	imageCalculator("Subtract create", OriNeuriteImage,"Y"+f);
	//close old images and temporarily rename image with cell bodies removed
	close(OriNeuriteImage);
	close("Y" + f);
	rename("X" + f);
	print("       Binarization of " + OriNeuriteImage + "...");
	//make binary and remove particles
	setOption("BlackBackground", false);
	run("Options...", "iterations=1 count=1");
	run("Make Binary");
	run("Particle Remover", "size=0-4");
	close("X" + f);
	//rename image
	periodindex = indexOf(OriNeuriteImage, ".");
	if(periodindex >= 0) OriNeuriteImage = substring(OriNeuriteImage, 0, periodindex);
	rename(OriNeuriteImage + "_" + "result");
	//take measurements
	print("       Analyzing " + OriNeuriteImage + "...");
	setOption("BlackBackground", false);
	run("Make Binary");
	run("Set Measurements...", "area limit display redirect=None decimal=3");
	run("Measure");
	run("Analyze Particles...", "size=5-10000 circularity=0.20-1.00 show=[Overlay Masks] summarize");
	//save images
	selectWindow(OriNeuriteImage + "_" + "result");
	run("Flatten");
	saveAs("tiff", SaveDir + OriNeuriteImage + "_" + "result");
	close(OriNeuriteImage + "_" + "result");
	print("       Analysis of " + OriNeuriteImage + " complete");
		}
IJ.renameResults("Summary", "Fragmented Neurite Area");
IJ.renameResults("Results", "Total Neurite Area");
selectWindow("Fragmented Neurite Area");
saveAs("Results", SaveDir +"Fragmented_Neurite_Area.csv");
selectWindow("Total Neurite Area");
saveAs("Results", SaveDir + "Total_Neurite_Area.csv");
print("Results have been saved in the selected directory.");
//save result
//saveAs("results", "C:\\Users\\kraemerb\\Desktop\\Dapi Test Folder\\Dir3")
