## Getting and Cleaning Data Assignment

### How to Run the Analysis

#### Setting up the Working Directory

This section describes how to set up the directory structure so that the R script `run_analysis.R` will generate the proper table.

1. Create a new directory ('folder', if you prefer) and give it a name. (Ex. `my-project`)
2. Place the `run_analysis.R` file in the directory

Example directory structure so far:
```
my-project/
|
|--> run_analysis.R
```

3. Unzip the raw data `.zip` file contents to the project directory.
4. After unzipping the `.zip` file, you should see a new directory inside the project directory. Rename that new directory to `data`. 

Now, the project directory should look like the following example:
```
my-project/
|
|--> run_analysis.R
|--> data/
      |
      |--> activity_labels.txt
      |--> features_info.txt
      ...
      |--> test/
            |
            |--> Inertial Signals/
            |--> subject_test.txt
            ...
      |--> training/
            |--> Inertial Signals/
            |--> subject_train.txt
            ...
```
If your project directory looks similar to the example above, then you should be able to run the `run_analysis.R` script without any problems.

#### Running the R Script

Make sure to set your working directory to the project directory (or source the script in R while inside the project directory). In the R console (or the RStudio console), type:

```
> source('<path-to-project-directory>/run_analysis.R') 
```

If the `data` directory is in the same project directory, the script will automatically generate the tidy data table named `selected_feature_averages_by_subject_and_activity.txt` in the same project directory path as the R script. Please consult the `CodeBook.md` file for details about the tidy data table.

### How the Script Works

The following steps are implemented in the script:
1. Read in the raw data
2. Attach the column names to the raw features
