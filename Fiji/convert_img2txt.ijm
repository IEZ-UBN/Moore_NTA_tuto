//Intro-------------------------------------------------------------------
//Convert greyscale images from different formats to binary text image 
//Valid input formats include: jpg, png, tif
//Input and output folders must be set at the start of the macro

//------------------------------------------------------------------------
//Defining input and output folders

input = getDir("");
output = getDir("");

//------------------------------------------------------------------------
//Opening files

filelist = getFileList(input);

for (i = 0; i < lengthOf(filelist); i++) {
    if (endsWith(filelist[i], ".tif")) { 
        open(input + filelist[i]);
    } 
    else if (endsWith(filelist[i], ".jpg")) { 
        open(input + filelist[i]);
    }
    else if (endsWith(filelist[i], ".png")) { 
        open(input + filelist[i]);
    }
    else {
    	print("Not an adequate file format");
    }

//------------------------------------------------------------------------
//Make images binary (Black/white)

run("Convert to Mask");
run("Invert");

//------------------------------------------------------------------------
//Exporting images as text files

	saveAs("Text Image", output + filelist[i]);
}

close("*");

