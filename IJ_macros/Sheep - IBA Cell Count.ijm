input = getDirectory("Choose Source Directory");
output = getDirectory("Choose Output Directory");

// This measures IBA cell counts

setBatchMode(true);
list = getFileList(input);
for (i = 0; i < list.length; i++) {
  open (input + list[i]);   
  run("Subtract Background...", "rolling=50 light");
  run("Colour Deconvolution", "vectors=[User values] [r1]=0.29724 [g1]=0.43287 [b1]=0.81683 [r2]=0.50630 [g2]=0.79653 [b2]=0.29312 [r3]=0.00653 [g3]=0.97181 [b3]=0.23221");
  setAutoThreshold("Default");
  //run("Threshold...");
  setAutoThreshold("Default");
  setOption("BlackBackground", false);
  run("Convert to Mask");
  run("Analyze Particles...", "size=20.00-200 circularity=0.00-1.00 show=[Nothing] display exclude include summarize");
  run("Close All");

}

  selectWindow("Summary");
  saveAs("Results", output + "IBA Cell Count.xls");	
  run("Clear Results");

//This measures tissue area and saves the output file

setBatchMode(true);
list = getFileList(input);
for (i = 0; i < list.length; i++) {
  open (input + list[i]);    
  run("8-bit");
  setThreshold(0, 254);
  run("Threshold...");
  setOption("BlackBackground", false);
  run("Convert to Mask");
  run("Measure");
  run("Close All");
	
}

  selectWindow("Results");
  saveAs("Results", output + "IBA Tissue Area.xls");
