# kraemerlab
***Please note that the EnhancedDI macro has only been tested for use with a pc running Windows 10.***

Downloading Needed Files
1.	Download the macro file, which is formatted as an .ijm file, to the directory of your choosing.
2.	Download the FIJI package containing ImageJ using the following url: https://imagej.net/software/fiji/ 
      •	Extract the files to the directory of your choosing.
3.	Download the two files associated with the Particle Remover plugin using the following url: https://imagej.nih.gov/ij/plugins/particle-remover.html 
      •	Place both files, Particle_Remover.class and  CustomAnalyzer.class in the Plugins folder of the directory in which ImageJ is installed.
      
Preparation of Images
1.	Use a 20X objective to capture fluorescence images featuring neurons (ie. βIII-tubulin staining) and corresponding images from the same field of view featuring nuclear staining (ie. DAPI staining). 
      •	Capture the image using a resolution with a vertical size of 1024 (ie. 1280 x 1024 or 1024 x 1024). If this cannot be done, software can be used to convert the image to such resolution, but the aspect ratio of the image must be maintained.
2.	Save all neuron images in one directory and all images of nuclear staining in a separate directory.
      •	Ensure that no other files or folders are located in the directories containing the images
      •	Use file names such that, within each directory, the images of nuclear staining are listed in the same order as the corresponding neuron images. The following are example file names that would appropriately list the neuron images and nuclei images in the same order:
      
i.	Example files names for directory containing neuron images:

      1.	062921_Tubulin_Well1_Image1
      2.	070321_Tubulin_Well2_Image1
      3.	070321_Tubulin_Well2_Image2
      
ii.	Example file names for directory containing images of nuclear staining:

      1.	062921_DAPI_Well1_Image1
      2.	070321_DAPI_Well2_Image1
      3.	070321_DAPI_Well2_Image2

Executing the Macro
1.	Open FIJI. 
2.	Click Plugins-->Macros--> Run
3.	Select the EnhancedDI.ijm file that you previously saved to a directory of your choosing, and click “open”
4.	Follow the prompts to choose the directory containing the neuron images and the directory containing the nuclear staining images. 
5.	Choose the folder in which you would like the result files to be saved.
6.	Do not move your mouse or operate other software while the macro executes its operations. When all calculations are complete, the log will display “Results have been saved in the selected directory.”
Calculating the Degeneration Index from the Result Files
1.	Open the result file titled Fragmented_Neurite_Area.csv and the result file titled Total_Neurite_Area.csv.
2.	Divide the values in column C of Fragmented_Neurite_Area.CSV by the corresponding values in column C of the Total_Neurite_Area.csv to obtain the Degeneration Index values of all images.
